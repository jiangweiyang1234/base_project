import request from '@/utils/request'

export function listClient(params?: any) {
    return request({ url: '/system/client/list', method: 'get', params })
}
export function getClient(id: string | number) {
    return request({ url: `/system/client/${id}`, method: 'get' })
}
export function addClient(data: any) {
    return request({ url: '/system/client', method: 'post', data })
}
export function updateClient(data: any) {
    return request({ url: '/system/client', method: 'put', data })
}
export function delClient(ids: string | number | Array<string | number>) {
    return request({ url: `/system/client/${ids}`, method: 'delete' })
}
export function changeClientStatus(data: { clientId: string; status: string }) {
    return request({ url: '/system/client/changeStatus', method: 'put', data })
}
