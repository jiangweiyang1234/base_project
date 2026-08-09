<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="640px"
        @close="close"
    >
        <el-form ref="formRef" label-width="110px" :model="form" :rules="rules">
            <el-form-item label="企业名称" prop="companyName">
                <el-input v-model="form.companyName" />
            </el-form-item>
            <el-form-item label="联系人" prop="contactUserName">
                <el-input v-model="form.contactUserName" />
            </el-form-item>
            <el-form-item label="联系电话" prop="contactPhone">
                <el-input v-model="form.contactPhone" />
            </el-form-item>
            <el-form-item v-if="!form.id" label="管理员账号" prop="username">
                <el-input v-model="form.username" />
            </el-form-item>
            <el-form-item v-if="!form.id" label="管理员密码" prop="password">
                <el-input v-model="form.password" show-password type="password" />
            </el-form-item>
            <el-form-item label="租户套餐" prop="packageId">
                <el-select
                    v-model="form.packageId"
                    clearable
                    placeholder="请选择套餐"
                    style="width: 100%"
                >
                    <el-option
                        v-for="item in packageOptions"
                        :key="item.packageId"
                        :label="item.packageName"
                        :value="item.packageId"
                    />
                </el-select>
            </el-form-item>
            <el-form-item label="过期时间">
                <el-date-picker
                    v-model="form.expireTime"
                    type="datetime"
                    value-format="YYYY-MM-DD HH:mm:ss"
                    placeholder="选择过期时间"
                    style="width: 100%"
                />
            </el-form-item>
            <el-form-item label="用户数量">
                <el-input-number v-model="form.accountCount" :min="-1" />
                <span style="margin-left: 8px; color: #909399">-1 表示不限制</span>
            </el-form-item>
            <el-form-item label="域名">
                <el-input v-model="form.domain" />
            </el-form-item>
            <el-form-item label="地址">
                <el-input v-model="form.address" />
            </el-form-item>
            <el-form-item label="企业简介">
                <el-input v-model="form.intro" type="textarea" />
            </el-form-item>
            <el-form-item label="备注">
                <el-input v-model="form.remark" type="textarea" />
            </el-form-item>
            <el-form-item label="状态">
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
    import {
        addTenant,
        getTenant,
        selectTenantPackage,
        updateTenant,
    } from '@/api/system/tenant'

    const emptyForm = () => ({
        id: undefined,
        tenantId: undefined,
        companyName: '',
        contactUserName: '',
        contactPhone: '',
        username: '',
        password: '',
        packageId: undefined,
        expireTime: undefined,
        accountCount: -1,
        domain: '',
        address: '',
        intro: '',
        remark: '',
        status: '0',
    })

    export default defineComponent({
        name: 'TenantManagementEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                formRef: null,
                form: emptyForm(),
                packageOptions: [],
                rules: {
                    companyName: [
                        { required: true, trigger: 'blur', message: '请输入企业名称' },
                    ],
                    contactUserName: [
                        { required: true, trigger: 'blur', message: '请输入联系人' },
                    ],
                    contactPhone: [
                        { required: true, trigger: 'blur', message: '请输入联系电话' },
                    ],
                    username: [
                        { required: true, trigger: 'blur', message: '请输入管理员账号' },
                    ],
                    password: [
                        { required: true, trigger: 'blur', message: '请输入管理员密码' },
                    ],
                    packageId: [
                        { required: true, trigger: 'change', message: '请选择租户套餐' },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })

            const loadPackages = async () => {
                const { data } = await selectTenantPackage()
                state.packageOptions = data || []
            }

            const showEdit = async (row) => {
                await loadPackages()
                if (!row) {
                    state.title = '添加租户'
                    state.form = emptyForm()
                } else {
                    state.title = '编辑租户'
                    const { data } = await getTenant(row.id)
                    state.form = { ...emptyForm(), ...(data || row) }
                }
                state.dialogFormVisible = true
            }
            const close = () => {
                state.formRef?.resetFields()
                state.form = emptyForm()
                state.dialogFormVisible = false
            }
            const save = () => {
                state.formRef.validate(async (valid) => {
                    if (!valid) return
                    const api = state.form.id ? updateTenant : addTenant
                    const { msg } = await api(state.form)
                    $baseMessage(msg || '操作成功', 'success', 'vab-hey-message-success')
                    emit('fetch-data')
                    close()
                })
            }

            return {
                ...toRefs(state),
                showEdit,
                close,
                save,
            }
        },
    })
</script>
