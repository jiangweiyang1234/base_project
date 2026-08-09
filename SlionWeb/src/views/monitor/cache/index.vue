<template>
    <div class="cache-monitor-container auto-height-container" v-loading="loading">
        <el-row :gutter="16">
            <el-col :span="8">
                <el-card shadow="hover">
                    <template #header>基本信息</template>
                    <el-descriptions :column="1" border>
                        <el-descriptions-item label="Redis 版本">
                            {{ info.redis_version || '-' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="运行模式">
                            {{ info.redis_mode || '-' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="端口">
                            {{ info.tcp_port || '-' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="客户端数">
                            {{ info.connected_clients || '-' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="运行天数">
                            {{ info.uptime_in_days || '-' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="使用内存">
                            {{ info.used_memory_human || '-' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="AOF">
                            {{ info.aof_enabled === '0' ? '关闭' : '开启' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="RDB">
                            {{ info.rdb_last_bgsave_status || '-' }}
                        </el-descriptions-item>
                        <el-descriptions-item label="Key 数量">
                            {{ dbSize }}
                        </el-descriptions-item>
                    </el-descriptions>
                </el-card>
            </el-col>
            <el-col :span="16">
                <el-card shadow="hover">
                    <template #header>
                        命令统计
                        <el-button style="float: right" text type="primary" @click="fetchData">
                            刷新
                        </el-button>
                    </template>
                    <el-table :data="commandStats" border max-height="520">
                        <el-table-column label="命令" prop="name" />
                        <el-table-column label="调用次数" prop="value" />
                    </el-table>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>
<script>
    import { getCache } from '@/api/monitor/cache'
    export default defineComponent({
        name: 'CacheMonitor',
        setup() {
            const state = reactive({
                loading: false,
                info: {},
                dbSize: 0,
                commandStats: [],
            })
            const fetchData = async () => {
                state.loading = true
                try {
                    const { data } = await getCache()
                    state.info = data?.info || {}
                    state.dbSize = data?.dbSize || 0
                    state.commandStats = data?.commandStats || []
                } finally {
                    state.loading = false
                }
            }
            onMounted(() => fetchData())
            return { ...toRefs(state), fetchData }
        },
    })
</script>
