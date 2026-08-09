<template>
    <div class="dict-management-container auto-height-container">
        <el-row :gutter="12">
            <el-col :span="10">
                <vab-query-form>
                    <vab-query-form-left-panel :span="24">
                        <el-button :icon="Plus" type="primary" @click="handleTypeEdit()">添加</el-button>
                        <el-button :icon="Refresh" @click="handleRefreshCache">刷新缓存</el-button>
                    </vab-query-form-left-panel>
                </vab-query-form>
                <el-table
                    v-loading="typeLoading"
                    border
                    :data="typeList"
                    highlight-current-row
                    @current-change="handleTypeSelect"
                >
                    <el-table-column label="字典名称" prop="dictName" show-overflow-tooltip />
                    <el-table-column label="字典类型" prop="dictType" show-overflow-tooltip />
                    <el-table-column align="center" label="操作" width="140">
                        <template #default="{ row }">
                            <el-button text type="primary" @click.stop="handleTypeEdit(row)">编辑</el-button>
                            <el-button text type="primary" @click.stop="handleTypeDelete(row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-col>
            <el-col :span="14">
                <vab-query-form>
                    <vab-query-form-left-panel :span="24">
                        <el-button
                            :disabled="!currentType"
                            :icon="Plus"
                            type="primary"
                            @click="handleDataEdit()"
                        >
                            添加数据
                        </el-button>
                        <span v-if="currentType" style="margin-left: 12px">
                            当前类型：{{ currentType.dictType }}
                        </span>
                    </vab-query-form-left-panel>
                </vab-query-form>
                <el-table v-loading="dataLoading" border :data="dataList">
                    <el-table-column label="标签" prop="dictLabel" />
                    <el-table-column label="键值" prop="dictValue" />
                    <el-table-column label="排序" prop="dictSort" width="70" />
                    <el-table-column align="center" label="操作" width="140">
                        <template #default="{ row }">
                            <el-button text type="primary" @click="handleDataEdit(row)">编辑</el-button>
                            <el-button text type="primary" @click="handleDataDelete(row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-col>
        </el-row>
        <type-edit ref="typeEditRef" @fetch-data="fetchTypes" />
        <data-edit ref="dataEditRef" @fetch-data="fetchData" />
    </div>
</template>
<script>
    import { Plus, Refresh } from '@element-plus/icons-vue'
    import {
        listDictType,
        delDictType,
        listDictData,
        delDictData,
        refreshDictCache,
    } from '@/api/system/dict'

    export default defineComponent({
        name: 'DictManagement',
        components: {
            TypeEdit: defineAsyncComponent(() => import('./components/DictTypeEdit.vue')),
            DataEdit: defineAsyncComponent(() => import('./components/DictDataEdit.vue')),
        },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                typeEditRef: null,
                dataEditRef: null,
                typeList: [],
                dataList: [],
                typeLoading: false,
                dataLoading: false,
                currentType: null,
            })
            const fetchTypes = async () => {
                state.typeLoading = true
                try {
                    const res = await listDictType({ pageNum: 1, pageSize: 200 })
                    state.typeList = res.rows || []
                } finally {
                    state.typeLoading = false
                }
            }
            const fetchData = async () => {
                if (!state.currentType) {
                    state.dataList = []
                    return
                }
                state.dataLoading = true
                try {
                    const res = await listDictData({
                        pageNum: 1,
                        pageSize: 200,
                        dictType: state.currentType.dictType,
                    })
                    state.dataList = res.rows || []
                } finally {
                    state.dataLoading = false
                }
            }
            const handleTypeSelect = (row) => {
                state.currentType = row
                fetchData()
            }
            const handleTypeEdit = (row) => state.typeEditRef.showEdit(row)
            const handleTypeDelete = (row) => {
                $baseConfirm('确认删除该字典类型吗？', null, async () => {
                    const { msg } = await delDictType(row.dictId)
                    $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                    if (state.currentType?.dictId === row.dictId) {
                        state.currentType = null
                        state.dataList = []
                    }
                    await fetchTypes()
                })
            }
            const handleDataEdit = (row) =>
                state.dataEditRef.showEdit(row, state.currentType?.dictType)
            const handleDataDelete = (row) => {
                $baseConfirm('确认删除该字典数据吗？', null, async () => {
                    const { msg } = await delDictData(row.dictCode)
                    $baseMessage(msg || '删除成功', 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const handleRefreshCache = async () => {
                const { msg } = await refreshDictCache()
                $baseMessage(msg || '刷新成功', 'success', 'vab-hey-message-success')
            }
            onMounted(() => fetchTypes())
            return {
                ...toRefs(state),
                handleTypeSelect,
                handleTypeEdit,
                handleTypeDelete,
                handleDataEdit,
                handleDataDelete,
                handleRefreshCache,
                fetchTypes,
                fetchData,
                Plus,
                Refresh,
            }
        },
    })
</script>
