<template>
    <div class="config-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Plus" type="primary" @click="handleEdit($event)">添加</el-button>
                <el-button :icon="Delete" type="danger" @click="handleDelete($event)">批量删除</el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.configName" clearable placeholder="参数名称" />
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.configKey" clearable placeholder="参数键名" />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">查询</el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>
        <el-table v-loading="listLoading" border :data="list" @selection-change="setSelectRows">
            <el-table-column type="selection" width="48" />
            <el-table-column label="参数名称" prop="configName" show-overflow-tooltip min-width="140" />
            <el-table-column label="参数键名" prop="configKey" show-overflow-tooltip min-width="160" />
            <el-table-column label="参数键值" prop="configValue" show-overflow-tooltip min-width="160" />
            <el-table-column label="系统内置" prop="configType" show-overflow-tooltip width="90" />
            <el-table-column label="备注" prop="remark" show-overflow-tooltip min-width="120" />
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
    import { listConfig, delConfig } from '@/api/system/config'

    export default defineComponent({
        name: 'ConfigManagement',
        components: {
            Edit: defineAsyncComponent(() => import('./components/ConfigEdit.vue')),
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
                    configName: undefined,
                    configKey: undefined
                },
            })
            const setSelectRows = (val) => { state.selectRows = val }
            
            const handleEdit = (row) => {
                if (row && row.configId) state.editRef.showEdit(row)
                else state.editRef.showEdit()
            }
            const handleDelete = (row) => {
                if (row && row.configId) {
                    $baseConfirm('确认删除该记录吗？', null, async () => {
                        const { msg } = await delConfig(row.configId)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length) {
                    const ids = state.selectRows.map((i) => i.configId).join(',')
                    $baseConfirm('确认删除选中记录吗？', null, async () => {
                        const { msg } = await delConfig(ids)
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
                    const res = await listConfig(state.queryForm)
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
