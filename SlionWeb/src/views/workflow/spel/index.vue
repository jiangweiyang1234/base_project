<template>
    <div class="workflow-spel-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Plus" type="primary" @click="handleEdit()">
                    添加
                </el-button>
                <el-button :icon="Delete" type="danger" @click="handleDelete()">
                    批量删除
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.componentName"
                            clearable
                            placeholder="组件名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.methodName"
                            clearable
                            placeholder="方法名"
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

        <el-table
            v-loading="listLoading"
            border
            :data="list"
            @selection-change="setSelectRows"
        >
            <el-table-column type="selection" width="48" />
            <el-table-column
                label="组件名称"
                prop="componentName"
                show-overflow-tooltip
                min-width="140"
            />
            <el-table-column
                label="方法名"
                prop="methodName"
                show-overflow-tooltip
                min-width="120"
            />
            <el-table-column
                label="参数"
                prop="methodParams"
                show-overflow-tooltip
                min-width="120"
            />
            <el-table-column
                label="预览 SpEL"
                prop="viewSpel"
                show-overflow-tooltip
                min-width="220"
            />
            <el-table-column label="状态" prop="status" width="90">
                <template #default="{ row }">
                    {{ row.status === '1' ? '停用' : '正常' }}
                </template>
            </el-table-column>
            <el-table-column
                label="备注"
                prop="remark"
                show-overflow-tooltip
                min-width="120"
            />
            <el-table-column align="center" fixed="right" label="操作" width="160">
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
    import { delSpel, listSpel } from '@/api/workflow/spel'

    export default defineComponent({
        name: 'WorkflowSpel',
        components: {
            Edit: defineAsyncComponent(() => import('./components/SpelEdit.vue')),
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
                    componentName: undefined,
                    methodName: undefined,
                },
            })
            const setSelectRows = (val) => {
                state.selectRows = val
            }
            const handleEdit = (row) => {
                state['editRef']?.showEdit(row)
            }
            const handleDelete = (row) => {
                if (row?.id) {
                    $baseConfirm('确认删除该表达式吗？', null, async () => {
                        const { msg } = await delSpel(row.id)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                    return
                }
                if (!state.selectRows.length) {
                    $baseMessage('请先选择要删除的数据', 'warning', 'vab-hey-message-warning')
                    return
                }
                const ids = state.selectRows.map((item) => item.id)
                $baseConfirm('确认删除选中的表达式吗？', null, async () => {
                    const { msg } = await delSpel(ids)
                    $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const { rows, total } = await listSpel(state.queryForm)
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
                setSelectRows,
                handleEdit,
                handleDelete,
                fetchData,
                queryData,
                handleSizeChange,
                handleCurrentChange,
                Plus,
                Delete,
                Search,
            }
        },
    })
</script>
