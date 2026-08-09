<template>
    <div class="client-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Plus" type="primary" @click="handleEdit($event)">添加</el-button>
                <el-button :icon="Delete" type="danger" @click="handleDelete($event)">批量删除</el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.clientKey" clearable placeholder="客户端Key" />
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.clientId" clearable placeholder="客户端ID" />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">查询</el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>
        <el-table v-loading="listLoading" border :data="list" @selection-change="setSelectRows">
            <el-table-column type="selection" width="48" />
            <el-table-column label="客户端ID" prop="clientId" show-overflow-tooltip min-width="200" />
            <el-table-column label="客户端Key" prop="clientKey" show-overflow-tooltip min-width="120" />
            <el-table-column label="授权类型" prop="grantType" show-overflow-tooltip min-width="120" />
            <el-table-column label="设备类型" prop="deviceType" show-overflow-tooltip width="100" />
            <el-table-column align="center" label="状态" width="90">
                <template #default="{ row }">
                    <el-tag v-if="row.status === '0'" type="success">正常</el-tag>
                    <el-tag v-else type="danger">停用</el-tag>
                </template>
            </el-table-column>
            <el-table-column align="center" label="操作" width="160" fixed="right">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleEdit(row)">编辑</el-button>
                    <el-button text type="primary" @click="handleDelete(row)">删除</el-button>
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
    import { listClient, delClient } from '@/api/system/client'

    export default defineComponent({
        name: 'ClientManagement',
        components: {
            Edit: defineAsyncComponent(() => import('./components/ClientEdit.vue')),
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
                    clientKey: undefined,
                    clientId: undefined
                },
            })
            const setSelectRows = (val) => { state.selectRows = val }
            
            const handleEdit = (row) => {
                if (row && row.id) state.editRef.showEdit(row)
                else state.editRef.showEdit()
            }
            const handleDelete = (row) => {
                if (row && row.id) {
                    $baseConfirm('确认删除该记录吗？', null, async () => {
                        const { msg } = await delClient(row.id)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length) {
                    const ids = state.selectRows.map((i) => i.id).join(',')
                    $baseConfirm('确认删除选中记录吗？', null, async () => {
                        const { msg } = await delClient(ids)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else {
                    $baseMessage('未选中任何行', 'error', 'vab-hey-message-error')
                }
            }
            const handleSizeChange = (val) => { state.queryForm.pageSize = val; fetchData() }
            const handleCurrentChange = (val) => { state.queryForm.pageNum = val; fetchData() }
            const queryData = () => { state.queryForm.pageNum = 1; fetchData() }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const res = await listClient(state.queryForm)
                    state.list = res.rows || res.data || []
                    state.total = res.total || state.list.length || 0
                } finally {
                    state.listLoading = false
                }
            }
            
            onMounted(() => fetchData())
            return {
                ...toRefs(state),
                setSelectRows,
                handleEdit,
                handleDelete,
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
