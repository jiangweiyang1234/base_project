import request from '@/utils/request'

/** 菜单列表（平铺，前端自行建树） */
export function listMenu(params?: any) {
    return request({
        url: '/system/menu/list',
        method: 'get',
        params,
    })
}

/** 菜单详情 */
export function getMenu(menuId: string | number) {
    return request({
        url: `/system/menu/${menuId}`,
        method: 'get',
    })
}

/** 菜单下拉树 */
export function treeselect(params?: any) {
    return request({
        url: '/system/menu/treeselect',
        method: 'get',
        params,
    })
}

/** 角色菜单树（含勾选） */
export function roleMenuTreeselect(roleId: string | number) {
    return request({
        url: `/system/menu/roleMenuTreeselect/${roleId}`,
        method: 'get',
    })
}

/** 新增菜单 */
export function addMenu(data: any) {
    return request({
        url: '/system/menu',
        method: 'post',
        data,
    })
}

/** 修改菜单 */
export function updateMenu(data: any) {
    return request({
        url: '/system/menu',
        method: 'put',
        data,
    })
}

/** 删除菜单 */
export function delMenu(menuId: string | number) {
    return request({
        url: `/system/menu/${menuId}`,
        method: 'delete',
    })
}

/** 获取路由（动态菜单） */
export function getRouters() {
    return request({
        url: '/system/menu/getRouters',
        method: 'get',
    })
}
