<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="680px"
        @close="close"
    >
        <el-form ref="formRef" label-width="100px" :model="form" :rules="rules">
            <el-form-item label="上级菜单" prop="parentId">
                <el-tree-select
                    v-model="form.parentId"
                    check-strictly
                    clearable
                    :data="menuOptions"
                    :props="{ value: 'menuId', label: 'menuName', children: 'children' }"
                    value-key="menuId"
                    placeholder="选择上级菜单"
                />
            </el-form-item>
            <el-form-item label="菜单类型" prop="menuType">
                <el-radio-group v-model="form.menuType">
                    <el-radio value="M">目录</el-radio>
                    <el-radio value="C">菜单</el-radio>
                    <el-radio value="F">按钮</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="菜单名称" prop="menuName">
                <el-input v-model="form.menuName" />
            </el-form-item>
            <el-form-item v-if="form.menuType !== 'F'" label="图标">
                <el-input v-model="form.icon" placeholder="remix 图标名" />
            </el-form-item>
            <el-form-item label="显示排序" prop="orderNum">
                <el-input-number v-model="form.orderNum" :min="0" />
            </el-form-item>
            <el-form-item v-if="form.menuType !== 'F'" label="路由地址" prop="path">
                <el-input v-model="form.path" placeholder="如 system/user" />
            </el-form-item>
            <el-form-item v-if="form.menuType === 'C'" label="组件路径">
                <el-input
                    v-model="form.component"
                    placeholder="如 setting/userManagement/index"
                />
            </el-form-item>
            <el-form-item v-if="form.menuType !== 'M'" label="权限标识">
                <el-input v-model="form.perms" placeholder="如 system:user:list" />
            </el-form-item>
            <el-form-item v-if="form.menuType !== 'F'" label="显示状态">
                <el-radio-group v-model="form.visible">
                    <el-radio value="0">显示</el-radio>
                    <el-radio value="1">隐藏</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="菜单状态">
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
    import { addMenu, listMenu, updateMenu } from '@/api/system/menu'
    import { handleTree } from '@/api/system/dept'

    const emptyForm = () => ({
        menuId: undefined,
        parentId: 0,
        menuName: '',
        icon: '',
        menuType: 'M',
        orderNum: 0,
        path: '',
        component: '',
        perms: '',
        visible: '0',
        status: '0',
        isFrame: '1',
        isCache: '0',
    })

    export default defineComponent({
        name: 'MenuManagementEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                formRef: null,
                form: emptyForm(),
                menuOptions: [],
                rules: {
                    menuName: [
                        { required: true, trigger: 'blur', message: '请输入菜单名称' },
                    ],
                    orderNum: [
                        { required: true, trigger: 'blur', message: '请输入排序' },
                    ],
                    path: [
                        { required: true, trigger: 'blur', message: '请输入路由地址' },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })

            const loadMenuOptions = async () => {
                const { data } = await listMenu()
                const root = { menuId: 0, menuName: '主类目', children: [] }
                root.children = handleTree(data || [], 'menuId', 'parentId')
                state.menuOptions = [root]
            }

            const showEdit = async (row) => {
                await loadMenuOptions()
                if (!row || (!row.menuId && row.parentId == null)) {
                    state.title = '添加菜单'
                    state.form = emptyForm()
                } else if (row.menuId) {
                    state.title = '编辑菜单'
                    state.form = { ...emptyForm(), ...JSON.parse(JSON.stringify(row)) }
                    delete state.form.children
                } else {
                    state.title = '添加菜单'
                    state.form = { ...emptyForm(), parentId: row.parentId }
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
                    const api = state.form.menuId ? updateMenu : addMenu
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
