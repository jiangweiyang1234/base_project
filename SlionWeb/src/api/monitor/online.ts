import request from '@/utils/request'

export function listOnline(params?: any) {
    return request({ url: '/monitor/online/list', method: 'get', params })
}
export function forceLogout(tokenId: string) {
    return request({ url: `/monitor/online/${tokenId}`, method: 'delete' })
}
