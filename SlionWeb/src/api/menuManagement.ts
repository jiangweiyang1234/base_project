/** @deprecated 请使用 @/api/system/menu */
export {
    listMenu,
    treeselect as getTree,
    addMenu,
    updateMenu,
    delMenu as doDelete,
    getMenu,
    roleMenuTreeselect,
    getRouters,
} from '@/api/system/menu'

import { addMenu, updateMenu } from '@/api/system/menu'

export function doEdit(data: any) {
    return data?.menuId ? updateMenu(data) : addMenu(data)
}
