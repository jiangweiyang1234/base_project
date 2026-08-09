import request from '@/utils/request'

export function getList(params?: any) {
    return request({
        url: '/biz/device/list',
        method: 'get',
        params,
    })
}

export function getDeviceList(params?: any) {
    return request({
        url: '/biz/device/getDeviceList',
        method: 'get',
        params,
    })
}

export function doEdit(data: any) {
    return request({
        url: '/biz/device',
        method: 'put',
        data,
    })
}

export function doSave(data: any) {
    return request({
        url: '/biz/device',
        method: 'post',
        data,
    })
}

export function searchById(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/device/${id}`,
        method: 'get',
    })
}

export function doDelete(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/device/${id}`,
        method: 'delete',
    })
}
