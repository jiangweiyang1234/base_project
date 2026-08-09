import request from '@/utils/request'

/** 角色列表 */
export function listRole(params?: any) {
    return request({
        url: '/system/role/list',
        method: 'get',
        params,
    })
}

/** 角色详情 */
export function getRole(roleId: string | number) {
    return request({
        url: `/system/role/${roleId}`,
        method: 'get',
    })
}

/** 新增角色 */
export function addRole(data: any) {
    return request({
        url: '/system/role',
        method: 'post',
        data,
    })
}

/** 修改角色 */
export function updateRole(data: any) {
    return request({
        url: '/system/role',
        method: 'put',
        data,
    })
}

/** 删除角色 */
export function delRole(roleIds: string | number | Array<string | number>) {
    return request({
        url: `/system/role/${roleIds}`,
        method: 'delete',
    })
}

/** 修改角色状态 */
export function changeRoleStatus(data: { roleId: string | number; status: string }) {
    return request({
        url: '/system/role/changeStatus',
        method: 'put',
        data,
    })
}

/** 修改数据权限 */
export function dataScope(data: any) {
    return request({
        url: '/system/role/dataScope',
        method: 'put',
        data,
    })
}

/** 角色部门树 */
export function roleDeptTreeselect(roleId: string | number) {
    return request({
        url: `/system/role/deptTree/${roleId}`,
        method: 'get',
    })
}

/** 角色下拉选项 */
export function optionselect() {
    return request({
        url: '/system/role/optionselect',
        method: 'get',
    })
}
