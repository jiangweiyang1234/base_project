import request from '@/utils/request'

export function listNotice(params?: any) {
    return request({ url: '/system/notice/list', method: 'get', params })
}
export function getNotice(noticeId: string | number) {
    return request({ url: `/system/notice/${noticeId}`, method: 'get' })
}
export function addNotice(data: any) {
    return request({ url: '/system/notice', method: 'post', data })
}
export function updateNotice(data: any) {
    return request({ url: '/system/notice', method: 'put', data })
}
export function delNotice(noticeIds: string | number | Array<string | number>) {
    return request({ url: `/system/notice/${noticeIds}`, method: 'delete' })
}
