<template>
    <div class="operlog-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Delete" type="danger" @click="handleDelete()">批量删除</el-button>
                <el-button type="warning" @click="handleClean">清空</el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.title" clearable placeholder="系统模块" />
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.operName" clearable placeholder="操作人员" />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">查询</el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>
        <el-table v-loading="listLoading" border :data="list" @selection-change="setSelectRows">
            <el-table-column type="selection" width="48" />
            <el-table-column label="模块" prop="title" min-width="120" show-overflow-tooltip />
            <el-table-column label="操作人员" prop="operName" width="100" />
            <el-table-column label="请求方式" prop="requestMethod" width="90" />
            <el-table-column label="地址" prop="operIp" width="120" />
            <el-table-column align="center" label="状态" width="80">
                <template #default="{ row }">
                    <el-tag v-if="row.status === 0 || row.status === '0'" type="success">成功</el-tag>
                    <el-tag v-else type="danger">失败</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="操作时间" prop="operTime" width="170" />
            <el-table-column label="耗时(ms)" prop="costTime" width="90" />
            <el-table-column align="center" label="操作" width="90" fixed="right">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleDelete(row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
            background
            :current-page="queryForm.pageNum"
            :layout="layout"
            :page-size="queryForm.pageSize"
            :total="total"
            @current-change="(v) => { queryForm.pageNum = v; fetchData() }"
            @size-change="(v) => { queryForm.pageSize = v; fetchData() }"
        />
    </div>
</template>
<script>
    import { Delete, Search } from '@element-plus/icons-vue'
    import { listOperlog, delOperlog, cleanOperlog } from '@/api/monitor/operlog'
    export default defineComponent({
        name: 'Operlog',
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                list: [], listLoading: false, layout: 'total, sizes, prev, pager, next, jumper',
                total: 0, selectRows: [],
                queryForm: { pageNum: 1, pageSize: 10, title: undefined, operName: undefined },
            })
            const setSelectRows = (v) => { state.selectRows = v }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const res = await listOperlog(state.queryForm)
                    state.list = res.rows || []
                    state.total = res.total || 0
                } finally { state.listLoading = false }
            }
            const handleDelete = (row) => {
                if (row?.operId) {
                    $baseConfirm('确认删除？', null, async () => {
                        const { msg } = await delOperlog(row.operId)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length) {
                    const ids = state.selectRows.map((i) => i.operId).join(',')
                    $baseConfirm('确认删除选中？', null, async () => {
                        const { msg } = await delOperlog(ids)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else $baseMessage('未选中任何行', 'error', 'vab-hey-message-error')
            }
            const handleClean = () => {
                $baseConfirm('确认清空全部操作日志吗？', null, async () => {
                    const { msg } = await cleanOperlog()
                    $baseMessage(msg || '已清空', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const queryData = () => { state.queryForm.pageNum = 1; fetchData() }
            onMounted(() => fetchData())
            return { ...toRefs(state), setSelectRows, handleDelete, handleClean, queryData, fetchData, Delete, Search }
        },
    })
</script>
