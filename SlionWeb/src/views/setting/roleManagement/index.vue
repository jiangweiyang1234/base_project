<template>
    <div class="role-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button
                    :icon="Plus"
                    type="primary"
                    @click="handleEdit($event)"
                >
                    添加
                </el-button>
                <el-button
                    :icon="Delete"
                    type="danger"
                    @click="handleDelete($event)"
                >
                    批量删除
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.roleKey"
                            clearable
                            placeholder="请输入权限字符"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.roleName"
                            clearable
                            placeholder="请输入角色名称"
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
            @selection-change="setSelectRows"
        >
            <el-table-column
                align="center"
                show-overflow-tooltip
                type="selection"
            />
            <el-table-column
                align="center"
                label="角色编号"
                prop="roleId"
                show-overflow-tooltip
                width="90"
            />
            <el-table-column
                align="center"
                label="角色名称"
                prop="roleName"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="权限字符"
                prop="roleKey"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="显示顺序"
                prop="roleSort"
                show-overflow-tooltip
                width="90"
            />
            <el-table-column align="center" label="状态" show-overflow-tooltip>
                <template #default="{ row }">
                    <el-switch
                        v-model="row.status"
                        active-value="0"
                        inactive-value="1"
                        @change="handleStatusChange(row)"
                    />
                </template>
            </el-table-column>
            <el-table-column
                align="center"
                label="创建时间"
                prop="createTime"
                show-overflow-tooltip
                width="160"
            />
            <el-table-column
                align="center"
                label="操作"
                show-overflow-tooltip
                width="200"
            >
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
        <el-pagination
            background
            :current-page="queryForm.pageNum"
            :layout="layout"
            :page-size="queryForm.pageSize"
            :total="total"
            @current-change="handleCurrentChange"
            @size-change="handleSizeChange"
        />
        <edit ref="editRef" @fetch-data="fetchData" />
    </div>
</template>

<script>
    import { Delete, Plus, Search } from '@element-plus/icons-vue'
    import { changeRoleStatus, delRole, listRole } from '@/api/system/role'

    export default defineComponent({
        name: 'RoleManagement',
        components: {
            Edit: defineAsyncComponent(
                () => import('./components/RoleManagementEdit')
            ),
        },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                editRef: null,
                list: [],
                listLoading: true,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                selectRows: [],
                queryForm: {
                    pageNum: 1,
                    pageSize: 10,
                    roleName: '',
                    roleKey: '',
                },
            })

            const setSelectRows = (val) => {
                state.selectRows = val
            }
            const handleEdit = (row) => {
                if (row && row.roleId) {
                    state.editRef.showEdit(row)
                } else {
                    state.editRef.showEdit()
                }
            }
            const handleDelete = (row) => {
                if (row && row.roleId) {
                    $baseConfirm('你确定要删除当前角色吗', null, async () => {
                        const { msg } = await delRole(row.roleId)
                        $baseMessage(msg, 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length > 0) {
                    const ids = state.selectRows.map((item) => item.roleId).join(',')
                    $baseConfirm('你确定要删除选中角色吗', null, async () => {
                        const { msg } = await delRole(ids)
                        $baseMessage(msg, 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else {
                    $baseMessage('未选中任何行', 'error', 'vab-hey-message-error')
                }
            }
            const handleStatusChange = async (row) => {
                try {
                    const { msg } = await changeRoleStatus({
                        roleId: row.roleId,
                        status: row.status,
                    })
                    $baseMessage(msg || '状态已更新', 'success', 'vab-hey-message-success')
                } catch {
                    row.status = row.status === '0' ? '1' : '0'
                }
            }
            const handleSizeChange = (val) => {
                state.queryForm.pageSize = val
                fetchData()
            }
            const handleCurrentChange = (val) => {
                state.queryForm.pageNum = val
                fetchData()
            }
            const queryData = () => {
                state.queryForm.pageNum = 1
                fetchData()
            }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const { total, rows } = await listRole(state.queryForm)
                    state.list = rows || []
                    state.total = total || 0
                } finally {
                    state.listLoading = false
                }
            }
            onMounted(() => {
                fetchData()
            })

            return {
                ...toRefs(state),
                setSelectRows,
                handleEdit,
                handleDelete,
                handleStatusChange,
                handleSizeChange,
                handleCurrentChange,
                queryData,
                fetchData,
                Delete,
                Plus,
                Search,
            }
        },
    })
</script>
