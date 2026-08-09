import request from '@/utils/request'

export function listLogininfor(params?: any) {
    return request({ url: '/monitor/logininfor/list', method: 'get', params })
}
export function delLogininfor(infoIds: string | number | Array<string | number>) {
    return request({ url: `/monitor/logininfor/${infoIds}`, method: 'delete' })
}
export function cleanLogininfor() {
    return request({ url: '/monitor/logininfor/clean', method: 'delete' })
}
export function unlockLogininfor(userName: string) {
    return request({ url: `/monitor/logininfor/unlock/${userName}`, method: 'get' })
}
