<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="560px"
        @close="close"
    >
        <el-form ref="formRef" label-width="90px" :model="form" :rules="rules">
            <el-form-item label="角色名称" prop="roleName">
                <el-input v-model="form.roleName" placeholder="请输入角色名称" />
            </el-form-item>
            <el-form-item label="权限字符" prop="roleKey">
                <el-input v-model="form.roleKey" placeholder="如 admin" />
            </el-form-item>
            <el-form-item label="显示顺序" prop="roleSort">
                <el-input-number v-model="form.roleSort" :min="0" />
            </el-form-item>
            <el-form-item label="状态">
                <el-radio-group v-model="form.status">
                    <el-radio value="0">正常</el-radio>
                    <el-radio value="1">停用</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="菜单权限">
                <div class="vab-tree-border">
                    <el-tree
                        ref="treeRef"
                        :data="menuOptions"
                        :props="{ label: 'label', children: 'children' }"
                        show-checkbox
                        node-key="id"
                        empty-text="加载中，请稍候"
                    />
                </div>
            </el-form-item>
            <el-form-item label="备注">
                <el-input v-model="form.remark" type="textarea" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { addRole, updateRole } from '@/api/system/role'
    import { roleMenuTreeselect, treeselect } from '@/api/system/menu'

    const emptyForm = () => ({
        roleId: undefined,
        roleName: '',
        roleKey: '',
        roleSort: 0,
        status: '0',
        menuIds: [],
        menuCheckStrictly: true,
        remark: '',
    })

    export default defineComponent({
        name: 'RoleManagementEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                formRef: null,
                treeRef: null,
                form: emptyForm(),
                menuOptions: [],
                rules: {
                    roleName: [
                        { required: true, trigger: 'blur', message: '请输入角色名称' },
                    ],
                    roleKey: [
                        { required: true, trigger: 'blur', message: '请输入权限字符' },
                    ],
                    roleSort: [
                        { required: true, trigger: 'blur', message: '请输入显示顺序' },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })

            const showEdit = async (row) => {
                state.dialogFormVisible = true
                if (!row) {
                    state.title = '添加角色'
                    state.form = emptyForm()
                    const { data } = await treeselect()
                    state.menuOptions = data || []
                    nextTick(() => state.treeRef?.setCheckedKeys([]))
                } else {
                    state.title = '编辑角色'
                    state.form = { ...emptyForm(), ...JSON.parse(JSON.stringify(row)) }
                    const { data } = await roleMenuTreeselect(row.roleId)
                    state.menuOptions = data?.menus || []
                    nextTick(() => {
                        state.treeRef?.setCheckedKeys(data?.checkedKeys || [])
                    })
                }
            }
            const close = () => {
                state.formRef?.resetFields()
                state.form = emptyForm()
                state.dialogFormVisible = false
            }
            const save = () => {
                state.formRef.validate(async (valid) => {
                    if (!valid) return
                    const checked = state.treeRef.getCheckedKeys()
                    const half = state.treeRef.getHalfCheckedKeys()
                    state.form.menuIds = [...checked, ...half]
                    const api = state.form.roleId ? updateRole : addRole
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

<style lang="scss" scoped>
    .vab-tree-border {
        width: 100%;
        height: 280px;
        padding: $base-padding;
        overflow-y: auto;
        border: 1px solid #dcdfe6;
        border-radius: $base-border-radius;
    }
</style>
