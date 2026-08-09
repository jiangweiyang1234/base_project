<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="560px" @close="close">
        <el-form ref="formRef" label-width="120px" :model="form" :rules="rules">
            <el-form-item label="应用名称" prop="appName">
                <el-input v-model="form.appName" />
            </el-form-item>
            <el-form-item v-if="form.id" label="AppKey">
                <el-input v-model="form.appKey" disabled />
            </el-form-item>
            <el-form-item label="授权类型" prop="grantTypes">
                <el-input v-model="form.grantTypes" placeholder="client_credentials" />
            </el-form-item>
            <el-form-item label="授权范围" prop="scopes">
                <el-input v-model="form.scopes" placeholder="open.api" />
            </el-form-item>
            <el-form-item label="Token有效期" prop="accessTokenTtl">
                <el-input-number v-model="form.accessTokenTtl" :min="60" style="width: 100%" />
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
    import { addOauthClient, updateOauthClient } from '@/api/system/oauthClient'
    const emptyForm = () => ({
        id: undefined,
        appName: '',
        appKey: '',
        grantTypes: 'client_credentials',
        scopes: 'open.api',
        accessTokenTtl: 7200,
        status: '0',
        remark: '',
    })
    export default defineComponent({
        name: 'OauthClientEdit',
        emits: ['fetch-data', 'created-secret'],
        setup(_, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    appName: [{ required: true, trigger: 'blur', message: '请输入应用名称' }],
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row) => {
                state.title = row?.id ? '编辑开放应用' : '新增开放应用'
                state.form = row?.id ? { ...emptyForm(), ...row } : emptyForm()
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
                        const { msg } = await updateOauthClient(state.form)
                        $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    } else {
                        const res = await addOauthClient(state.form)
                        $baseMessage(res.msg || '新增成功', 'success', 'vab-hey-message-success')
                        if (res.data?.appSecretPlain) {
                            emit('created-secret', {
                                appKey: res.data.appKey,
                                appSecretPlain: res.data.appSecretPlain,
                            })
                        }
                    }
                    emit('fetch-data')
                    close()
                })
            }
            return { ...toRefs(state), showEdit, close, save }
        },
    })
</script>
