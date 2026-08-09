<template>
    <div class="workflow-definition-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button type="primary" @click="openDesigner()">
                    打开设计器
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
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
                            v-model.trim="queryForm.flowCode"
                            clearable
                            placeholder="流程编码"
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
                label="流程编码"
                prop="flowCode"
                show-overflow-tooltip
            />
            <el-table-column
                align="center"
                label="版本"
                prop="version"
                width="80"
            />
            <el-table-column
                align="center"
                label="分类"
                prop="categoryName"
                show-overflow-tooltip
            />
            <el-table-column align="center" label="发布状态" width="100">
                <template #default="{ row }">
                    <el-tag v-if="row.isPublish === 1" type="success">已发布</el-tag>
                    <el-tag v-else type="info">未发布</el-tag>
                </template>
            </el-table-column>
            <el-table-column align="center" label="激活状态" width="100">
                <template #default="{ row }">
                    <el-tag v-if="row.activityStatus === 1" type="success">激活</el-tag>
                    <el-tag v-else type="warning">挂起</el-tag>
                </template>
            </el-table-column>
            <el-table-column
                align="center"
                fixed="right"
                label="操作"
                width="320"
            >
                <template #default="{ row }">
                    <el-button text type="primary" @click="openDesigner(row)">
                        设计
                    </el-button>
                    <el-button
                        v-if="row.isPublish !== 1"
                        text
                        type="primary"
                        @click="handlePublish(row)"
                    >
                        发布
                    </el-button>
                    <el-button
                        v-else
                        text
                        type="primary"
                        @click="handleUnPublish(row)"
                    >
                        取消发布
                    </el-button>
                    <el-button text type="primary" @click="handleActive(row)">
                        {{ row.activityStatus === 1 ? '挂起' : '激活' }}
                    </el-button>
                    <el-button text type="primary" @click="handleCopy(row)">
                        复制
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

        <el-dialog
            v-model="designerVisible"
            destroy-on-close
            title="流程设计器"
            width="90%"
            top="5vh"
        >
            <iframe
                class="warm-flow-iframe"
                frameborder="0"
                :src="designerUrl"
            />
        </el-dialog>
    </div>
</template>

<script>
    import { Search } from '@element-plus/icons-vue'
    import {
        activeDefinition,
        copyDefinition,
        delDefinition,
        listDefinition,
        publishDefinition,
        unPublishDefinition,
    } from '@/api/workflow/definition'
    import { buildWarmFlowDesignerUrl } from '@/utils/warmFlow'

    export default defineComponent({
        name: 'WorkflowDefinition',
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                list: [],
                listLoading: false,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                queryForm: {
                    pageNum: 1,
                    pageSize: 10,
                    flowName: '',
                    flowCode: '',
                },
                designerVisible: false,
                designerUrl: buildWarmFlowDesignerUrl(),
            })

            const fetchData = async () => {
                state.listLoading = true
                try {
                    const { rows, total } = await listDefinition(state.queryForm)
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
            const openDesigner = (row) => {
                state.designerUrl = buildWarmFlowDesignerUrl(row?.id)
                state.designerVisible = true
            }
            const handlePublish = (row) => {
                $baseConfirm('确认发布该流程定义吗？', null, async () => {
                    const { msg } = await publishDefinition(row.id)
                    $baseMessage(msg || '发布成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleUnPublish = (row) => {
                $baseConfirm('确认取消发布吗？', null, async () => {
                    const { msg } = await unPublishDefinition(row.id)
                    $baseMessage(msg || '已取消发布', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleActive = (row) => {
                const active = row.activityStatus !== 1
                const tip = active ? '激活' : '挂起'
                $baseConfirm(`确认${tip}该流程吗？`, null, async () => {
                    const { msg } = await activeDefinition(row.id, active)
                    $baseMessage(msg || `${tip}成功`, 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleCopy = (row) => {
                $baseConfirm('确认复制该流程定义吗？', null, async () => {
                    const { msg } = await copyDefinition(row.id)
                    $baseMessage(msg || '复制成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleDelete = (row) => {
                $baseConfirm('确认删除该流程定义吗？', null, async () => {
                    const { msg } = await delDefinition(row.id)
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
                openDesigner,
                handlePublish,
                handleUnPublish,
                handleActive,
                handleCopy,
                handleDelete,
                Search,
            }
        },
    })
</script>

<style lang="scss" scoped>
    .warm-flow-iframe {
        width: 100%;
        height: 70vh;
        border: 0;
    }
</style>
