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
            <fc-designer
                v-if="designerReady"
                ref="designerRef"
                :config="designerConfig"
                :height="designerHeight"
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
    import '@/styles/fc-designer-index.css'
    import '@/styles/fc-designer-icon.css'
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

    /** 顶栏高度，与样式保持一致 */
    const BAR_PX = 48

    export default defineComponent({
        name: 'WorkflowFormDesigner',
        setup() {
            const route = useRoute()
            const router = useRouter()
            const $baseMessage = inject('$baseMessage')
            const $baseConfirm = inject('$baseConfirm')

            const designerRef = ref(null)
            const designerReady = ref(false)
            const designerHeight = ref(600)
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
            const designerConfig = {
                showSaveBtn: false,
                showDevice: true,
                showFormConfig: true,
                showConfig: true,
            }
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

            const syncHeight = () => {
                designerHeight.value = Math.max(window.innerHeight - BAR_PX, 480)
            }

            const getDesignerApi = () => designerRef.value

            const readRules = () => {
                const api = getDesignerApi()
                if (!api?.getRule) return []
                try {
                    return api.getRule() || []
                } catch {
                    return []
                }
            }

            const writeRules = (rules) => {
                const api = getDesignerApi()
                if (!api?.setRule) return
                api.setRule(Array.isArray(rules) ? rules : [])
            }

            const injectDictPropConfig = () => {
                const api = getDesignerApi()
                if (!api?.setComponentRuleConfig) return
                const dictRule = () => [
                    {
                        type: 'input',
                        field: 'props.dictType',
                        title: '系统字典类型',
                        info: '填写字典类型编码，如 sys_user_sex；预览/运行时自动拉取选项',
                    },
                ]
                ;['select', 'radio', 'checkbox', 'cascader'].forEach((id) => {
                    try {
                        api.setComponentRuleConfig(id, dictRule, true)
                    } catch (e) {
                        // ignore
                    }
                })
            }

            const syncCodePanels = async () => {
                const rules = readRules()
                codeJson.value = JSON.stringify(rules, null, 2)
                codeHtml.value = buildHtmlPreviewHint(rules)
                codeVue.value = buildVueSfcSnippet(rules, meta.formCode || 'BizForm')
                previewRule.value = await hydrateDictOptions(rules)
            }

            const applyJsonToDesigner = () => {
                try {
                    const parsed = JSON.parse(codeJson.value || '[]')
                    if (!Array.isArray(parsed)) {
                        $baseMessage('JSON 必须是数组（rule 列表）', 'warning')
                        return
                    }
                    writeRules(parsed)
                    syncCodePanels()
                } catch (e) {
                    $baseMessage('JSON 格式不正确', 'error')
                }
            }

            const loadForm = async () => {
                const id = route.query.id
                if (!id) {
                    $baseMessage('缺少表单 id，请从列表进入设计', 'warning')
                    designerReady.value = true
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
                    syncHeight()
                    designerReady.value = true
                    await nextTick()
                    await nextTick()
                    writeRules(rules)
                    injectDictPropConfig()
                    await syncCodePanels()
                } catch (e) {
                    console.error(e)
                    designerReady.value = true
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
                const rules = attachDictFetch(readRules())
                const formContent = JSON.stringify(rules)
                saving.value = true
                try {
                    const { msg } = await saveFormContent({
                        id: meta.id,
                        formContent,
                    })
                    meta.formContent = formContent
                    meta.formType = 0
                    writeRules(rules)
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
                }
                await syncCodePanels()
                previewVisible.value = true
            }

            const goBack = () => {
                router.push({ path: '/workflow/form' }).catch(() => {
                    router.back()
                })
            }

            watch(viewMode, (mode) => {
                if (mode === 'code') syncCodePanels()
            })

            watch(codeTab, (tab) => {
                if (tab === 'html' || tab === 'vue') syncCodePanels()
            })

            onMounted(() => {
                document.documentElement.classList.add('fc-designer-fullscreen')
                document.body.classList.add('fc-designer-fullscreen')
                syncHeight()
                window.addEventListener('resize', syncHeight)
                loadForm()
            })

            onBeforeUnmount(() => {
                document.documentElement.classList.remove('fc-designer-fullscreen')
                document.body.classList.remove('fc-designer-fullscreen')
                window.removeEventListener('resize', syncHeight)
            })

            return {
                designerRef,
                designerReady,
                designerHeight,
                designerConfig,
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
        min-height: 0 !important;
        overflow: hidden !important;
    }

    .form-designer-page {
        display: flex;
        flex-direction: column;
        box-sizing: border-box;
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
        width: 100%;
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
        position: relative;
        flex: 1 1 auto;
        width: 100%;
        min-height: 0;
        overflow: hidden;
        background: #f5f5f5;
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

    /* ========== FcDesigner 三列：用 grid 钉死，不再依赖 el-container flex ========== */
    .form-designer-page ._fc-designer {
        position: relative !important;
        box-sizing: border-box !important;
        width: 100% !important;
        /* 高度由组件 height 数字 prop 写到 inline style，禁止被 100% !important 覆盖 */
        min-height: 0 !important;
        overflow: hidden !important;
        background: #fff !important;
    }

    .form-designer-page ._fc-designer.el-container {
        /* 外层只有一个 el-main，方向无所谓，保持默认即可 */
        display: block !important;
    }

    .form-designer-page ._fc-designer > .el-main {
        position: absolute !important;
        inset: 0 !important;
        box-sizing: border-box !important;
        padding: 0 !important;
        overflow: hidden !important;
    }

    /* 核心：左 | 中 | 右 */
    .form-designer-page ._fc-designer > .el-main > .el-container {
        display: grid !important;
        grid-template-columns: 266px minmax(0, 1fr) 320px !important;
        grid-template-rows: minmax(0, 1fr) !important;
        align-items: stretch !important;
        box-sizing: border-box !important;
        width: 100% !important;
        height: 100% !important;
        min-height: 0 !important;
        overflow: hidden !important;
        flex-direction: unset !important;
    }

    .form-designer-page ._fc-l,
    .form-designer-page ._fc-l.el-aside {
        grid-column: 1 !important;
        box-sizing: border-box !important;
        width: 266px !important;
        max-width: 266px !important;
        height: 100% !important;
        min-height: 0 !important;
        overflow: hidden !important;
        border-right: 1px solid #ececec !important;
        background: #fff !important;
    }

    .form-designer-page ._fc-m,
    .form-designer-page ._fc-m.el-container {
        grid-column: 2 !important;
        display: flex !important;
        flex-direction: column !important;
        box-sizing: border-box !important;
        width: auto !important;
        min-width: 0 !important;
        height: 100% !important;
        min-height: 0 !important;
        overflow: hidden !important;
        background: #f5f5f5 !important;
    }

    .form-designer-page ._fc-r,
    .form-designer-page ._fc-r.el-aside {
        grid-column: 3 !important;
        box-sizing: border-box !important;
        width: 320px !important;
        max-width: 320px !important;
        height: 100% !important;
        min-height: 0 !important;
        overflow: hidden !important;
        border-left: 1px solid #ececec !important;
        background: #fff !important;
    }

    .form-designer-page ._fc-l > .el-container,
    .form-designer-page ._fc-r > .el-container {
        display: flex !important;
        flex-direction: column !important;
        height: 100% !important;
        min-height: 0 !important;
        overflow: hidden !important;
    }

    .form-designer-page ._fc-l > .el-container > .el-main,
    .form-designer-page ._fc-r > .el-container > .el-main {
        flex: 1 1 auto !important;
        min-height: 0 !important;
        overflow: auto !important;
    }

    .form-designer-page ._fc-m-tools,
    .form-designer-page ._fc-m > .el-header {
        flex: 0 0 40px !important;
        height: 40px !important;
        overflow: hidden !important;
        background: #fff !important;
    }

    .form-designer-page ._fc-m > .el-main,
    .form-designer-page ._fc-m-con {
        flex: 1 1 auto !important;
        min-height: 0 !important;
        overflow: auto !important;
        background: #f5f5f5 !important;
    }

    /* 画布拖拽区：保证可见可投放 */
    .form-designer-page ._fc-m-drag {
        box-sizing: border-box !important;
        width: 100% !important;
        min-height: calc(100% - 8px) !important;
        height: auto !important;
        padding: 8px !important;
        background: #fff !important;
        border: 1px dashed #c0c4cc !important;
        border-radius: 4px !important;
    }

    .form-designer-page ._fd-draggable-drag,
    .form-designer-page ._fd-draggable-drag.drag-holder {
        box-sizing: border-box !important;
        width: 100% !important;
        min-height: 360px !important;
    }

    .form-designer-page ._fd-draggable-drag.drag-holder:after {
        font-size: 16px !important;
        color: #909399 !important;
    }
</style>
