import request from '@/utils/request'

/** 运行中实例 */
export function pageByRunning(params?: any) {
    return request({
        url: '/workflow/instance/pageByRunning',
        method: 'get',
        params,
    })
}

/** 已完成实例 */
export function pageByFinish(params?: any) {
    return request({
        url: '/workflow/instance/pageByFinish',
        method: 'get',
        params,
    })
}

/** 当前用户发起的实例 */
export function pageByCurrent(params?: any) {
    return request({
        url: '/workflow/instance/pageByCurrent',
        method: 'get',
        params,
    })
}

/** 实例详情（按业务 ID） */
export function getInstanceInfo(businessId: string | number) {
    return request({
        url: `/workflow/instance/getInfo/${businessId}`,
        method: 'get',
    })
}

/** 历史任务 */
export function flowHisTaskList(businessId: string | number) {
    return request({
        url: `/workflow/instance/flowHisTaskList/${businessId}`,
        method: 'get',
    })
}

/** 按实例 ID 删除 */
export function deleteByInstanceIds(
    instanceIds: string | number | Array<string | number>
) {
    return request({
        url: `/workflow/instance/deleteByInstanceIds/${instanceIds}`,
        method: 'delete',
    })
}

/** 按业务 ID 删除 */
export function deleteByBusinessIds(
    businessIds: string | number | Array<string | number>
) {
    return request({
        url: `/workflow/instance/deleteByBusinessIds/${businessIds}`,
        method: 'delete',
    })
}

/** 撤销申请 */
export function cancelProcessApply(data: any) {
    return request({
        url: '/workflow/instance/cancelProcessApply',
        method: 'put',
        data,
    })
}

/** 激活 / 挂起实例 */
export function activeInstance(id: string | number, active: boolean) {
    return request({
        url: `/workflow/instance/active/${id}`,
        method: 'put',
        params: { active },
    })
}

/** 作废 */
export function invalidInstance(data: any) {
    return request({
        url: '/workflow/instance/invalid',
        method: 'post',
        data,
    })
}
