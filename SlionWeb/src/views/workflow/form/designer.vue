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
            <fc-designer ref="designerRef" height="100%" />
        </div>

        <div v-show="viewMode === 'code'" class="form-designer-page__code">
            <el-tabs v-model="codeTab" class="form-designer-page__tabs">
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
                        title="HTML 由 form-create 根据 JSON 动态渲染；下方为结构提示与实时预览"
                        type="info"
                        style="margin-bottom: 12px"
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

    export default defineComponent({
        name: 'WorkflowFormDesigner',
        setup() {
            const route = useRoute()
            const router = useRouter()
            const $baseMessage = inject('$baseMessage')
            const $baseConfirm = inject('$baseConfirm')

            const designerRef = ref(null)
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
                        // ignore unsupported component id
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
                    return
                }
                const { data } = await getForm(id)
                Object.assign(meta, data || {})
                let rules = []
                if (data?.formContent) {
                    try {
                        const parsed = JSON.parse(data.formContent)
                        rules = Array.isArray(parsed) ? parsed : parsed?.rule || []
                    } catch {
                        rules = []
                    }
                }
                await nextTick()
                writeRules(rules)
                injectDictPropConfig()
                await syncCodePanels()
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
                loadForm()
            })

            return {
                designerRef,
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

<style lang="scss" scoped>
    .form-designer-page {
        display: flex;
        flex-direction: column;
        height: calc(100vh - 120px);
        min-height: 560px;
        margin: -20px;
        background: #f3f3f3;
    }

    .form-designer-page__bar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        height: 52px;
        padding: 0 16px;
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
        font-size: 15px;
        font-weight: 600;
        color: #1a1a1a;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .form-designer-page__actions {
        display: flex;
        align-items: center;
        gap: 10px;
        flex-shrink: 0;
    }

    .form-designer-page__canvas {
        flex: 1;
        min-height: 0;
        overflow: hidden;
    }

    .form-designer-page__code {
        flex: 1;
        min-height: 0;
        padding: 12px 16px 16px;
        overflow: auto;
        background: #fff;
    }

    .form-designer-page__editor {
        font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas,
            monospace;

        :deep(textarea) {
            min-height: 420px;
            font-family: inherit;
            line-height: 1.5;
        }

        &--sm :deep(textarea) {
            min-height: 120px;
        }
    }

    .form-designer-page__preview-box {
        margin-top: 12px;
        padding: 16px;
        border: 1px dashed #d0d5dd;
        border-radius: 8px;
        background: #fafafa;
    }

    :deep(.fc-designer) {
        height: 100% !important;
    }
</style>
