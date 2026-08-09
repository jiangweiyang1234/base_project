<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="520px"
        @close="close"
    >
        <el-form ref="formRef" label-width="90px" :model="form" :rules="rules">
            <el-form-item label="上级部门" prop="parentId">
                <el-tree-select
                    v-model="form.parentId"
                    check-strictly
                    clearable
                    :data="treeData"
                    :props="{ value: 'deptId', label: 'deptName', children: 'children' }"
                    value-key="deptId"
                    placeholder="选择上级部门"
                />
            </el-form-item>
            <el-form-item label="部门名称" prop="deptName">
                <el-input v-model="form.deptName" />
            </el-form-item>
            <el-form-item label="显示排序" prop="orderNum">
                <el-input-number v-model="form.orderNum" :min="0" />
            </el-form-item>
            <el-form-item label="负责人">
                <el-input v-model="form.leader" />
            </el-form-item>
            <el-form-item label="联系电话">
                <el-input v-model="form.phone" />
            </el-form-item>
            <el-form-item label="邮箱">
                <el-input v-model="form.email" />
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
    import { addDept, handleTree, listDept, updateDept } from '@/api/system/dept'

    const emptyForm = () => ({
        deptId: undefined,
        parentId: 0,
        deptName: '',
        orderNum: 0,
        leader: '',
        phone: '',
        email: '',
        status: '0',
    })

    export default defineComponent({
        name: 'DepartmentManagementEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                formRef: null,
                treeData: [],
                form: emptyForm(),
                rules: {
                    parentId: [
                        { required: true, trigger: 'change', message: '请选择上级部门' },
                    ],
                    deptName: [
                        { required: true, trigger: 'blur', message: '请输入部门名称' },
                    ],
                    orderNum: [
                        { required: true, trigger: 'blur', message: '请输入排序' },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })

            const fetchTree = async () => {
                const { data } = await listDept()
                state.treeData = [
                    {
                        deptId: 0,
                        deptName: '主类目',
                        children: handleTree(data || []),
                    },
                ]
            }

            const showEdit = async (row) => {
                await fetchTree()
                if (!row) {
                    state.title = '添加部门'
                    state.form = emptyForm()
                } else if (row.deptId) {
                    state.title = '编辑部门'
                    state.form = { ...emptyForm(), ...JSON.parse(JSON.stringify(row)) }
                    delete state.form.children
                } else {
                    state.title = '添加部门'
                    state.form = {
                        ...emptyForm(),
                        parentId: row.parentId ?? 0,
                    }
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
                    const api = state.form.deptId ? updateDept : addDept
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
