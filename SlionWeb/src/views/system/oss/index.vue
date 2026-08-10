<template>
    <div class="oss-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Upload" type="primary" @click="openUpload">
                    上传文件
                </el-button>
                <el-button
                    :icon="Delete"
                    style="margin-left: 8px"
                    type="danger"
                    @click="handleDelete()"
                >
                    批量删除
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.fileName"
                            clearable
                            placeholder="文件名"
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
                label="文件名"
                prop="originalName"
                min-width="160"
                show-overflow-tooltip
            />
            <el-table-column label="后缀" prop="fileSuffix" width="80" />
            <el-table-column label="地址" min-width="200" show-overflow-tooltip>
                <template #default="{ row }">
                    <el-link :href="row.url" target="_blank" type="primary">
                        {{ row.url }}
                    </el-link>
                </template>
            </el-table-column>
            <el-table-column label="服务商" prop="service" width="100" />
            <el-table-column label="创建时间" prop="createTime" width="170" />
            <el-table-column align="center" label="操作" width="100" fixed="right">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleDelete(row)">
                        删除
                    </el-button>
                </template>
            </el-table-column>
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

        <oss-upload-dialog ref="uploadDialogRef" @success="fetchData" />
    </div>
</template>
<script>
    import { Delete, Search, Upload } from '@element-plus/icons-vue'
    import { listOss, delOss } from '@/api/system/oss'
    import OssUploadDialog from './components/OssUploadDialog.vue'

    export default defineComponent({
        name: 'OssManagement',
        components: { OssUploadDialog },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')
            const uploadDialogRef = ref(null)
            const state = reactive({
                list: [],
                listLoading: false,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                selectRows: [],
                queryForm: { pageNum: 1, pageSize: 10, fileName: undefined },
            })
            const setSelectRows = (val) => {
                state.selectRows = val
            }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const res = await listOss(state.queryForm)
                    state.list = res.rows || []
                    state.total = res.total || 0
                } finally {
                    state.listLoading = false
                }
            }
            const openUpload = () => {
                uploadDialogRef.value?.show?.()
            }
            const handleDelete = (row) => {
                if (row?.ossId) {
                    $baseConfirm('确认删除该文件吗？', null, async () => {
                        const { msg } = await delOss(row.ossId)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length) {
                    const ids = state.selectRows.map((i) => i.ossId).join(',')
                    $baseConfirm('确认删除选中文件吗？', null, async () => {
                        const { msg } = await delOss(ids)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else {
                    $baseMessage('未选中任何行', 'error', 'vab-hey-message-error')
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
            onMounted(() => fetchData())
            return {
                ...toRefs(state),
                uploadDialogRef,
                setSelectRows,
                openUpload,
                handleDelete,
                queryData,
                handleSizeChange,
                handleCurrentChange,
                fetchData,
                Delete,
                Search,
                Upload,
            }
        },
    })
</script>
