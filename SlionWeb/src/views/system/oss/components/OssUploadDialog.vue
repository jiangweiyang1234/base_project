<template>
    <el-dialog
        v-model="visible"
        :close-on-click-modal="!hasUploading"
        :close-on-press-escape="!hasUploading"
        destroy-on-close
        title="上传文件"
        width="720px"
        @closed="handleClosed"
    >
        <el-upload
            ref="uploadRef"
            :auto-upload="false"
            :disabled="hasUploading"
            drag
            multiple
            :on-change="handleChange"
            :on-remove="handleRemove"
            :show-file-list="false"
        >
            <el-icon class="el-icon--upload"><upload-filled /></el-icon>
            <div class="el-upload__text">
                将文件拖到此处，或<em>点击选择</em>（支持多选）
            </div>
            <template #tip>
                <div class="el-upload__tip">
                    单文件默认上限以服务端 multipart 配置为准；上传中可单独中止。
                </div>
            </template>
        </el-upload>

        <div v-if="tasks.length" class="oss-upload-list">
            <div
                v-for="task in tasks"
                :key="task.uid"
                class="oss-upload-item"
            >
                <div class="oss-upload-item__head">
                    <span class="oss-upload-item__name" :title="task.name">
                        {{ task.name }}
                    </span>
                    <span class="oss-upload-item__meta">
                        {{ formatSize(task.size) }}
                        <template v-if="task.status === 'uploading'">
                            · {{ formatSpeed(task.speed) }}
                        </template>
                    </span>
                    <el-tag
                        :type="statusTagType(task.status)"
                        size="small"
                        effect="plain"
                    >
                        {{ statusText(task.status) }}
                    </el-tag>
                </div>
                <div class="oss-upload-item__body">
                    <el-progress
                        :percentage="task.percent"
                        :status="progressStatus(task.status)"
                        :stroke-width="10"
                    />
                    <el-button
                        v-if="task.status === 'uploading' || task.status === 'pending'"
                        link
                        type="danger"
                        @click="abortTask(task)"
                    >
                        中止
                    </el-button>
                    <el-button
                        v-else-if="task.status === 'error' || task.status === 'aborted'"
                        link
                        type="primary"
                        @click="retryTask(task)"
                    >
                        重试
                    </el-button>
                    <el-button
                        v-else
                        link
                        type="info"
                        @click="removeTask(task)"
                    >
                        移除
                    </el-button>
                </div>
                <div v-if="task.message" class="oss-upload-item__msg">
                    {{ task.message }}
                </div>
            </div>
        </div>

        <template #footer>
            <div class="oss-upload-footer">
                <span v-if="tasks.length" class="oss-upload-footer__stat">
                    共 {{ tasks.length }} 个 · 成功 {{ successCount }} · 失败
                    {{ failCount }} · 上传中 {{ uploadingCount }}
                </span>
                <div>
                    <el-button :disabled="hasUploading" @click="visible = false">
                        关 闭
                    </el-button>
                    <el-button
                        v-if="hasUploading"
                        type="danger"
                        @click="abortAll"
                    >
                        全部中止
                    </el-button>
                    <el-button
                        :disabled="!pendingCount || hasUploading"
                        type="primary"
                        @click="startUpload"
                    >
                        开始上传
                    </el-button>
                </div>
            </div>
        </template>
    </el-dialog>
</template>

<script>
    import { UploadFilled } from '@element-plus/icons-vue'
    import { uploadOss } from '@/api/system/oss'

    const CONCURRENCY = 3

    function createTask(raw) {
        return {
            uid: raw.uid,
            name: raw.name,
            size: raw.size || 0,
            raw,
            status: 'pending',
            percent: 0,
            speed: 0,
            message: '',
            controller: null,
            _lastLoaded: 0,
            _lastTime: 0,
        }
    }

    export default defineComponent({
        name: 'OssUploadDialog',
        components: { UploadFilled },
        emits: ['success'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const visible = ref(false)
            const uploadRef = ref(null)
            const tasks = ref([])
            let queueRunning = false
            let anySucceeded = false

            const pendingCount = computed(
                () => tasks.value.filter((t) => t.status === 'pending').length
            )
            const uploadingCount = computed(
                () => tasks.value.filter((t) => t.status === 'uploading').length
            )
            const successCount = computed(
                () => tasks.value.filter((t) => t.status === 'success').length
            )
            const failCount = computed(
                () =>
                    tasks.value.filter(
                        (t) => t.status === 'error' || t.status === 'aborted'
                    ).length
            )
            const hasUploading = computed(() => uploadingCount.value > 0)

            const formatSize = (bytes = 0) => {
                if (bytes < 1024) return `${bytes} B`
                if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`
                return `${(bytes / 1024 / 1024).toFixed(2)} MB`
            }

            const formatSpeed = (bps = 0) => {
                if (!bps || bps < 0) return '0 B/s'
                if (bps < 1024) return `${Math.round(bps)} B/s`
                if (bps < 1024 * 1024) return `${(bps / 1024).toFixed(1)} KB/s`
                return `${(bps / 1024 / 1024).toFixed(2)} MB/s`
            }

            const statusText = (status) =>
                ({
                    pending: '待上传',
                    uploading: '上传中',
                    success: '成功',
                    error: '失败',
                    aborted: '已中止',
                })[status] || status

            const statusTagType = (status) =>
                ({
                    pending: 'info',
                    uploading: 'warning',
                    success: 'success',
                    error: 'danger',
                    aborted: 'info',
                })[status] || 'info'

            const progressStatus = (status) => {
                if (status === 'success') return 'success'
                if (status === 'error' || status === 'aborted') return 'exception'
                return undefined
            }

            const show = () => {
                anySucceeded = false
                tasks.value = []
                visible.value = true
            }

            const handleClosed = () => {
                abortAll()
                tasks.value = []
                uploadRef.value?.clearFiles?.()
                if (anySucceeded) emit('success')
            }

            const handleChange = (file) => {
                if (!file?.raw) return
                if (tasks.value.some((t) => t.uid === file.uid)) return
                tasks.value.push(createTask(file))
            }

            const handleRemove = (file) => {
                const idx = tasks.value.findIndex((t) => t.uid === file.uid)
                if (idx >= 0 && tasks.value[idx].status === 'pending') {
                    tasks.value.splice(idx, 1)
                }
            }

            const removeTask = (task) => {
                tasks.value = tasks.value.filter((t) => t.uid !== task.uid)
            }

            const abortTask = (task) => {
                if (task.controller) {
                    task.controller.abort()
                }
                if (task.status === 'pending') {
                    task.status = 'aborted'
                    task.message = '已中止'
                }
            }

            const abortAll = () => {
                tasks.value.forEach((t) => {
                    if (t.status === 'uploading' || t.status === 'pending') {
                        abortTask(t)
                    }
                })
            }

            const retryTask = (task) => {
                task.status = 'pending'
                task.percent = 0
                task.speed = 0
                task.message = ''
                task.controller = null
                task._lastLoaded = 0
                task._lastTime = 0
                startUpload()
            }

            const uploadOne = async (task) => {
                // 调用方已将 status 置为 uploading（认领任务，避免并发队列重复领取）
                task.percent = 0
                task.speed = 0
                task.message = ''
                task.controller = new AbortController()
                task._lastLoaded = 0
                task._lastTime = Date.now()

                const form = new FormData()
                form.append('file', task.raw.raw || task.raw)

                try {
                    const res = await uploadOss(form, {
                        signal: task.controller.signal,
                        onUploadProgress: (event) => {
                            const total = event.total || task.size || 0
                            const loaded = event.loaded || 0
                            if (total > 0) {
                                task.percent = Math.min(
                                    99,
                                    Math.round((loaded / total) * 100)
                                )
                            }
                            const now = Date.now()
                            const dt = (now - task._lastTime) / 1000
                            if (dt >= 0.3) {
                                task.speed = (loaded - task._lastLoaded) / dt
                                task._lastLoaded = loaded
                                task._lastTime = now
                            }
                        },
                    })
                    if (
                        !res ||
                        (res.code !== undefined &&
                            res.code !== 200 &&
                            res.code !== 0 &&
                            res.code !== '200' &&
                            res.code !== '0')
                    ) {
                        throw new Error(res?.msg || '上传失败')
                    }
                    if (!res.data?.ossId && !res.data?.url) {
                        throw new Error(res?.msg || '上传失败：未返回文件信息')
                    }
                    task.percent = 100
                    task.speed = 0
                    task.status = 'success'
                    task.message = res.msg || '上传成功'
                    anySucceeded = true
                } catch (e) {
                    const canceled =
                        e?.code === 'ERR_CANCELED' ||
                        e?.name === 'CanceledError' ||
                        e?.message === 'canceled'
                    if (canceled) {
                        task.status = 'aborted'
                        task.message = '已中止'
                    } else {
                        task.status = 'error'
                        task.message =
                            e?.msg ||
                            e?.message ||
                            '上传失败，请检查对象存储配置'
                    }
                    task.speed = 0
                } finally {
                    task.controller = null
                }
            }

            const claimNext = () => {
                const next = tasks.value.find((t) => t.status === 'pending')
                if (!next) return null
                next.status = 'uploading'
                return next
            }

            const pumpQueue = async () => {
                if (queueRunning) return
                queueRunning = true
                try {
                    const runNext = async () => {
                        while (true) {
                            const next = claimNext()
                            if (!next) break
                            await uploadOne(next)
                        }
                    }
                    await Promise.all(
                        Array.from({ length: CONCURRENCY }, () => runNext())
                    )
                } finally {
                    queueRunning = false
                    if (successCount.value > 0 && uploadingCount.value === 0) {
                        $baseMessage(
                            `上传完成：成功 ${successCount.value}，失败 ${failCount.value}`,
                            failCount.value ? 'warning' : 'success',
                            failCount.value
                                ? 'vab-hey-message-warning'
                                : 'vab-hey-message-success'
                        )
                    }
                }
            }

            const startUpload = () => {
                if (!pendingCount.value) {
                    $baseMessage('请先选择文件', 'warning', 'vab-hey-message-warning')
                    return
                }
                pumpQueue()
            }

            return {
                visible,
                uploadRef,
                tasks,
                pendingCount,
                uploadingCount,
                successCount,
                failCount,
                hasUploading,
                show,
                handleClosed,
                handleChange,
                handleRemove,
                removeTask,
                abortTask,
                abortAll,
                retryTask,
                startUpload,
                formatSize,
                formatSpeed,
                statusText,
                statusTagType,
                progressStatus,
            }
        },
    })
</script>

<style scoped>
    .oss-upload-list {
        max-height: 360px;
        margin-top: 12px;
        overflow: auto;
    }

    .oss-upload-item {
        padding: 10px 12px;
        margin-bottom: 8px;
        border: 1px solid #ebeef5;
        border-radius: 6px;
        background: #fafafa;
    }

    .oss-upload-item__head {
        display: flex;
        gap: 8px;
        align-items: center;
        margin-bottom: 6px;
    }

    .oss-upload-item__name {
        flex: 1;
        overflow: hidden;
        font-size: 13px;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .oss-upload-item__meta {
        color: #909399;
        font-size: 12px;
        white-space: nowrap;
    }

    .oss-upload-item__body {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    .oss-upload-item__body .el-progress {
        flex: 1;
    }

    .oss-upload-item__msg {
        margin-top: 4px;
        color: #909399;
        font-size: 12px;
    }

    .oss-upload-footer {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        width: 100%;
    }

    .oss-upload-footer__stat {
        color: #909399;
        font-size: 12px;
    }
</style>
