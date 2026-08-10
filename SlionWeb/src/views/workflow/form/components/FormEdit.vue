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
            <el-form-item v-else label="表单内容" prop="formContent">
                <el-input
                    v-model="form.formContent"
                    type="textarea"
                    :rows="10"
                    placeholder="内置表单 JSON / HTML 内容，设计器可通过表单编码关联"
                />
            </el-form-item>
            <el-form-item label="扩展字段" prop="ext">
                <el-input v-model="form.ext" placeholder="可选" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
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
        emits: ['fetch-data'],
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
            const save = () => {
                state['formRef'].validate(async (valid) => {
                    if (!valid) return
                    if (state.form.id) {
                        const { msg } = await updateForm(state.form)
                        $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    } else {
                        const { msg } = await addForm(state.form)
                        $baseMessage(msg || '新增成功', 'success', 'vab-hey-message-success')
                    }
                    emit('fetch-data')
                    close()
                })
            }
            return { ...toRefs(state), showEdit, close, save }
        },
    })
</script>
