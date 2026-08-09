<template>
    <div class="department-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button
                    :icon="Plus"
                    type="primary"
                    @click="handleEdit($event)"
                >
                    添加
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.deptName"
                            clearable
                            placeholder="请输入部门名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-button
                            :icon="Search"
                            type="primary"
                            @click="queryData"
                        >
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
            row-key="deptId"
            :tree-props="{ children: 'children' }"
        >
            <el-table-column
                label="部门名称"
                prop="deptName"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="排序"
                prop="orderNum"
                show-overflow-tooltip
                width="80"
            />
            <el-table-column align="center" label="状态" width="90">
                <template #default="{ row }">
                    <el-tag v-if="row.status === '0'">正常</el-tag>
                    <el-tag v-else type="danger">停用</el-tag>
                </template>
            </el-table-column>
            <el-table-column
                label="创建时间"
                prop="createTime"
                show-overflow-tooltip
                width="160"
            />
            <el-table-column align="center" label="操作" width="200">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleEdit(row)">
                        编辑
                    </el-button>
                    <el-button text type="primary" @click="handleAddChild(row)">
                        新增
                    </el-button>
                    <el-button
                        :disabled="row.parentId === 0"
                        text
                        type="primary"
                        @click="handleDelete(row)"
                    >
                        删除
                    </el-button>
                </template>
            </el-table-column>
            <template #empty>
                <el-empty class="vab-data-empty" description="暂无数据" />
            </template>
        </el-table>
        <edit ref="editRef" @fetch-data="fetchData" />
    </div>
</template>

<script>
    import { Plus, Search } from '@element-plus/icons-vue'
    import { delDept, handleTree, listDept } from '@/api/system/dept'

    export default defineComponent({
        name: 'DepartmentManagement',
        components: {
            Edit: defineAsyncComponent(
                () => import('./components/DepartmentManagementEdit')
            ),
        },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                editRef: null,
                list: [],
                listLoading: true,
                queryForm: {
                    deptName: '',
                },
            })

            const handleEdit = (row) => {
                if (row && row.deptId) {
                    state.editRef.showEdit(row)
                } else {
                    state.editRef.showEdit()
                }
            }
            const handleAddChild = (row) => {
                state.editRef.showEdit({ parentId: row.deptId, parentName: row.deptName })
            }
            const handleDelete = (row) => {
                $baseConfirm('你确定要删除当前部门吗', null, async () => {
                    const { msg } = await delDept(row.deptId)
                    $baseMessage(msg, 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const queryData = () => {
                fetchData()
            }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const { data } = await listDept(state.queryForm)
                    state.list = handleTree(data || [])
                } finally {
                    state.listLoading = false
                }
            }
            onMounted(() => {
                fetchData()
            })

            return {
                ...toRefs(state),
                handleEdit,
                handleAddChild,
                handleDelete,
                queryData,
                fetchData,
                Plus,
                Search,
            }
        },
    })
</script>
