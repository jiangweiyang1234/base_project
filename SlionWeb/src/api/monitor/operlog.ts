import request from '@/utils/request'

export function listOperlog(params?: any) {
    return request({ url: '/monitor/operlog/list', method: 'get', params })
}
export function delOperlog(operIds: string | number | Array<string | number>) {
    return request({ url: `/monitor/operlog/${operIds}`, method: 'delete' })
}
export function cleanOperlog() {
    return request({ url: '/monitor/operlog/clean', method: 'delete' })
}
