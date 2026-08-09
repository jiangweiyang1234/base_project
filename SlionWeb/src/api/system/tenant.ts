import request from '@/utils/request'

/** 租户列表 */
export function listTenant(params?: any) {
    return request({
        url: '/system/tenant/list',
        method: 'get',
        params,
    })
}

/** 租户详情 */
export function getTenant(id: string | number) {
    return request({
        url: `/system/tenant/${id}`,
        method: 'get',
    })
}

/** 新增租户 */
export function addTenant(data: any) {
    return request({
        url: '/system/tenant',
        method: 'post',
        data,
    })
}

/** 修改租户 */
export function updateTenant(data: any) {
    return request({
        url: '/system/tenant',
        method: 'put',
        data,
    })
}

/** 删除租户 */
export function delTenant(ids: string | number | Array<string | number>) {
    return request({
        url: `/system/tenant/${ids}`,
        method: 'delete',
    })
}

/** 修改租户状态 */
export function changeTenantStatus(data: {
    id: string | number
    tenantId: string
    status: string
}) {
    return request({
        url: '/system/tenant/changeStatus',
        method: 'put',
        data,
    })
}

/** 动态切换租户 */
export function dynamicTenant(tenantId: string) {
    return request({
        url: `/system/tenant/dynamic/${tenantId}`,
        method: 'get',
    })
}

/** 清除动态租户 */
export function dynamicClear() {
    return request({
        url: '/system/tenant/dynamic/clear',
        method: 'get',
    })
}

/** 租户套餐下拉 */
export function selectTenantPackage() {
    return request({
        url: '/system/tenant/package/selectList',
        method: 'get',
    })
}

/** 租户套餐列表 */
export function listTenantPackage(params?: any) {
    return request({
        url: '/system/tenant/package/list',
        method: 'get',
        params,
    })
}
