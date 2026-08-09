import request from '@/utils/request'

export function listPost(params?: any) {
    return request({ url: '/system/post/list', method: 'get', params })
}
export function getPost(postId: string | number) {
    return request({ url: `/system/post/${postId}`, method: 'get' })
}
export function addPost(data: any) {
    return request({ url: '/system/post', method: 'post', data })
}
export function updatePost(data: any) {
    return request({ url: '/system/post', method: 'put', data })
}
export function delPost(postIds: string | number | Array<string | number>) {
    return request({ url: `/system/post/${postIds}`, method: 'delete' })
}
