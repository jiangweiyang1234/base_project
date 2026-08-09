<template>
    <div class="online-container auto-height-container">
        <vab-query-form>
            <vab-query-form-right-panel :span="24">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.ipaddr" clearable placeholder="登录地址" />
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.userName" clearable placeholder="用户名称" />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">查询</el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>
        <el-table v-loading="listLoading" border :data="list">
            <el-table-column label="会话编号" prop="tokenId" min-width="180" show-overflow-tooltip />
            <el-table-column label="用户名称" prop="userName" width="120" />
            <el-table-column label="部门" prop="deptName" width="120" />
            <el-table-column label="主机" prop="ipaddr" width="130" />
            <el-table-column label="登录地点" prop="loginLocation" min-width="120" show-overflow-tooltip />
            <el-table-column label="浏览器" prop="browser" width="110" />
            <el-table-column label="系统" prop="os" width="110" />
            <el-table-column label="登录时间" prop="loginTime" width="170" />
            <el-table-column align="center" label="操作" width="100" fixed="right">
                <template #default="{ row }">
                    <el-button text type="danger" @click="handleForce(row)">强退</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>
<script>
    import { Search } from '@element-plus/icons-vue'
    import { listOnline, forceLogout } from '@/api/monitor/online'
    export default defineComponent({
        name: 'OnlineUser',
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                list: [],
                listLoading: false,
                queryForm: { ipaddr: undefined, userName: undefined },
            })
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const res = await listOnline(state.queryForm)
                    // TableDataInfo or R.ok(list)
                    state.list = res.rows || res.data || []
                } finally {
                    state.listLoading = false
                }
            }
            const handleForce = (row) => {
                $baseConfirm(`确认强退用户 ${row.userName} 吗？`, null, async () => {
                    const { msg } = await forceLogout(row.tokenId)
                    $baseMessage(msg || '已强退', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const queryData = () => fetchData()
            onMounted(() => fetchData())
            return { ...toRefs(state), handleForce, queryData, Search }
        },
    })
</script>
