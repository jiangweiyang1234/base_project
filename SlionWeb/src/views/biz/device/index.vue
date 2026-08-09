<template>
    <div class="department-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="8"></vab-query-form-left-panel>
            <vab-query-form-right-panel :span="16">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-select
                            v-model="queryForm.deviceType"
                            clearable
                            placeholder="请选择场景类型"
                            style="width: 150px"
                        >
                            <el-option value="2" label="停车" />
                            <el-option value="1" label="校园" />
                        </el-select>
                    </el-form-item>
                    &nbsp;
                    <el-form-item>
                        <el-select
                            v-model="queryForm.deviceType"
                            clearable
                            filterable
                            placeholder="请输入项目名称"
                            style="width: 150px"
                        ></el-select>
                    </el-form-item>
                    &nbsp;
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.macAddress"
                            clearable
                            placeholder="请输入Mac地址"
                        />
                    </el-form-item>
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
            :data="list"
            border
            default-expand-all
            row-key="id"
            @selection-change="setSelectRows"
            style="width: 100%"
        >
            <el-table-column
                label="场景类型"
                align="center"
                width="100px"
                fixed="left"
            >
                <template #default="{ row }">
                    <el-tag v-if="row.deviceType == '0'" type="primary">
                        默认
                    </el-tag>
                    <el-tag v-if="row.deviceType == '1'" type="success">
                        校园
                    </el-tag>
                    <el-tag v-if="row.deviceType == '2'" type="warning">
                        停车
                    </el-tag>
                </template>
            </el-table-column>
            <el-table-column
                label="项目"
                align="center"
                width="180px"
                fixed="left"
            >
                <template #default="{ row }">
                    <span>-</span>
                </template>
            </el-table-column>
            <el-table-column
                label="通讯状态"
                align="center"
                prop="status"
                width="100px"
                fixed="left"
            >
                <template #default="{ row }">
                    <el-tag type="success" v-if="row.status == 1">正常</el-tag>
                    <el-tag type="danger" v-if="row.status == 2">报警</el-tag>
                    <el-tag type="info" v-if="row.status == 3">离线</el-tag>
                    <el-tag type="primary" v-if="row.status == 4">弱网</el-tag>
                </template>
            </el-table-column>

            <el-table-column
                label="最后通讯时间"
                align="center"
                prop="updateTime"
                width="120px"
                fixed="left"
            />
            <el-table-column label="运行服务" align="center" width="130px">
                <template #default="{ row }">
                    <el-tag type="warning" v-if="row.services === ''">
                        未安装服务
                    </el-tag>
                    <el-tag
                        type="success"
                        v-if="row.services.indexOf('1') !== -1"
                    >
                        校园服务
                    </el-tag>
                    <el-tag
                        type="success"
                        v-if="row.services.indexOf('2') !== -1"
                    >
                        停车服务
                    </el-tag>
                    <el-tag
                        type="success"
                        v-if="row.services.indexOf('3') !== -1"
                    >
                        内网穿透服务
                    </el-tag>
                </template>
            </el-table-column>
            <el-table-column label="操作系统" align="center" width="100px">
                <template #default="{ row }">
                    <el-tag v-if="row.osType == '1'">Linux</el-tag>
                    <el-tag v-if="row.osType == '2'">Windows</el-tag>
                </template>
            </el-table-column>
            <el-table-column
                label="系统名称"
                align="center"
                prop="osName"
                width="100px"
            />
            <el-table-column
                label="系统版本号"
                align="center"
                prop="osVersion"
                width="100px"
            />
            <el-table-column
                label="主机名称"
                align="center"
                prop="hostname"
                width="100px"
            />
            <el-table-column
                label="MAC地址"
                align="center"
                prop="macAddress"
                width="150px"
            />
            <el-table-column
                label="内核版本"
                align="center"
                prop="kernelVersion"
                width="150px"
            />
            <el-table-column label="持续运行时间" align="center" width="160px">
                <template #default="{ row }">
                    {{ formattedTime2(row.uptime) }}
                </template>
            </el-table-column>

            <el-table-column label="系统负载" align="center" width="150px">
                <template #default="{ row }">
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">1分钟:</el-col>
                        <el-col :span="12">
                            {{ row.load1.toFixed(2) }}
                        </el-col>
                    </el-row>
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">5分钟:</el-col>
                        <el-col :span="12">
                            {{ row.load5.toFixed(2) }}
                        </el-col>
                    </el-row>
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">15分钟:</el-col>
                        <el-col :span="12">
                            {{ row.load10.toFixed(2) }}
                        </el-col>
                    </el-row>
                </template>
            </el-table-column>

            <el-table-column label="内存" align="center" width="150px">
                <template #default="{ row }">
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">全部:</el-col>
                        <el-col :span="8">
                            {{ (row.memTotal / 1024 / 1024 / 1024).toFixed(1) }}
                        </el-col>
                        <el-col :span="4">G</el-col>
                    </el-row>
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">已使用:</el-col>
                        <el-col :span="8">
                            {{ (row.memUse / 1024 / 1024 / 1024).toFixed(1) }}
                        </el-col>
                        <el-col :span="4">G</el-col>
                    </el-row>
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">剩余:</el-col>
                        <el-col :span="8">
                            {{ (row.memFree / 1024 / 1024 / 1024).toFixed(1) }}
                        </el-col>
                        <el-col :span="4">G</el-col>
                    </el-row>
                    <el-row style="text-align: start">
                        <el-col>
                            <el-progress
                                v-if="row.memUse / row.memTotal < 0.75"
                                :text-inside="true"
                                :stroke-width="15"
                                :percentage="
                                    ((100 * row.memUse) / row.memTotal).toFixed(
                                        1
                                    )
                                "
                            />
                            <el-progress
                                v-if="row.memUse / row.memTotal >= 0.75"
                                :text-inside="true"
                                :stroke-width="15"
                                :percentage="
                                    ((100 * row.memUse) / row.memTotal).toFixed(
                                        1
                                    )
                                "
                                status="exception"
                            />
                        </el-col>
                    </el-row>
                </template>
            </el-table-column>
            <el-table-column label="存储" align="center" width="150px">
                <template #default="{ row }">
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">全部:</el-col>
                        <el-col :span="8">
                            {{
                                (row.diskTotal / 1024 / 1024 / 1024).toFixed(1)
                            }}
                        </el-col>
                        <el-col :span="4">G</el-col>
                    </el-row>
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">已使用:</el-col>
                        <el-col :span="8">
                            {{ (row.diskUse / 1024 / 1024 / 1024).toFixed(1) }}
                        </el-col>
                        <el-col :span="4">G</el-col>
                    </el-row>
                    <el-row style="text-align: start; margin-bottom: 5px">
                        <el-col :span="12">剩余:</el-col>
                        <el-col :span="8">
                            {{ (row.diskFree / 1024 / 1024 / 1024).toFixed(1) }}
                        </el-col>
                        <el-col :span="4">G</el-col>
                    </el-row>
                    <el-row style="text-align: start">
                        <el-col>
                            <el-progress
                                v-if="row.diskUse / row.diskTotal < 0.75"
                                :text-inside="true"
                                :stroke-width="15"
                                :percentage="
                                    (
                                        (100 * row.diskUse) /
                                        row.diskTotal
                                    ).toFixed(1)
                                "
                            />
                            <el-progress
                                v-if="row.diskUse / row.diskTotal >= 0.75"
                                :text-inside="true"
                                :stroke-width="15"
                                :percentage="
                                    (
                                        (100 * row.diskUse) /
                                        row.diskTotal
                                    ).toFixed(1)
                                "
                                status="exception"
                            />
                        </el-col>
                    </el-row>
                </template>
            </el-table-column>
            <el-table-column
                label="操作"
                align="center"
                fixed="right"
                min-width="200px"
            >
                <template #default="{ row }">
                    <el-row>
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="primary"
                                @click="handleEdit(row)"
                            >
                                设备详情
                            </el-button>
                        </el-col>
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="primary"
                                @click="handleEdit(row)"
                            >
                                内网穿透
                            </el-button>
                        </el-col>
                    </el-row>

                    <el-row style="margin-top: 5px">
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="danger"
                                @click="rebootDevice(row)"
                            >
                                设备重启
                            </el-button>
                        </el-col>
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="info"
                                @click="handleEdit(row)"
                            >
                                控制指令
                            </el-button>
                        </el-col>
                    </el-row>

                    <el-row style="margin-top: 5px">
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="success"
                                @click="handleEdit(row)"
                            >
                                项目关联
                            </el-button>
                        </el-col>
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="warning"
                                @click="handleEdit(row)"
                            >
                                解除关联
                            </el-button>
                        </el-col>
                    </el-row>

                    <el-row style="margin-top: 5px">
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="default"
                                @click="installService(row)"
                            >
                                安装服务
                            </el-button>
                        </el-col>
                        <el-col :span="12">
                            <el-button
                                size="small"
                                type="default"
                                @click="uninstallService(row)"
                            >
                                卸载服务
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
        <service ref="serviceRef" @fetch-data="fetchData" />
    </div>
</template>

<script>
    import { Delete, Plus, Search } from '@element-plus/icons-vue'
    import { doDelete, getList } from '@/api/biz/device'
    import { useSharedDeviceWebSocket, WS_CLIENT_ID } from '@/utils/websocket'
    import { gp } from '@gp'

    export default defineComponent({
        name: 'DeviceManagement',
        components: {
            // 设备编辑
            Edit: defineAsyncComponent(
                () => import('./components/DeviceEdit.vue')
            ),
            // 服务管理
            Service: defineAsyncComponent(
                () => import('./components/DeviceServiceEdit.vue')
            ),
        },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                editRef: null,
                serviceRef: null,
                list: [],
                listLoading: true,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                selectRows: '',
                queryForm: {
                    pageNo: 1,
                    pageSize: 10,
                    deviceType: null,
                    projectId: null,
                    macAddress: null,
                },
            })

            const connected = ref(false)
            const loadingInstance = ref(undefined)

            const { client: ws, release: releaseWs } = useSharedDeviceWebSocket(
                '/resource/websocket',
                {
                    heartbeatInterval: 30000,
                    maxReconnectAttempts: 0, // 0 = 无限重连
                    clientId: WS_CLIENT_ID,
                    withAuth: true,
                }
            )

            provide('deviceWs', {
                send: (data) => ws.send(data),
                loadingInstance,
            })

            const offOpen = ws.on('open', () => {
                connected.value = true
            })
            const offMessage = ws.on('message', ({ data }) => {
                if (!loadingInstance.value) return

                if (data.code === 200) {
                    loadingInstance.value.setText(data.message)
                } else if (data.code === 500) {
                    $baseMessage(
                        data.message,
                        'warning',
                        'vab-hey-message-error'
                    )
                    loadingInstance.value.close()
                    loadingInstance.value = undefined
                } else if (data.code === 300) {
                    loadingInstance.value.close()
                    loadingInstance.value = undefined
                    $baseMessage(
                        data.message,
                        'warning',
                        'vab-hey-message-success'
                    )
                }
                console.log('设备消息:', data)
            })
            const offClose = ws.on('close', () => {
                connected.value = false
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

            const installService = (row) => {
                // 安装服务
                state.serviceRef.showEdit(row, 1)
            }

            const uninstallService = (row) => {
                // 卸载服务
                state.serviceRef.showEdit(row, 2)
            }

            const rebootDevice = (row) => {
                // 重启设备
                let deviceId = row.id
                $baseConfirm('你确定要重启当前设备吗', null, async () => {
                    ws.send({
                        deviceId: deviceId,
                        bizType: 'reboot',
                    })
                    loadingInstance.value = gp.$baseLoading(
                        0,
                        '请求数据至设备网关,请稍候...'
                    )
                })
            }

            const handleDelete = (row) => {
                if (row.id) {
                    $baseConfirm('你确定要删除当前项吗', null, async () => {
                        const { msg } = await doDelete({ ids: row.id })
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

            const formattedTime2 = (totalSeconds) => {
                const seconds = totalSeconds % 60
                const minutes = Math.floor(totalSeconds / 60) % 60
                const hours = Math.floor(totalSeconds / 3600) % 24
                const days = Math.floor(totalSeconds / 86400)
                return `${days}天 ${hours}时 ${minutes}分 ${seconds}秒`
            }

            onMounted(async () => {
                await ws.connect()
                await fetchData()
            })

            onUnmounted(async () => {
                offOpen()
                offMessage()
                offClose()
                releaseWs()
            })

            return {
                ...toRefs(state),
                setSelectRows,
                handleEdit,
                handleDelete,
                handleSizeChange,
                handleCurrentChange,
                formattedTime2,
                queryData,
                fetchData,
                Delete,
                Plus,
                Search,
                installService,
                uninstallService,
                rebootDevice,
            }
        },
    })
</script>
