<template>
    <div class="post-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Plus" type="primary" @click="handleEdit($event)">添加</el-button>
                <el-button :icon="Delete" type="danger" @click="handleDelete($event)">批量删除</el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.postCode" clearable placeholder="岗位编码" />
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.postName" clearable placeholder="岗位名称" />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">查询</el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>
        <el-table v-loading="listLoading" border :data="list" @selection-change="setSelectRows">
            <el-table-column type="selection" width="48" />
            <el-table-column label="岗位编码" prop="postCode" show-overflow-tooltip width="120" />
            <el-table-column label="岗位名称" prop="postName" show-overflow-tooltip min-width="140" />
            <el-table-column label="排序" prop="postSort" show-overflow-tooltip width="80" />
            <el-table-column align="center" label="状态" width="90">
                <template #default="{ row }">
                    <el-tag v-if="row.status === '0'" type="success">正常</el-tag>
                    <el-tag v-else type="danger">停用</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="创建时间" prop="createTime" show-overflow-tooltip width="170" />
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
    import { listPost, delPost } from '@/api/system/post'

    export default defineComponent({
        name: 'PostManagement',
        components: {
            Edit: defineAsyncComponent(() => import('./components/PostEdit.vue')),
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
                    postCode: undefined,
                    postName: undefined
                },
            })
            const setSelectRows = (val) => { state.selectRows = val }
            
            const handleEdit = (row) => {
                if (row && row.postId) state.editRef.showEdit(row)
                else state.editRef.showEdit()
            }
            const handleDelete = (row) => {
                if (row && row.postId) {
                    $baseConfirm('确认删除该记录吗？', null, async () => {
                        const { msg } = await delPost(row.postId)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length) {
                    const ids = state.selectRows.map((i) => i.postId).join(',')
                    $baseConfirm('确认删除选中记录吗？', null, async () => {
                        const { msg } = await delPost(ids)
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
                    const res = await listPost(state.queryForm)
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
