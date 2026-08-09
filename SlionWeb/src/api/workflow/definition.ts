import request from '@/utils/request'

/** 流程定义列表 */
export function listDefinition(params?: any) {
    return request({
        url: '/workflow/definition/list',
        method: 'get',
        params,
    })
}

/** 未发布流程定义列表 */
export function listUnPublishDefinition(params?: any) {
    return request({
        url: '/workflow/definition/unPublishList',
        method: 'get',
        params,
    })
}

/** 流程定义详情 */
export function getDefinition(id: string | number) {
    return request({
        url: `/workflow/definition/${id}`,
        method: 'get',
    })
}

/** 新增流程定义 */
export function addDefinition(data: any) {
    return request({
        url: '/workflow/definition',
        method: 'post',
        data,
    })
}

/** 修改流程定义 */
export function updateDefinition(data: any) {
    return request({
        url: '/workflow/definition',
        method: 'put',
        data,
    })
}

/** 发布 */
export function publishDefinition(id: string | number) {
    return request({
        url: `/workflow/definition/publish/${id}`,
        method: 'put',
    })
}

/** 取消发布 */
export function unPublishDefinition(id: string | number) {
    return request({
        url: `/workflow/definition/unPublish/${id}`,
        method: 'put',
    })
}

/** 删除 */
export function delDefinition(ids: string | number | Array<string | number>) {
    return request({
        url: `/workflow/definition/${ids}`,
        method: 'delete',
    })
}

/** 复制 */
export function copyDefinition(id: string | number) {
    return request({
        url: `/workflow/definition/copy/${id}`,
        method: 'post',
    })
}

/** 激活 / 挂起 */
export function activeDefinition(id: string | number, active: boolean) {
    return request({
        url: `/workflow/definition/active/${id}`,
        method: 'put',
        params: { active },
    })
}

/** 功能开关 */
export function getFeatureFlags() {
    return request({
        url: '/workflow/feature/flags',
        method: 'get',
    })
}
