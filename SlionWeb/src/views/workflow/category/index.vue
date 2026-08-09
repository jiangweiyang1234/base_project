<template>
    <div class="workflow-category-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Plus" type="primary" @click="handleEdit()">
                    添加
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.categoryName"
                            clearable
                            placeholder="分类名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="fetchData">
                            查询
                        </el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>

        <el-table
            v-loading="listLoading"
            border
            :data="list"
            default-expand-all
            row-key="categoryId"
            :tree-props="{ children: 'children' }"
        >
            <el-table-column label="分类名称" prop="categoryName" show-overflow-tooltip />
            <el-table-column
                align="center"
                label="排序"
                prop="orderNum"
                width="80"
            />
            <el-table-column
                label="创建时间"
                prop="createTime"
                show-overflow-tooltip
                width="160"
            />
            <el-table-column align="center" label="操作" width="180">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleEdit(row)">
                        编辑
                    </el-button>
                    <el-button text type="primary" @click="handleDelete(row)">
                        删除
                    </el-button>
                </template>
            </el-table-column>
            <template #empty>
                <el-empty class="vab-data-empty" description="暂无数据" />
            </template>
        </el-table>

        <el-dialog
            v-model="dialogVisible"
            :title="dialogTitle"
            width="480px"
            @close="closeDialog"
        >
            <el-form ref="formRef" label-width="90px" :model="form" :rules="rules">
                <el-form-item label="上级分类">
                    <el-tree-select
                        v-model="form.parentId"
                        check-strictly
                        clearable
                        :data="treeOptions"
                        :props="{ value: 'id', label: 'label', children: 'children' }"
                        value-key="id"
                    />
                </el-form-item>
                <el-form-item label="分类名称" prop="categoryName">
                    <el-input v-model="form.categoryName" />
                </el-form-item>
                <el-form-item label="排序" prop="orderNum">
                    <el-input-number v-model="form.orderNum" :min="0" />
                </el-form-item>
            </el-form>
            <template #footer>
                <el-button @click="closeDialog">取 消</el-button>
                <el-button type="primary" @click="save">确 定</el-button>
            </template>
        </el-dialog>
    </div>
</template>

<script>
    import { Plus, Search } from '@element-plus/icons-vue'
    import {
        addCategory,
        categoryTree,
        delCategory,
        listCategory,
        updateCategory,
    } from '@/api/workflow/category'
    import { handleTree } from '@/api/system/dept'

    const emptyForm = () => ({
        categoryId: undefined,
        parentId: 0,
        categoryName: '',
        orderNum: 0,
    })

    export default defineComponent({
        name: 'WorkflowCategory',
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                list: [],
                listLoading: false,
                treeOptions: [],
                queryForm: { categoryName: '' },
                dialogVisible: false,
                dialogTitle: '',
                formRef: null,
                form: emptyForm(),
                rules: {
                    categoryName: [
                        { required: true, trigger: 'blur', message: '请输入分类名称' },
                    ],
                },
            })

            const fetchData = async () => {
                state.listLoading = true
                try {
                    const res = await listCategory(state.queryForm)
                    state.list = handleTree(
                        res.data || [],
                        'categoryId',
                        'parentId'
                    )
                    const treeRes = await categoryTree()
                    state.treeOptions = [
                        { id: 0, label: '顶级', children: treeRes.data || [] },
                    ]
                } finally {
                    state.listLoading = false
                }
            }
            const handleEdit = (row) => {
                if (row && row.categoryId) {
                    state.dialogTitle = '编辑分类'
                    state.form = {
                        categoryId: row.categoryId,
                        parentId: row.parentId ?? 0,
                        categoryName: row.categoryName,
                        orderNum: row.orderNum ?? 0,
                    }
                } else {
                    state.dialogTitle = '添加分类'
                    state.form = emptyForm()
                }
                state.dialogVisible = true
            }
            const handleDelete = (row) => {
                $baseConfirm('确认删除该分类吗？', null, async () => {
                    const { msg } = await delCategory(row.categoryId)
                    $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const closeDialog = () => {
                state.formRef?.resetFields()
                state.form = emptyForm()
                state.dialogVisible = false
            }
            const save = () => {
                state.formRef.validate(async (valid) => {
                    if (!valid) return
                    const api = state.form.categoryId
                        ? updateCategory
                        : addCategory
                    const { msg } = await api(state.form)
                    $baseMessage(msg || '操作成功', 'success', 'vab-hey-message-success')
                    closeDialog()
                    await fetchData()
                })
            }

            onMounted(fetchData)

            return {
                ...toRefs(state),
                fetchData,
                handleEdit,
                handleDelete,
                closeDialog,
                save,
                Plus,
                Search,
            }
        },
    })
</script>
