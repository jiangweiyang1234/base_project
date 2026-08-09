import request from '@/utils/request'

/** 开放应用列表 */
export function listOauthClient(params?: any) {
    return request({
        url: '/system/oauthClient/list',
        method: 'get',
        params,
    })
}

/** 开放应用详情 */
export function getOauthClient(id: string | number) {
    return request({
        url: `/system/oauthClient/${id}`,
        method: 'get',
    })
}

/** 新增开放应用（响应含 appSecretPlain，仅一次） */
export function addOauthClient(data: any) {
    return request({
        url: '/system/oauthClient',
        method: 'post',
        data,
    })
}

/** 修改开放应用 */
export function updateOauthClient(data: any) {
    return request({
        url: '/system/oauthClient',
        method: 'put',
        data,
    })
}

/** 删除开放应用 */
export function delOauthClient(ids: string | number | Array<string | number>) {
    return request({
        url: `/system/oauthClient/${ids}`,
        method: 'delete',
    })
}

/** 重置 AppSecret（响应含 appSecretPlain，仅一次） */
export function resetOauthClientSecret(id: string | number) {
    return request({
        url: `/system/oauthClient/resetSecret/${id}`,
        method: 'put',
    })
}

/** 修改状态 */
export function changeOauthClientStatus(data: {
    id: string | number
    status: string
}) {
    return request({
        url: '/system/oauthClient/changeStatus',
        method: 'put',
        data,
    })
}
