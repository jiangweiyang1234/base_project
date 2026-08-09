<template>
    <div class="logininfor-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Delete" type="danger" @click="handleDelete()">批量删除</el-button>
                <el-button type="warning" @click="handleClean">清空</el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.userName" clearable placeholder="用户名称" />
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model.trim="queryForm.ipaddr" clearable placeholder="登录地址" />
                    </el-form-item>
                    <el-form-item>
                        <el-button :icon="Search" type="primary" @click="queryData">查询</el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>
        <el-table v-loading="listLoading" border :data="list" @selection-change="setSelectRows">
            <el-table-column type="selection" width="48" />
            <el-table-column label="用户名称" prop="userName" width="120" />
            <el-table-column label="地址" prop="ipaddr" width="130" />
            <el-table-column label="登录地点" prop="loginLocation" min-width="120" show-overflow-tooltip />
            <el-table-column label="浏览器" prop="browser" width="110" />
            <el-table-column label="系统" prop="os" width="110" />
            <el-table-column align="center" label="状态" width="80">
                <template #default="{ row }">
                    <el-tag v-if="row.status === '0'" type="success">成功</el-tag>
                    <el-tag v-else type="danger">失败</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="描述" prop="msg" min-width="140" show-overflow-tooltip />
            <el-table-column label="访问时间" prop="loginTime" width="170" />
            <el-table-column align="center" label="操作" width="140" fixed="right">
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleUnlock(row)">解锁</el-button>
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
    </div>
</template>
<script>
    import { Delete, Search } from '@element-plus/icons-vue'
    import {
        listLogininfor,
        delLogininfor,
        cleanLogininfor,
        unlockLogininfor,
    } from '@/api/monitor/logininfor'
    export default defineComponent({
        name: 'Logininfor',
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                list: [], listLoading: false, layout: 'total, sizes, prev, pager, next, jumper',
                total: 0, selectRows: [],
                queryForm: { pageNum: 1, pageSize: 10, userName: undefined, ipaddr: undefined },
            })
            const setSelectRows = (v) => { state.selectRows = v }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const res = await listLogininfor(state.queryForm)
                    state.list = res.rows || []
                    state.total = res.total || 0
                } finally { state.listLoading = false }
            }
            const handleDelete = (row) => {
                if (row?.infoId) {
                    $baseConfirm('确认删除？', null, async () => {
                        const { msg } = await delLogininfor(row.infoId)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else if (state.selectRows.length) {
                    const ids = state.selectRows.map((i) => i.infoId).join(',')
                    $baseConfirm('确认删除选中？', null, async () => {
                        const { msg } = await delLogininfor(ids)
                        $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                        await fetchData()
                    })
                } else $baseMessage('未选中任何行', 'error', 'vab-hey-message-error')
            }
            const handleClean = () => {
                $baseConfirm('确认清空全部登录日志吗？', null, async () => {
                    const { msg } = await cleanLogininfor()
                    $baseMessage(msg || '已清空', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleUnlock = async (row) => {
                const { msg } = await unlockLogininfor(row.userName)
                $baseMessage(msg || '已解锁', 'success', 'vab-hey-message-success')
            }
            const queryData = () => { state.queryForm.pageNum = 1; fetchData() }
            onMounted(() => fetchData())
            return {
                ...toRefs(state), setSelectRows, handleDelete, handleClean, handleUnlock,
                queryData, fetchData, Delete, Search,
            }
        },
    })
</script>
