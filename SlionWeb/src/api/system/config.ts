import request from '@/utils/request'

export function listConfig(params?: any) {
    return request({ url: '/system/config/list', method: 'get', params })
}
export function getConfig(configId: string | number) {
    return request({ url: `/system/config/${configId}`, method: 'get' })
}
export function addConfig(data: any) {
    return request({ url: '/system/config', method: 'post', data })
}
export function updateConfig(data: any) {
    return request({ url: '/system/config', method: 'put', data })
}
export function delConfig(configIds: string | number | Array<string | number>) {
    return request({ url: `/system/config/${configIds}`, method: 'delete' })
}
export function refreshConfigCache() {
    return request({ url: '/system/config/refreshCache', method: 'delete' })
}
