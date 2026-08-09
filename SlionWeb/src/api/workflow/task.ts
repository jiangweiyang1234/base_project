import request from '@/utils/request'

/** 待办任务 */
export function pageByTaskWait(params?: any) {
    return request({
        url: '/workflow/task/pageByTaskWait',
        method: 'get',
        params,
    })
}

/** 已办任务 */
export function pageByTaskFinish(params?: any) {
    return request({
        url: '/workflow/task/pageByTaskFinish',
        method: 'get',
        params,
    })
}

/** 全部待办 */
export function pageByAllTaskWait(params?: any) {
    return request({
        url: '/workflow/task/pageByAllTaskWait',
        method: 'get',
        params,
    })
}

/** 全部已办 */
export function pageByAllTaskFinish(params?: any) {
    return request({
        url: '/workflow/task/pageByAllTaskFinish',
        method: 'get',
        params,
    })
}

/** 抄送任务 */
export function pageByTaskCopy(params?: any) {
    return request({
        url: '/workflow/task/pageByTaskCopy',
        method: 'get',
        params,
    })
}

/** 任务详情 */
export function getTask(taskId: string | number) {
    return request({
        url: `/workflow/task/getTask/${taskId}`,
        method: 'get',
    })
}

/** 办理任务 */
export function completeTask(data: any) {
    return request({
        url: '/workflow/task/completeTask',
        method: 'post',
        data,
    })
}

/** 启动流程 */
export function startWorkFlow(data: any) {
    return request({
        url: '/workflow/task/startWorkFlow',
        method: 'post',
        data,
    })
}

/** 终止任务 */
export function terminationTask(data: any) {
    return request({
        url: '/workflow/task/terminationTask',
        method: 'post',
        data,
    })
}

/** 退回 */
export function backProcess(data: any) {
    return request({
        url: '/workflow/task/backProcess',
        method: 'post',
        data,
    })
}
