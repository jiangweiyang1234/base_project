<template>
    <div class="menu-management-container auto-height-container">
        <vab-query-form>
            <vab-query-form-left-panel :span="12">
                <el-button :icon="Plus" type="primary" @click="handleEdit()">
                    添加
                </el-button>
                <el-button @click="toggleExpandAll">
                    展开/折叠
                </el-button>
            </vab-query-form-left-panel>
            <vab-query-form-right-panel :span="12">
                <el-form inline :model="queryForm" @submit.prevent>
                    <el-form-item>
                        <el-input
                            v-model.trim="queryForm.menuName"
                            clearable
                            placeholder="菜单名称"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-button
                            :icon="Search"
                            type="primary"
                            @click="fetchData"
                        >
                            查询
                        </el-button>
                    </el-form-item>
                </el-form>
            </vab-query-form-right-panel>
        </vab-query-form>

        <el-table
            v-if="refreshTable"
            v-loading="listLoading"
            border
            :data="list"
            :default-expand-all="isExpandAll"
            row-key="menuId"
            :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
        >
            <el-table-column
                label="菜单名称"
                prop="menuName"
                show-overflow-tooltip
                width="180"
            />
            <el-table-column
                align="center"
                label="图标"
                prop="icon"
                width="80"
            >
                <template #default="{ row }">
                    <vab-icon v-if="row.icon && row.icon !== '#'" :icon="row.icon" />
                </template>
            </el-table-column>
            <el-table-column
                align="center"
                label="排序"
                prop="orderNum"
                width="70"
            />
            <el-table-column
                label="权限标识"
                prop="perms"
                show-overflow-tooltip
            />
            <el-table-column
                label="组件路径"
                prop="component"
                show-overflow-tooltip
            />
            <el-table-column align="center" label="状态" width="80">
                <template #default="{ row }">
                    <el-tag v-if="row.status === '0'">正常</el-tag>
                    <el-tag v-else type="danger">停用</el-tag>
                </template>
            </el-table-column>
            <el-table-column align="center" label="类型" width="80">
                <template #default="{ row }">
                    {{
                        { M: '目录', C: '菜单', F: '按钮' }[row.menuType] ||
                        row.menuType
                    }}
                </template>
            </el-table-column>
            <el-table-column
                align="center"
                label="操作"
                show-overflow-tooltip
                width="200"
            >
                <template #default="{ row }">
                    <el-button text type="primary" @click="handleEdit(row)">
                        编辑
                    </el-button>
                    <el-button text type="primary" @click="handleAddChild(row)">
                        新增
                    </el-button>
                    <el-button text type="primary" @click="handleDelete(row)">
                        删除
                    </el-button>
                </template>
            </el-table-column>
            <template #empty>
                <el-empty class="vab-data-empty" description="暂无数据" />
            </template>
        </el-table>
        <edit ref="editRef" @fetch-data="fetchData" />
    </div>
</template>

<script>
    import { Plus, Search } from '@element-plus/icons-vue'
    import { delMenu, listMenu } from '@/api/system/menu'
    import { handleTree } from '@/api/system/dept'

    export default defineComponent({
        name: 'MenuManagement',
        components: {
            Edit: defineAsyncComponent(
                () => import('./components/MenuManagementEdit')
            ),
        },
        setup() {
            const $baseConfirm = inject('$baseConfirm')
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                editRef: null,
                list: [],
                listLoading: true,
                isExpandAll: true,
                refreshTable: true,
                queryForm: {
                    menuName: '',
                },
            })

            const handleEdit = (row) => {
                state.editRef.showEdit(row)
            }
            const handleAddChild = (row) => {
                state.editRef.showEdit({ parentId: row.menuId })
            }
            const handleDelete = (row) => {
                $baseConfirm('你确定要删除当前菜单吗', null, async () => {
                    const { msg } = await delMenu(row.menuId)
                    $baseMessage(msg, 'success', 'vab-hey-message-success')
                    await fetchData()
                })
            }
            const toggleExpandAll = () => {
                state.refreshTable = false
                state.isExpandAll = !state.isExpandAll
                nextTick(() => {
                    state.refreshTable = true
                })
            }
            const fetchData = async () => {
                state.listLoading = true
                try {
                    const { data } = await listMenu(state.queryForm)
                    state.list = handleTree(data || [], 'menuId', 'parentId')
                } finally {
                    state.listLoading = false
                }
            }

            onMounted(() => {
                fetchData()
            })

            return {
                ...toRefs(state),
                handleEdit,
                handleAddChild,
                handleDelete,
                toggleExpandAll,
                fetchData,
                Plus,
                Search,
            }
        },
    })
</script>
