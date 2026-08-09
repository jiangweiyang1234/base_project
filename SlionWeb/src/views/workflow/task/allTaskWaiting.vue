<template>
    <div class="workflow-task-all-waiting-container auto-height-container">
        <vab-query-form>
            <vab-query-form-right-panel :span="24">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.nodeName"
                            clearable
                            placeholder="节点名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.flowName"
                            clearable
                            placeholder="流程名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">
                            查询
                        </el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>

        <el-table v-loading="listLoading" border :data="list">
            <el-table-column
                align="center"
                label="流程名称"
                prop="flowName"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="任务名称"
                prop="nodeName"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="业务ID"
                prop="businessId"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="办理人"
                prop="assigneeNames"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="发起人"
                prop="createBy"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="创建时间"
                prop="createTime"
                show-overflow-tooltip
                width="160"
            />
            <template #empty>
                <el-empty class="vab-data-empty" description="暂无待办" />
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
    </div>
</template>

<script>
    import { Search } from '@element-plus/icons-vue'
    import { pageByAllTaskWait } from '@/api/workflow/task'

    export default defineComponent({
        name: 'WorkflowAllTaskWaiting',
        setup() {
            const state = reactive({
                list: [],
                listLoading: false,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                queryForm: {
                    pageNum: 1,
                    pageSize: 10,
                    nodeName: '',
                    flowName: '',
                },
            })

            const fetchData = async () => {
                state.listLoading = true
                try {
                    const { rows, total } = await pageByAllTaskWait(state.queryForm)
                    state.list = rows || []
                    state.total = total || 0
                } finally {
                    state.listLoading = false
                }
            }
            const queryData = () => {
                state.queryForm.pageNum = 1
                fetchData()
            }
            const handleSizeChange = (val) => {
                state.queryForm.pageSize = val
                fetchData()
            }
            const handleCurrentChange = (val) => {
                state.queryForm.pageNum = val
                fetchData()
            }

            onMounted(fetchData)

            return {
                ...toRefs(state),
                queryData,
                handleSizeChange,
                handleCurrentChange,
                Search,
            }
        },
    })
</script>
