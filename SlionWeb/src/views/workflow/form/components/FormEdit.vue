<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="720px" @close="close">
        <el-form ref="formRef" label-width="110px" :model="form" :rules="rules">
            <el-form-item label="表单编码" prop="formCode">
                <el-input v-model="form.formCode" :disabled="!!form.id" />
            </el-form-item>
            <el-form-item label="表单名称" prop="formName">
                <el-input v-model="form.formName" />
            </el-form-item>
            <el-form-item label="表单类型" prop="formType">
                <el-radio-group v-model="form.formType">
                    <el-radio :value="0">内置表单</el-radio>
                    <el-radio :value="1">外挂表单</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item v-if="form.formType === 1" label="表单路径" prop="formPath">
                <el-input
                    v-model="form.formPath"
                    placeholder="前端组件路径，如 workflow/leave/leaveEdit"
                />
            </el-form-item>
            <template v-else>
                <el-form-item label="表单内容">
                    <el-alert
                        :closable="false"
                        show-icon
                        type="info"
                        title="请保存基础信息后，在列表点击「设计」使用可视化拖拽设计器编辑表单"
                        style="width: 100%"
                    />
                </el-form-item>
                <el-form-item v-if="form.id" label="高级 JSON">
                    <el-input
                        v-model="form.formContent"
                        type="textarea"
                        :rows="6"
                        placeholder="可选：粘贴 form-create rule JSON（数组）；日常请用设计器"
                    />
                </el-form-item>
            </template>
            <el-form-item label="扩展字段" prop="ext">
                <el-input v-model="form.ext" placeholder="可选" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button
                v-if="form.formType !== 1"
                type="success"
                @click="saveAndDesign"
            >
                {{ form.id ? '保存并设计' : '确定并设计' }}
            </el-button>
            <el-button type="primary" @click="save()">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { addForm, getForm, updateForm } from '@/api/workflow/form'

    const emptyForm = () => ({
        id: undefined,
        formCode: '',
        formName: '',
        formType: 0,
        formPath: '',
        formContent: '',
        ext: '',
        isPublish: 0,
    })

    export default defineComponent({
        name: 'WorkflowFormEdit',
        emits: ['fetch-data', 'design'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    formCode: [
                        { required: true, trigger: 'blur', message: '请输入表单编码' },
                    ],
                    formName: [
                        { required: true, trigger: 'blur', message: '请输入表单名称' },
                    ],
                    formPath: [
                        {
                            validator: (_r, v, cb) => {
                                if (state.form.formType === 1 && !v) {
                                    cb(new Error('请输入表单路径'))
                                } else {
                                    cb()
                                }
                            },
                            trigger: 'blur',
                        },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = async (row) => {
                if (row?.id) {
                    state.title = '编辑表单'
                    const { data } = await getForm(row.id)
                    state.form = { ...emptyForm(), ...(data || row) }
                } else {
                    state.title = '添加表单'
                    state.form = emptyForm()
                }
                state.dialogFormVisible = true
            }
            const close = () => {
                state['formRef']?.resetFields?.()
                state.form = emptyForm()
                state.dialogFormVisible = false
            }
            const persist = async () => {
                const payload = { ...state.form }
                if (payload.formType !== 1) {
                    payload.formType = 0
                    payload.formPath = ''
                }
                if (payload.id) {
                    const { msg } = await updateForm(payload)
                    $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    return payload
                }
                const { msg, data } = await addForm(payload)
                $baseMessage(msg || '新增成功', 'success', 'vab-hey-message-success')
                if (data?.id) {
                    payload.id = data.id
                }
                return payload
            }
            const save = (openDesign = false) => {
                state['formRef'].validate(async (valid) => {
                    if (!valid) return
                    try {
                        const saved = await persist()
                        emit('fetch-data')
                        close()
                        if (
                            openDesign &&
                            saved?.id &&
                            saved.formType !== 1
                        ) {
                            emit('design', { id: saved.id })
                        }
                    } catch (e) {
                        console.error(e)
                    }
                })
            }
            const saveAndDesign = () => save(true)
            return {
                ...toRefs(state),
                showEdit,
                close,
                save,
                saveAndDesign,
            }
        },
    })
</script>
