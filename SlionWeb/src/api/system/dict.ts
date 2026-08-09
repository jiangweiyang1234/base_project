import request from '@/utils/request'

export function listDictType(params?: any) {
    return request({ url: '/system/dict/type/list', method: 'get', params })
}
export function getDictType(dictId: string | number) {
    return request({ url: `/system/dict/type/${dictId}`, method: 'get' })
}
export function addDictType(data: any) {
    return request({ url: '/system/dict/type', method: 'post', data })
}
export function updateDictType(data: any) {
    return request({ url: '/system/dict/type', method: 'put', data })
}
export function delDictType(dictIds: string | number | Array<string | number>) {
    return request({ url: `/system/dict/type/${dictIds}`, method: 'delete' })
}
export function refreshDictCache() {
    return request({ url: '/system/dict/type/refreshCache', method: 'delete' })
}
export function listDictData(params?: any) {
    return request({ url: '/system/dict/data/list', method: 'get', params })
}
export function getDictData(dictCode: string | number) {
    return request({ url: `/system/dict/data/${dictCode}`, method: 'get' })
}
export function getDicts(dictType: string) {
    return request({ url: `/system/dict/data/type/${dictType}`, method: 'get' })
}
export function addDictData(data: any) {
    return request({ url: '/system/dict/data', method: 'post', data })
}
export function updateDictData(data: any) {
    return request({ url: '/system/dict/data', method: 'put', data })
}
export function delDictData(dictCodes: string | number | Array<string | number>) {
    return request({ url: `/system/dict/data/${dictCodes}`, method: 'delete' })
}
