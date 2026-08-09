<template>
    <div class="department-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="8">
                <el-button
                    :icon="CirclePlus"
                    type="primary"
                    @click="handleEdit($event)"
                >
                    新增MAC地址
                </el-button>
                <el-button :icon="Upload" type="success" @click="handleImport">
                    Excel导入
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="16">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.macAddress1"
                            clearable
                            placeholder="请输入MAC地址1"
                            style="width: 180px"
                        />
                    </el-form-item>
                    &nbsp;
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.macAddress2"
                            clearable
                            placeholder="请输入MAC地址2"
                            style="width: 180px"
                        />
                    </el-form-item>
                    &nbsp;
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.projectName"
                            clearable
                            placeholder="请输入项目名称"
                            style="width: 180px"
                        />
                    </el-form-item>
                    &nbsp;
                    <el-form-item>
                        <el-button
                            :icon="Search"
                            type="primary"
                            @click="queryData"
                        >
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
            row-key="id"
            @selection-change="setSelectRows"
            style="width: 100%"
            :row-style="{ height: '60px' }"
        >
            <el-table-column
                label="项目"
                align="center"
                prop="projectName"
                width="200px"
            >
                <template #default="{ row }">
                    {{ row.projectName || '-' }}
                </template>
            </el-table-column>
            <el-table-column
                label="MAC地址1"
                align="center"
                prop="macAddress1"
                fixed="left"
                width="180px"
            />
            <el-table-column
                label="MAC地址2"
                align="center"
                prop="macAddress2"
                width="180px"
            >
                <template #default="{ row }">
                    {{ row.macAddress2 || '-' }}
                </template>
            </el-table-column>
            <el-table-column label="状态" align="center" width="120px">
                <template #default="{ row }">
                    <el-tag v-if="row.status === 0" type="info">未上报</el-tag>
                    <el-tag v-else-if="row.status === 1" type="success">
                        已上报
                    </el-tag>
                    <el-tag v-else-if="row.status != null" type="primary">
                        {{ row.status }}
                    </el-tag>
                    <span v-else>-</span>
                </template>
            </el-table-column>
            <el-table-column
                label="最新更新时间"
                align="center"
                prop="lastReportTime"
                width="180px"
            >
                <template #default="{ row }">
                    {{ row.lastReportTime || '-' }}
                </template>
            </el-table-column>
            <el-table-column label="操作" align="center" fixed="right">
                <template #default="{ row }">
                    <el-row>
                        <el-col :span="11">
                            <el-button
                                size="small"
                                type="primary"
                                @click="handleEdit(row)"
                            >
                                修改
                            </el-button>
                        </el-col>
                        <el-col :span="2" />
                        <el-col :span="11">
                            <el-button
                                size="small"
                                type="danger"
                                @click="handleDelete(row)"
                            >
                                删除
                            </el-button>
                        </el-col>
                    </el-row>
                </template>
            </el-table-column>
            <template #empty>
                <el-empty class="vab-data-empty" description="暂无数据" />
            </template>
        </el-table>
        <el-pagination
            background
            :current-page="queryForm.pageNo"
            :layout="layout"
            :page-size="queryForm.pageSize"
            :total="total"
            @current-change="handleCurrentChange"
            @size-change="handleSizeChange"
        />
        <edit ref="editRef" @fetch-data="fetchData" />
        <import-upload ref="uploadRef" @fetch-data="fetchData" />
    </div>
</template>

<script>
    import { CirclePlus, Search, Upload } from '@element-plus/icons-vue'
    import { doDelete, getList } from '@/api/biz/deviceMacImport'

    export default defineComponent({
        name: 'DeviceMacImport',
        components: {
            Edit: defineAsyncComponent(
                () => import('./components/DeviceMacImportEdit.vue')
            ),
            ImportUpload: defineAsyncComponent(
                () => import('./components/DeviceMacImportUpload.vue')
            ),
        },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                editRef: null,
                uploadRef: null,
                list: [],
                listLoading: true,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                selectRows: '',
                queryForm: {
                    pageNo: 1,
                    pageSize: 10,
                    macAddress1: null,
                    macAddress2: null,
                    projectName: null,
                },
            })

            const setSelectRows = (val) => {
                state.selectRows = val
            }

            const handleEdit = (row) => {
                if (row.id) {
                    state.editRef.showEdit(row)
                } else {
                    state.editRef.showEdit()
                }
            }

            const handleImport = () => {
                state.uploadRef.showUpload()
            }

            const handleDelete = (row) => {
                if (row.id) {
                    $baseConfirm('你确定要删除当前项吗', null, async () => {
                        const { msg } = await doDelete(row.id)
                        $baseMessage(msg, 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else {
                    if (state.selectRows.length > 0) {
                        const ids = state.selectRows
                            .map((item) => item.id)
                            .join(',')
                        $baseConfirm('你确定要删除选中项吗', null, async () => {
                            const { msg } = await doDelete({ ids })
                            $baseMessage(
                                msg,
                                'success',
                                'vab-hey-message-success'
                            )
                            await fetchData()
                        })
                    } else {
                        $baseMessage(
                            '未选中任何行',
                            'error',
                            'vab-hey-message-error'
                        )
                    }
                }
            }

            const handleSizeChange = (val) => {
                state.queryForm.pageSize = val
                fetchData()
            }

            const handleCurrentChange = (val) => {
                state.queryForm.pageNo = val
                fetchData()
            }

            const queryData = () => {
                state.queryForm.pageNo = 1
                fetchData()
            }

            const fetchData = async () => {
                state.listLoading = true
                const { total, rows } = await getList(state.queryForm)
                state.list = rows
                state.total = total
                state.listLoading = false
            }

            onMounted(() => {
                fetchData()
            })

            return {
                ...toRefs(state),
                setSelectRows,
                handleEdit,
                handleImport,
                handleDelete,
                handleSizeChange,
                handleCurrentChange,
                queryData,
                fetchData,
                CirclePlus,
                Search,
                Upload,
            }
        },
    })
</script>
