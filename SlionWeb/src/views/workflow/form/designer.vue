<template>
    <div class="form-designer-page">
        <header class="form-designer-page__bar">
            <div class="form-designer-page__left">
                <el-button text type="primary" @click="goBack">返回</el-button>
                <span class="form-designer-page__title">
                    {{ meta.formName || '表单设计' }}
                    <el-tag v-if="meta.formCode" size="small" style="margin-left: 8px">
                        {{ meta.formCode }}
                    </el-tag>
                </span>
            </div>
            <div class="form-designer-page__actions">
                <el-radio-group v-model="viewMode" size="small">
                    <el-radio-button value="design">设计</el-radio-button>
                    <el-radio-button value="code">代码</el-radio-button>
                </el-radio-group>
                <el-button @click="handlePreview">预览</el-button>
                <el-button :loading="saving" type="primary" @click="handleSave">
                    保存
                </el-button>
            </div>
        </header>

        <div v-show="viewMode === 'design'" class="form-designer-page__canvas">
            <iframe
                ref="frameRef"
                class="form-designer-page__frame"
                :src="hostSrc"
                title="表单设计器"
                @load="onFrameLoad"
            />
        </div>

        <div v-show="viewMode === 'code'" class="form-designer-page__code">
            <el-tabs v-model="codeTab">
                <el-tab-pane label="JSON" name="json">
                    <el-input
                        v-model="codeJson"
                        class="form-designer-page__editor"
                        type="textarea"
                        @blur="applyJsonToDesigner"
                    />
                </el-tab-pane>
                <el-tab-pane label="HTML" name="html">
                    <el-alert
                        :closable="false"
                        show-icon
                        style="margin-bottom: 12px"
                        title="HTML 由 form-create 根据 JSON 动态渲染；下方为结构提示与实时预览"
                        type="info"
                    />
                    <el-input
                        v-model="codeHtml"
                        class="form-designer-page__editor form-designer-page__editor--sm"
                        readonly
                        type="textarea"
                    />
                    <div class="form-designer-page__preview-box">
                        <form-create
                            v-if="previewRule.length"
                            :option="previewOption"
                            :rule="previewRule"
                        />
                        <el-empty v-else description="暂无字段，请先在设计模式添加控件" />
                    </div>
                </el-tab-pane>
                <el-tab-pane label="Vue" name="vue">
                    <el-input
                        v-model="codeVue"
                        class="form-designer-page__editor"
                        readonly
                        type="textarea"
                    />
                </el-tab-pane>
            </el-tabs>
        </div>

        <el-dialog
            v-model="previewVisible"
            append-to-body
            destroy-on-close
            title="表单预览"
            width="720px"
        >
            <form-create
                v-if="previewRule.length"
                :option="previewOption"
                :rule="previewRule"
            />
            <el-empty v-else description="暂无字段" />
        </el-dialog>
    </div>
</template>

<script>
    import {
        getForm,
        saveFormContent,
    } from '@/api/workflow/form'
    import {
        buildHtmlPreviewHint,
        buildVueSfcSnippet,
        attachDictFetch,
        hydrateDictOptions,
    } from '@/utils/formDesigner'

    let requestSeq = 0

    export default defineComponent({
        name: 'WorkflowFormDesigner',
        setup() {
            const route = useRoute()
            const router = useRouter()
            const $baseMessage = inject('$baseMessage')
            const $baseConfirm = inject('$baseConfirm')

            const frameRef = ref(null)
            const hostReady = ref(false)
            const pendingRules = ref([])
            const pendingRequests = new Map()
            const saving = ref(false)
            const viewMode = ref('design')
            const codeTab = ref('json')
            const codeJson = ref('[]')
            const codeHtml = ref('')
            const codeVue = ref('')
            const previewVisible = ref(false)
            const previewRule = ref([])
            const previewOption = reactive({
                form: { labelWidth: '100px' },
                submitBtn: false,
                resetBtn: false,
            })
            const meta = reactive({
                id: undefined,
                formCode: '',
                formName: '',
                formType: 0,
                formPath: '',
                formContent: '',
                isPublish: 0,
                ext: '',
                version: '',
            })

            // 独立宿主页（无 VAB 样式），与主站同域；publicPath 为空时用相对路径
            const hostSrc = computed(() => {
                const base = process.env.BASE_URL || ''
                if (!base || base === '/') return 'form-designer-host.html'
                const prefix = base.endsWith('/') ? base : `${base}/`
                return `${prefix}form-designer-host.html`
            })

            const postToHost = (type, payload = {}) => {
                const win = frameRef.value?.contentWindow
                if (!win) return
                win.postMessage({ target: 'fc-designer-host', type, ...payload }, '*')
            }

            const syncRulesToHost = (rules) => {
                pendingRules.value = Array.isArray(rules) ? rules : []
                if (hostReady.value) {
                    postToHost('setRule', { rules: pendingRules.value })
                }
            }

            const requestRulesFromHost = () => {
                if (!hostReady.value) {
                    return Promise.resolve(pendingRules.value || [])
                }
                const requestId = `r-${++requestSeq}`
                return new Promise((resolve) => {
                    const timer = setTimeout(() => {
                        pendingRequests.delete(requestId)
                        resolve(pendingRules.value || [])
                    }, 3000)
                    pendingRequests.set(requestId, (rules) => {
                        clearTimeout(timer)
                        resolve(rules)
                    })
                    postToHost('getRule', { requestId })
                })
            }

            const onHostMessage = (event) => {
                const data = event?.data
                if (!data || data.source !== 'fc-designer-host') return
                if (data.type === 'ready' || data.type === 'pong') {
                    hostReady.value = true
                    postToHost('setRule', { rules: pendingRules.value || [] })
                    return
                }
                if (data.type === 'rule') {
                    const cb = pendingRequests.get(data.requestId)
                    if (cb) {
                        pendingRequests.delete(data.requestId)
                        const rules = Array.isArray(data.rules) ? data.rules : []
                        pendingRules.value = rules
                        cb(rules)
                    }
                }
            }

            const onFrameLoad = () => {
                // ready 由宿主 postMessage 上报；这里仅兜底 ping
                postToHost('ping')
            }

            const syncCodePanels = async (rules) => {
                const list = Array.isArray(rules) ? rules : pendingRules.value || []
                codeJson.value = JSON.stringify(list, null, 2)
                codeHtml.value = buildHtmlPreviewHint(list)
                codeVue.value = buildVueSfcSnippet(list, meta.formCode || 'BizForm')
                previewRule.value = await hydrateDictOptions(list)
            }

            const applyJsonToDesigner = () => {
                try {
                    const parsed = JSON.parse(codeJson.value || '[]')
                    if (!Array.isArray(parsed)) {
                        $baseMessage('JSON 必须是数组（rule 列表）', 'warning')
                        return
                    }
                    syncRulesToHost(parsed)
                    syncCodePanels(parsed)
                } catch (e) {
                    $baseMessage('JSON 格式不正确', 'error')
                }
            }

            const loadForm = async () => {
                const id = route.query.id
                if (!id) {
                    $baseMessage('缺少表单 id，请从列表进入设计', 'warning')
                    return
                }
                try {
                    const { data } = await getForm(id)
                    Object.assign(meta, data || {})
                    let rules = []
                    if (data?.formContent) {
                        try {
                            const parsed = JSON.parse(data.formContent)
                            rules = Array.isArray(parsed)
                                ? parsed
                                : parsed?.rule || []
                        } catch {
                            rules = []
                        }
                    }
                    syncRulesToHost(rules)
                    await syncCodePanels(rules)
                } catch (e) {
                    console.error(e)
                }
            }

            const handleSave = async () => {
                if (!meta.id) {
                    $baseMessage('缺少表单 id', 'warning')
                    return
                }
                if (meta.isPublish === 1) {
                    $baseConfirm(
                        '表单已发布，需先取消发布才能保存设计，是否返回列表？',
                        null,
                        () => goBack()
                    )
                    return
                }
                if (viewMode.value === 'code' && codeTab.value === 'json') {
                    applyJsonToDesigner()
                }
                saving.value = true
                try {
                    const raw = await requestRulesFromHost()
                    const rules = attachDictFetch(raw)
                    const formContent = JSON.stringify(rules)
                    const { msg } = await saveFormContent({
                        id: meta.id,
                        formContent,
                    })
                    meta.formContent = formContent
                    meta.formType = 0
                    syncRulesToHost(rules)
                    await syncCodePanels(rules)
                    $baseMessage(msg || '保存成功', 'success', 'vab-hey-message-success')
                } catch (e) {
                    console.error(e)
                } finally {
                    saving.value = false
                }
            }

            const handlePreview = async () => {
                if (viewMode.value === 'code' && codeTab.value === 'json') {
                    applyJsonToDesigner()
                } else {
                    const rules = await requestRulesFromHost()
                    await syncCodePanels(rules)
                }
                previewVisible.value = true
            }

            const goBack = () => {
                router.push({ path: '/workflow/form' }).catch(() => {
                    router.back()
                })
            }

            watch(viewMode, async (mode) => {
                if (mode === 'code') {
                    const rules = await requestRulesFromHost()
                    await syncCodePanels(rules)
                }
            })

            watch(codeTab, async (tab) => {
                if (tab === 'html' || tab === 'vue') {
                    const rules = await requestRulesFromHost()
                    await syncCodePanels(rules)
                }
            })

            onMounted(() => {
                document.documentElement.classList.add('fc-designer-fullscreen')
                document.body.classList.add('fc-designer-fullscreen')
                window.addEventListener('message', onHostMessage)
                loadForm()
            })

            onBeforeUnmount(() => {
                document.documentElement.classList.remove('fc-designer-fullscreen')
                document.body.classList.remove('fc-designer-fullscreen')
                window.removeEventListener('message', onHostMessage)
            })

            return {
                frameRef,
                hostSrc,
                saving,
                viewMode,
                codeTab,
                codeJson,
                codeHtml,
                codeVue,
                previewVisible,
                previewRule,
                previewOption,
                meta,
                goBack,
                handleSave,
                handlePreview,
                applyJsonToDesigner,
                onFrameLoad,
            }
        },
    })
</script>

<style lang="scss">
    html.fc-designer-fullscreen,
    body.fc-designer-fullscreen {
        width: 100% !important;
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
        background: #fff !important;
    }

    body.fc-designer-fullscreen #app {
        width: 100% !important;
        height: 100% !important;
        overflow: hidden !important;
    }

    .form-designer-page {
        display: flex;
        flex-direction: column;
        width: 100vw;
        height: 100vh;
        margin: 0;
        padding: 0;
        overflow: hidden;
        background: #fff;
    }

    .form-designer-page__bar {
        z-index: 2;
        display: flex;
        flex: 0 0 48px;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        box-sizing: border-box;
        height: 48px;
        padding: 0 12px;
        background: #fff;
        border-bottom: 1px solid #e7e7e7;
    }

    .form-designer-page__left {
        display: flex;
        align-items: center;
        gap: 4px;
        min-width: 0;
    }

    .form-designer-page__title {
        overflow: hidden;
        color: #1a1a1a;
        font-size: 14px;
        font-weight: 600;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .form-designer-page__actions {
        display: flex;
        flex-shrink: 0;
        align-items: center;
        gap: 8px;
    }

    .form-designer-page__canvas {
        flex: 1 1 auto;
        width: 100%;
        min-height: 0;
        overflow: hidden;
        background: #f5f5f5;
    }

    .form-designer-page__frame {
        display: block;
        width: 100%;
        height: 100%;
        border: 0;
        background: #fff;
    }

    .form-designer-page__code {
        flex: 1;
        min-height: 0;
        padding: 12px 16px 16px;
        overflow: auto;
        background: #fff;
    }

    .form-designer-page__editor textarea {
        min-height: 420px;
        font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas,
            monospace;
        line-height: 1.5;
    }

    .form-designer-page__editor--sm textarea {
        min-height: 120px;
    }

    .form-designer-page__preview-box {
        margin-top: 12px;
        padding: 16px;
        border: 1px dashed #d0d5dd;
        border-radius: 8px;
        background: #fafafa;
    }
</style>
