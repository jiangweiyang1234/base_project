<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="640px" @close="close">
        <el-form ref="formRef" label-width="110px" :model="form" :rules="rules">
            <el-form-item label="组件名称" prop="componentName">
                <el-input v-model="form.componentName" placeholder="如 spelRuleComponent" />
            </el-form-item>
            <el-form-item label="方法名" prop="methodName">
                <el-input v-model="form.methodName" />
            </el-form-item>
            <el-form-item label="参数" prop="methodParams">
                <el-input v-model="form.methodParams" placeholder="方法参数名，逗号分隔" />
            </el-form-item>
            <el-form-item label="预览 SpEL" prop="viewSpel">
                <el-input
                    v-model="form.viewSpel"
                    type="textarea"
                    :rows="3"
                    placeholder="如 #{@spelRuleComponent.xxx(#id)}"
                />
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.status">
                    <el-radio value="0">正常</el-radio>
                    <el-radio value="1">停用</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="备注" prop="remark">
                <el-input v-model="form.remark" type="textarea" :rows="2" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { addSpel, updateSpel } from '@/api/workflow/spel'

    const emptyForm = () => ({
        id: undefined,
        componentName: '',
        methodName: '',
        methodParams: '',
        viewSpel: '',
        status: '0',
        remark: '',
    })

    export default defineComponent({
        name: 'SpelEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    viewSpel: [
                        { required: true, trigger: 'blur', message: '请输入预览 SpEL' },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row) => {
                if (row?.id) {
                    state.title = '编辑'
                    state.form = { ...emptyForm(), ...row }
                } else {
                    state.title = '添加'
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
                        const { msg } = await updateSpel(state.form)
                        $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    } else {
                        const { msg } = await addSpel(state.form)
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
