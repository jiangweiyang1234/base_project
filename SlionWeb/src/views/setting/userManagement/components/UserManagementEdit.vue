<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="680px"
        @close="close"
    >
        <el-form ref="formRef" label-width="90px" :model="form" :rules="rules">
            <el-row :gutter="16">
                <el-col :span="12">
                    <el-form-item label="用户名" prop="userName">
                        <el-input
                            v-model.trim="form.userName"
                            :disabled="!!form.userId"
                            placeholder="登录账号"
                        />
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="昵称" prop="nickName">
                        <el-input v-model.trim="form.nickName" />
                    </el-form-item>
                </el-col>
                <el-col v-if="!form.userId" :span="12">
                    <el-form-item label="密码" prop="password">
                        <el-input
                            v-model.trim="form.password"
                            show-password
                            type="password"
                        />
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="手机" prop="phonenumber">
                        <el-input v-model.trim="form.phonenumber" />
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="邮箱" prop="email">
                        <el-input v-model.trim="form.email" />
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="部门" prop="deptId">
                        <el-tree-select
                            v-model="form.deptId"
                            check-strictly
                            clearable
                            :data="deptOptions"
                            :props="{ value: 'id', label: 'label', children: 'children' }"
                            value-key="id"
                        />
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="性别">
                        <el-select v-model="form.sex" clearable placeholder="请选择">
                            <el-option label="男" value="0" />
                            <el-option label="女" value="1" />
                            <el-option label="未知" value="2" />
                        </el-select>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="状态">
                        <el-radio-group v-model="form.status">
                            <el-radio value="0">正常</el-radio>
                            <el-radio value="1">停用</el-radio>
                        </el-radio-group>
                    </el-form-item>
                </el-col>
                <el-col :span="24">
                    <el-form-item label="角色" prop="roleIds">
                        <el-select
                            v-model="form.roleIds"
                            clearable
                            multiple
                            placeholder="请选择角色"
                            style="width: 100%"
                        >
                            <el-option
                                v-for="item in roleOptions"
                                :key="item.roleId"
                                :label="item.roleName"
                                :value="item.roleId"
                            />
                        </el-select>
                    </el-form-item>
                </el-col>
                <el-col :span="24">
                    <el-form-item label="备注">
                        <el-input v-model="form.remark" type="textarea" />
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { addUser, deptTreeSelect, getUser, updateUser } from '@/api/system/user'

    const emptyForm = () => ({
        userId: undefined,
        userName: '',
        nickName: '',
        password: '',
        phonenumber: '',
        email: '',
        deptId: undefined,
        sex: '0',
        status: '0',
        roleIds: [],
        remark: '',
    })

    export default defineComponent({
        name: 'UserManagementEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const form = ref(emptyForm())
            const state = reactive({
                formRef: null,
                deptOptions: [],
                roleOptions: [],
                rules: {
                    userName: [
                        { required: true, trigger: 'blur', message: '请输入用户名' },
                    ],
                    nickName: [
                        { required: true, trigger: 'blur', message: '请输入昵称' },
                    ],
                    password: [
                        {
                            trigger: 'blur',
                            validator: (_rule, value, callback) => {
                                if (!form.value.userId && !value) {
                                    callback(new Error('请输入密码'))
                                } else {
                                    callback()
                                }
                            },
                        },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })

            const loadOptions = async (userId) => {
                const res = await getUser(userId)
                const data = res.data || res
                state.roleOptions = data.roles || []
                if (data.user) {
                    form.value = {
                        ...emptyForm(),
                        ...data.user,
                        roleIds: data.roleIds || [],
                        password: '',
                    }
                }
                const treeRes = await deptTreeSelect()
                state.deptOptions = treeRes.data || []
            }

            const showEdit = async (row) => {
                state.dialogFormVisible = true
                if (!row) {
                    state.title = '添加用户'
                    form.value = emptyForm()
                    await loadOptions()
                } else {
                    state.title = '编辑用户'
                    await loadOptions(row.userId)
                }
            }
            const close = () => {
                state.formRef?.resetFields()
                form.value = emptyForm()
                state.dialogFormVisible = false
            }
            const save = () => {
                state.formRef.validate(async (valid) => {
                    if (!valid) return
                    const payload = { ...form.value }
                    if (payload.userId) delete payload.password
                    const api = payload.userId ? updateUser : addUser
                    const { msg } = await api(payload)
                    $baseMessage(msg || '操作成功', 'success', 'vab-hey-message-success')
                    emit('fetch-data')
                    close()
                })
            }

            return {
                ...toRefs(state),
                form,
                showEdit,
                close,
                save,
            }
        },
    })
</script>
