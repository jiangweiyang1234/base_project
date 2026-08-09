<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="560px" @close="close">
        <el-form ref="formRef" label-width="110px" :model="form" :rules="rules">
            <el-form-item label="客户端Key" prop="clientKey">
                <el-input v-model="form.clientKey" />
            </el-form-item>
            <el-form-item label="客户端密钥" prop="clientSecret">
                <el-input v-model="form.clientSecret" />
            </el-form-item>
            <el-form-item label="授权类型" prop="grantTypeList">
                <el-select
                    v-model="form.grantTypeList"
                    allow-create
                    default-first-option
                    filterable
                    multiple
                    style="width: 100%"
                >
                    <el-option label="password" value="password" />
                    <el-option label="sms" value="sms" />
                    <el-option label="email" value="email" />
                    <el-option label="social" value="social" />
                    <el-option label="client_credentials" value="client_credentials" />
                </el-select>
            </el-form-item>
            <el-form-item label="设备类型" prop="deviceType">
                <el-input v-model="form.deviceType" />
            </el-form-item>
            <el-form-item label="Token活跃超时" prop="activeTimeout">
                <el-input-number v-model="form.activeTimeout" :min="0" style="width: 100%" />
            </el-form-item>
            <el-form-item label="Token固定超时" prop="timeout">
                <el-input-number v-model="form.timeout" :min="0" style="width: 100%" />
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.status">
                    <el-radio value="0">正常</el-radio>
                    <el-radio value="1">停用</el-radio>
                </el-radio-group>
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { addClient, updateClient } from '@/api/system/client'

    const emptyForm = () => ({
        id: undefined,
        clientKey: '',
        clientSecret: '',
        grantTypeList: ['password'],
        deviceType: 'pc',
        activeTimeout: 1800,
        timeout: 604800,
        status: '0',
    })

    export default defineComponent({
        name: 'ClientEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    clientKey: [
                        { required: true, trigger: 'blur', message: '请输入客户端Key' },
                    ],
                    clientSecret: [
                        { required: true, trigger: 'blur', message: '请输入客户端密钥' },
                    ],
                    grantTypeList: [
                        {
                            required: true,
                            trigger: 'change',
                            message: '请选择授权类型',
                        },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row) => {
                if (row && row.id) {
                    state.title = '编辑'
                    const grantTypeList =
                        row.grantTypeList ||
                        (row.grantType
                            ? String(row.grantType).split(',')
                            : ['password'])
                    state.form = { ...emptyForm(), ...row, grantTypeList }
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
                        const { msg } = await updateClient(state.form)
                        $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    } else {
                        const { msg } = await addClient(state.form)
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
