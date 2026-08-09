<template>
    <div class="oauth-client-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Plus" type="primary" @click="handleEdit()">添加</el-button>
                <el-button :icon="Delete" type="danger" @click="handleDelete()">批量删除</el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.appName" clearable placeholder="应用名称" />
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.appKey" clearable placeholder="AppKey" />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">查询</el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>
        <el-table v-loading="listLoading" border :data="list" @selection-change="setSelectRows">
            <el-table-column type="selection" width="48" />
            <el-table-column label="应用名称" prop="appName" min-width="120" />
            <el-table-column label="AppKey" prop="appKey" min-width="180" show-overflow-tooltip />
            <el-table-column label="授权类型" prop="grantTypes" min-width="140" />
            <el-table-column label="范围" prop="scopes" width="120" />
            <el-table-column label="TTL" prop="accessTokenTtl" width="90" />
            <el-table-column align="center" label="状态" width="90">
                <template #default="{ row }">
                    <el-switch
                        v-model="row.status"
                        active-value="0"
                        inactive-value="1"
                        @change="handleStatus(row)"
                    />
                </template>
            </el-table-column>
            <el-table-column align="center" label="操作" width="220" fixed="right">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleEdit(row)">编辑</el-button>
                    <el-button text type="primary" @click="handleResetSecret(row)">重置密钥</el-button>
                    <el-button text type="primary" @click="handleDelete(row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
            background
            :current-page="queryForm.pageNum"
            :layout="layout"
            :page-size="queryForm.pageSize"
            :total="total"
            @current-change="(v) => { queryForm.pageNum = v; fetchData() }"
            @size-change="(v) => { queryForm.pageSize = v; fetchData() }"
        />
        <edit ref="editRef" @created-secret="showSecret" @fetch-data="fetchData" />
        <el-dialog v-model="secretVisible" title="请妥善保存 AppSecret（仅显示一次）" width="520px">
            <el-descriptions :column="1" border>
                <el-descriptions-item label="AppKey">{{ secretInfo.appKey }}</el-descriptions-item>
                <el-descriptions-item label="AppSecret">{{ secretInfo.appSecretPlain }}</el-descriptions-item>
            </el-descriptions>
        </el-dialog>
    </div>
</template>
<script>
    import { Delete, Plus, Search } from '@element-plus/icons-vue'
    import {
        listOauthClient,
        delOauthClient,
        resetOauthClientSecret,
        changeOauthClientStatus,
    } from '@/api/system/oauthClient'

    export default defineComponent({
        name: 'OauthClient',
        components: {
            Edit: defineAsyncComponent(() => import('./components/OauthClientEdit.vue')),
        },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                editRef: null,
                list: [],
                listLoading: false,
                layout: 'total, sizes, prev, pager, next, jumper',
                total: 0,
                selectRows: [],
                queryForm: { pageNum: 1, pageSize: 10, appName: undefined, appKey: undefined },
                secretVisible: false,
                secretInfo: { appKey: '', appSecretPlain: '' },
            })
            const setSelectRows = (v) => { state.selectRows = v }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const res = await listOauthClient(state.queryForm)
                    state.list = res.rows || []
                    state.total = res.total || 0
                } finally {
                    state.listLoading = false
                }
            }
            const handleEdit = (row) => {
                if (row?.id) state.editRef.showEdit(row)
                else state.editRef.showEdit()
            }
            const handleDelete = (row) => {
                if (row?.id) {
                    $baseConfirm('确认删除该应用吗？', null, async () => {
                        const { msg } = await delOauthClient(row.id)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length) {
                    const ids = state.selectRows.map((i) => i.id).join(',')
                    $baseConfirm('确认删除选中应用吗？', null, async () => {
                        const { msg } = await delOauthClient(ids)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else {
                    $baseMessage('未选中任何行', 'error', 'vab-hey-message-error')
                }
            }
            const handleStatus = async (row) => {
                try {
                    const { msg } = await changeOauthClientStatus({ id: row.id, status: row.status })
                    $baseMessage(msg || '状态已更新', 'success', 'vab-hey-message-success')
                } catch {
                    row.status = row.status === '0' ? '1' : '0'
                }
            }
            const handleResetSecret = (row) => {
                $baseConfirm('确认重置 AppSecret 吗？旧密钥将立即失效', null, async () => {
                    const res = await resetOauthClientSecret(row.id)
                    $baseMessage(res.msg || '已重置', 'success', 'vab-hey-message-success')
                    if (res.data?.appSecretPlain) {
                        showSecret({
                            appKey: res.data.appKey || row.appKey,
                            appSecretPlain: res.data.appSecretPlain,
                        })
                    }
                })
            }
            const showSecret = (info) => {
                state.secretInfo = info
                state.secretVisible = true
            }
            const queryData = () => { state.queryForm.pageNum = 1; fetchData() }
            onMounted(() => fetchData())
            return {
                ...toRefs(state),
                setSelectRows,
                handleEdit,
                handleDelete,
                handleStatus,
                handleResetSecret,
                showSecret,
                queryData,
                fetchData,
                Delete,
                Plus,
                Search,
            }
        },
    })
</script>
