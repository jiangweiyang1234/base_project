<template>
    <div class="department-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="4">
                <el-button
                    :icon="CirclePlus"
                    type="primary"
                    @click="handleEdit($event)"
                >
                    新增访问链路
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="20">
                <el-form inline :model="queryForm" @submit.prevent>
                    <!--
                    <el-form-item>
                        <el-select
                            v-model="queryForm.projectId"
                            clearable
                            filterable
                            placeholder="请选择项目名称"
                            style="width: 200px"
                        ></el-select>
                    </el-form-item>
                    &nbsp;
                    -->
                    <el-form-item>
                        <el-select
                            v-model="queryForm.deviceId"
                            clearable
                            placeholder="请选择主机设备"
                            style="width: 200px"
                        >
                            <el-option
                                v-for="item in deviceSelectList"
                                :key="item.id"
                                :label="`${item.hostname} - [${item.deviceSn}]`"
                                :value="item.id"
                            />
                        </el-select>
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
                    &nbsp;
                    <el-form-item>
                        <el-button
                            :icon="Refresh"
                            type="primary"
                            @click="freshHosts"
                        >
                            同步
                        </el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>

        <el-table
            v-loading="listLoading"
            border
            :data="list"
            default-expand-all
            row-key="id"
            :tree-props="{ children: 'children' }"
            @selection-change="setSelectRows"
            style="width: 100%"
            :row-style="{ height: '70px' }"
        >
            <el-table-column
                label="链路名称"
                align="center"
                prop="hostName"
                fixed="left"
                width="210px"
            />
            <el-table-column label="服务主机协议" align="center" width="120px">
                <template #default="{ row }">
                    <el-tag type="primary">{{ row.protocol }}</el-tag>
                </template>
            </el-table-column>
            <el-table-column
                label="内网服务主机"
                align="center"
                prop="host"
                width="120px"
            />
            <el-table-column
                label="内网服务端口"
                align="center"
                prop="port"
                width="120px"
            />
            <el-table-column label="可访问信息">
                <template #default="{ row }">
                    <span v-if="row.status !== 2">-</span>
                    <span v-if="row.status === 2 && row.protocol === 'HTTP'">
                        <el-row class="list_row">
                            <el-col :span="6">访问地址</el-col>
                            <el-col :span="18">
                                http://service.hxsoft.net/{{ row.viewKey }}
                            </el-col>
                        </el-row>
                    </span>
                    <span v-if="row.status === 2 && (row.protocol === 'TCP' || row.protocol === 'SSH')">
                        <el-row class="list_row">
                            <el-col :span="6">通讯主机</el-col>
                            <el-col :span="18">service.hxsoft.net</el-col>
                        </el-row>
                        <el-row class="list_row">
                            <el-col :span="6">主机端口</el-col>
                            <el-col :span="18">{{ row.remotePort }}</el-col>
                        </el-row>
                    </span>
                </template>
            </el-table-column>
            <!--
            <el-table-column label="链路状态" align="center" prop="status">
                <template #default="{ row }">
                    <el-tag type="warning" v-if="row.status === 0">禁用</el-tag>
                    <el-tag type="success" v-if="row.status === 1">有效</el-tag>
                </template>
            </el-table-column>
            -->
            <el-table-column
                label="操作"
                align="center"
                fixed="right"
                width="150px"
            >
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
                        <!--
                        <el-col :span="8">
                            <el-button
                                v-if="row.status === 1"
                                size="small"
                                type="warning"
                                @click="handleDisable(row)"
                            >
                                禁用
                            </el-button>
                            <el-button
                                v-if="row.status === 0"
                                size="small"
                                type="success"
                                @click="handleDisable(row)"
                            >
                                启用
                            </el-button>
                        </el-col>
                        -->
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
    </div>
</template>

<script>
    import {
        CirclePlus,
        Delete,
        Plus,
        Search,
        Refresh,
    } from '@element-plus/icons-vue'
    import { doDelete, doDisabled, getList, syncHosts } from '@/api/biz/frpHost'
    import { getDeviceList } from '@/api/biz/device'
    import { gp } from '@gp'

    export default defineComponent({
        name: 'DepartmentManagement',
        components: {
            Edit: defineAsyncComponent(
                () => import('./components/FrpHostEdit.vue')
            ),
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
                selectRows: '',
                queryForm: {
                    pageNo: 1,
                    pageSize: 10,
                    projectId: null,
                    deviceId: null,
                },
                deviceSelectList: [],
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

            const handleDisable = (row) => {
                if (row.id) {
                    let noticeMsg = null
                    if (row.status === 1) {
                        noticeMsg = '你确定要禁用当前项吗'
                    } else {
                        noticeMsg = '你确定要启用当前项吗'
                    }
                    $baseConfirm(noticeMsg, null, async () => {
                        const { msg } = await doDisabled({
                            id: row.id,
                            status: row.status === 1 ? 0 : 1,
                        })
                        $baseMessage(msg, 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else {
                    $baseMessage(
                        '请选择需要处理的项',
                        'error',
                        'vab-hey-message-error'
                    )
                }
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

            const freshHosts = async () => {
                if (state.queryForm.deviceId != null) {
                    // 同步
                    let loadingInstance = gp.$baseLoading(
                        0,
                        '正在同步参数配置,请稍等...'
                    )

                    const { code, msg } = await syncHosts(
                        state.queryForm.deviceId
                    )
                    if (code === 200) {
                        loadingInstance.close()
                        $baseMessage(msg, 'success', 'vab-hey-message-success')
                    } else {
                        loadingInstance.close()
                        $baseMessage(msg, 'warning', 'vab-hey-message-warning')
                    }
                    // setTimeout(() => {
                    //     console.info('timeout1')
                    //     loadingInstance.setText('正在下发参数....')
                    // }, 2000)
                    //
                    // setTimeout(() => {
                    //     console.info('timeout2')
                    //     loadingInstance.setText('正在重启 Agent应用....')
                    // }, 3000)
                    //
                    // setTimeout(() => {
                    //     console.info('timeout3')
                    //     loadingInstance.setText('Agent应用本地刷新成功....')
                    // }, 4000)
                } else {
                    $baseMessage(
                        '请选择需要同步配置的主机设备',
                        'error',
                        'vab-hey-message-error'
                    )
                }
            }

            const fetchData = async () => {
                state.listLoading = true
                const { total, rows } = await getList(state.queryForm)
                state.list = rows
                state.total = total
                state.listLoading = false
            }

            const formattedTime2 = (totalSeconds) => {
                const seconds = totalSeconds % 60
                const minutes = Math.floor(totalSeconds / 60) % 60
                const hours = Math.floor(totalSeconds / 3600) % 24
                const days = Math.floor(totalSeconds / 86400)
                return `${days}天 ${hours}时 ${minutes}分 ${seconds}秒`
            }

            const fetchDeviceList = async () => {
                const { code, data } = await getDeviceList()
                if (code === 200) {
                    state.deviceSelectList = data
                } else {
                    state.deviceSelectList = []
                }
            }

            onMounted(() => {
                fetchData()
                // 加载设备主机列表
                fetchDeviceList()
            })

            return {
                ...toRefs(state),
                setSelectRows,
                handleEdit,
                handleDelete,
                handleDisable,
                handleSizeChange,
                handleCurrentChange,
                formattedTime2,
                queryData,
                freshHosts,
                fetchData,
                CirclePlus,
                Delete,
                Plus,
                Search,
                Refresh,
            }
        },
    })
</script>
<style type="text/css">
    .list_row {
        height: 30px;
        line-height: 30px;
    }
</style>
