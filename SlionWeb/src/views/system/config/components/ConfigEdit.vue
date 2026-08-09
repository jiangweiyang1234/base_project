<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="560px" @close="close">
        <el-form ref="formRef" label-width="110px" :model="form" :rules="rules">
            <el-form-item label="参数名称" prop="configName">
                <el-input v-model="form.configName" />
            </el-form-item>
            <el-form-item label="参数键名" prop="configKey">
                <el-input v-model="form.configKey" />
            </el-form-item>
            <el-form-item label="参数键值" prop="configValue">
                <el-input v-model="form.configValue" />
            </el-form-item>
            <el-form-item label="系统内置" prop="configType">
                <el-select v-model="form.configType" clearable style="width: 100%">
                    <el-option label="是" value="Y" /><el-option label="否" value="N" />
                </el-select>
            </el-form-item>
            <el-form-item label="备注" prop="remark">
                <el-input v-model="form.remark" type="textarea" :rows="3" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { addConfig, updateConfig } from '@/api/system/config'

    const emptyForm = () => ({
        configId: undefined,
        configName: '',
        configKey: '',
        configValue: '',
        configType: 'N',
        remark: ''
    })

    export default defineComponent({
        name: 'ConfigEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    configName: [{ required: true, trigger: 'blur', message: '请输入参数名称' }],
                    configKey: [{ required: true, trigger: 'blur', message: '请输入参数键名' }],
                    configValue: [{ required: true, trigger: 'blur', message: '请输入参数键值' }]
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row) => {
                if (row && row.configId) {
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
                    if (state.form.configId) {
                        const { msg } = await updateConfig(state.form)
                        $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    } else {
                        const { msg } = await addConfig(state.form)
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
