<template>
    <el-dialog
        v-model="dialogFormVisible"
        title="Excel导入MAC地址"
        width="560px"
        @close="close"
    >
        <el-alert
            :closable="false"
            show-icon
            title="请先下载导入模板，按模板填写MAC地址后上传。部分设备仅有一个MAC地址，MAC地址2可留空。"
            type="info"
        />
        <div class="upload-actions">
            <el-button :icon="Download" type="primary" @click="handleDownloadTemplate">
                下载模板
            </el-button>
        </div>
        <el-upload
            ref="uploadRef"
            accept=".xlsx,.xls"
            :auto-upload="false"
            :limit="1"
            :on-change="handleFileChange"
            :on-exceed="handleExceed"
            :on-remove="handleFileRemove"
        >
            <template #trigger>
                <el-button :icon="Upload" type="primary">选择文件</el-button>
            </template>
            <template #tip>
                <div class="el-upload__tip">仅支持 xls、xlsx 格式文件</div>
            </template>
        </el-upload>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button
                :loading="uploading"
                type="primary"
                @click="handleUpload"
            >
                开始导入
            </el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { Download, Upload } from '@element-plus/icons-vue'
    import { getImportTemplate, importExcel } from '@/api/biz/deviceMacImport'

    export default defineComponent({
        name: 'DeviceMacImportUpload',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                uploadRef: null,
                dialogFormVisible: false,
                uploading: false,
                selectedFile: null,
            })

            const showUpload = () => {
                state.dialogFormVisible = true
            }

            const close = () => {
                state.selectedFile = null
                state.uploadRef?.clearFiles()
                state.dialogFormVisible = false
            }

            const handleFileChange = (file) => {
                state.selectedFile = file.raw
            }

            const handleFileRemove = () => {
                state.selectedFile = null
            }

            const handleExceed = () => {
                $baseMessage(
                    '每次仅支持上传一个文件',
                    'warning',
                    'vab-hey-message-warning'
                )
            }

            const handleDownloadTemplate = async () => {
                try {
                    const blob = await getImportTemplate()
                    const url = window.URL.createObjectURL(new Blob([blob]))
                    const link = document.createElement('a')
                    link.href = url
                    link.download = 'deviceMacImport_template.xlsx'
                    link.click()
                    window.URL.revokeObjectURL(url)
                } catch (error) {
                    $baseMessage(
                        '模板下载失败',
                        'error',
                        'vab-hey-message-error'
                    )
                }
            }

            const handleUpload = async () => {
                if (!state.selectedFile) {
                    $baseMessage(
                        '请先选择导入文件',
                        'warning',
                        'vab-hey-message-warning'
                    )
                    return
                }

                state.uploading = true
                try {
                    const formData = new FormData()
                    formData.append('file', state.selectedFile)
                    const { msg } = await importExcel(formData)
                    $baseMessage(msg, 'success', 'vab-hey-message-success')
                    emit('fetch-data')
                    close()
                } finally {
                    state.uploading = false
                }
            }

            return {
                ...toRefs(state),
                showUpload,
                close,
                handleFileChange,
                handleFileRemove,
                handleExceed,
                handleDownloadTemplate,
                handleUpload,
                Download,
                Upload,
            }
        },
    })
</script>

<style type="text/css">
    .upload-actions {
        margin: 16px 0;
    }
</style>
