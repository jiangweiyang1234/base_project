<template>
    <div class="workflow-form-container auto-height-container">
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
                            v-model.trim="queryForm.formCode"
                            clearable
                            placeholder="表单编码"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.formName"
                            clearable
                            placeholder="表单名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-select
                            v-model="queryForm.isPublish"
                            clearable
                            placeholder="发布状态"
                            style="width: 120px"
                        >
                            <el-option :value="0" label="未发布" />
                            <el-option :value="1" label="已发布" />
                            <el-option :value="9" label="失效" />
                        </el-select>
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
                label="表单编码"
                prop="formCode"
                show-overflow-tooltip
                min-width="120"
            />
            <el-table-column
                label="表单名称"
                prop="formName"
                show-overflow-tooltip
                min-width="140"
            />
            <el-table-column label="版本" prop="version" width="90" />
            <el-table-column label="类型" width="110">
                <template #default="{ row }">
                    {{ row.formType === 1 ? '外挂表单' : '内置表单' }}
                </template>
            </el-table-column>
            <el-table-column
                label="表单路径"
                prop="formPath"
                show-overflow-tooltip
                min-width="160"
            />
            <el-table-column label="发布状态" width="100">
                <template #default="{ row }">
                    <el-tag v-if="row.isPublish === 1" type="success">已发布</el-tag>
                    <el-tag v-else-if="row.isPublish === 9" type="info">失效</el-tag>
                    <el-tag v-else type="warning">未发布</el-tag>
                </template>
            </el-table-column>
            <el-table-column
                label="创建时间"
                prop="createTime"
                show-overflow-tooltip
                width="160"
            />
            <el-table-column align="center" fixed="right" label="操作" width="280">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleEdit(row)">
                        编辑
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
                        type="warning"
                        @click="handleUnPublish(row)"
                    >
                        取消发布
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
                <el-empty class="vab-data-empty" description="暂无表单" />
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
    import {
        copyForm,
        delForm,
        listForm,
        publishForm,
        unPublishForm,
    } from '@/api/workflow/form'

    export default defineComponent({
        name: 'WorkflowForm',
        components: {
            Edit: defineAsyncComponent(() => import('./components/FormEdit.vue')),
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
                    formCode: undefined,
                    formName: undefined,
                    isPublish: undefined,
                },
            })
            const setSelectRows = (val) => {
                state.selectRows = val
            }
            const handleEdit = (row) => {
                state['editRef']?.showEdit(row)
            }
            const handlePublish = (row) => {
                $baseConfirm('确认发布该表单吗？', null, async () => {
                    const { msg } = await publishForm(row.id)
                    $baseMessage(msg || '发布成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleUnPublish = (row) => {
                $baseConfirm('确认取消发布吗？', null, async () => {
                    const { msg } = await unPublishForm(row.id)
                    $baseMessage(msg || '已取消发布', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleCopy = (row) => {
                $baseConfirm('确认复制该表单吗？', null, async () => {
                    const { msg } = await copyForm(row.id)
                    $baseMessage(msg || '复制成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleDelete = (row) => {
                if (row?.id) {
                    $baseConfirm('确认删除该表单吗？', null, async () => {
                        const { msg } = await delForm(row.id)
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
                $baseConfirm('确认删除选中的表单吗？', null, async () => {
                    const { msg } = await delForm(ids)
                    $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const { rows, total } = await listForm(state.queryForm)
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
                handlePublish,
                handleUnPublish,
                handleCopy,
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
