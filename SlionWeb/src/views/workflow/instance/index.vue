<template>
    <div class="workflow-instance-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="8">
                <el-radio-group v-model="tab" @change="queryData">
                    <el-radio-button value="running">运行中</el-radio-button>
                    <el-radio-button value="finish">已完成</el-radio-button>
                    <el-radio-button value="current">我发起的</el-radio-button>
                </el-radio-group>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="16">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.flowName"
                            clearable
                            placeholder="流程名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.businessId"
                            clearable
                            placeholder="业务ID"
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
                label="业务ID"
                prop="businessId"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="当前节点"
                prop="nodeName"
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
            <el-table-column align="center" fixed="right" label="操作" width="200">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleHistory(row)">
                        流转记录
                    </el-button>
                    <el-button
                        v-if="tab === 'running'"
                        text
                        type="danger"
                        @click="handleCancel(row)"
                    >
                        撤销
                    </el-button>
                    <el-button text type="danger" @click="handleDelete(row)">
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

        <el-dialog v-model="hisVisible" title="流转记录" width="640px">
            <el-timeline>
                <el-timeline-item
                    v-for="(item, index) in hisList"
                    :key="index"
                    :timestamp="item.createTime"
                >
                    {{ item.nodeName }} — {{ item.approver || item.createBy }}
                    <div v-if="item.message" class="his-msg">{{ item.message }}</div>
                </el-timeline-item>
            </el-timeline>
            <el-empty v-if="!hisList.length" description="暂无记录" />
        </el-dialog>
    </div>
</template>

<script>
    import { Search } from '@element-plus/icons-vue'
    import {
        cancelProcessApply,
        deleteByInstanceIds,
        flowHisTaskList,
        pageByCurrent,
        pageByFinish,
        pageByRunning,
    } from '@/api/workflow/instance'

    export default defineComponent({
        name: 'WorkflowInstance',
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                tab: 'running',
                list: [],
                listLoading: false,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                queryForm: {
                    pageNum: 1,
                    pageSize: 10,
                    flowName: '',
                    businessId: '',
                },
                hisVisible: false,
                hisList: [],
            })

            const fetchData = async () => {
                state.listLoading = true
                try {
                    const api =
                        state.tab === 'finish'
                            ? pageByFinish
                            : state.tab === 'current'
                              ? pageByCurrent
                              : pageByRunning
                    const { rows, total } = await api(state.queryForm)
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
            const handleHistory = async (row) => {
                const { data } = await flowHisTaskList(row.businessId)
                state.hisList = data || []
                state.hisVisible = true
            }
            const handleCancel = (row) => {
                $baseConfirm('确认撤销该流程吗？', null, async () => {
                    const { msg } = await cancelProcessApply({
                        businessId: row.businessId,
                        message: '撤销申请',
                    })
                    $baseMessage(msg || '已撤销', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleDelete = (row) => {
                $baseConfirm('确认删除该实例吗？', null, async () => {
                    const { msg } = await deleteByInstanceIds(row.id)
                    $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }

            onMounted(fetchData)

            return {
                ...toRefs(state),
                queryData,
                handleSizeChange,
                handleCurrentChange,
                handleHistory,
                handleCancel,
                handleDelete,
                Search,
            }
        },
    })
</script>

<style lang="scss" scoped>
    .his-msg {
        margin-top: 4px;
        color: #909399;
        font-size: 12px;
    }
</style>
