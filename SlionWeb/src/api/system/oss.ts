import request from '@/utils/request'

export function listOss(params?: any) {
    return request({ url: '/resource/oss/list', method: 'get', params })
}
export function delOss(ossIds: string | number | Array<string | number>) {
    return request({ url: `/resource/oss/${ossIds}`, method: 'delete' })
}
export function uploadOss(data: FormData) {
    return request({
        url: '/resource/oss/upload',
        method: 'post',
        data,
        headers: { 'Content-Type': 'multipart/form-data' },
    })
}
