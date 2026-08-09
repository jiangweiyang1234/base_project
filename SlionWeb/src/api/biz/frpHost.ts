import request from '@/utils/request'

export function getList(params?: any) {
    return request({
        url: '/biz/frpHosts/list',
        method: 'get',
        params,
    })
}

export function doEdit(data: any) {
    return request({
        url: '/biz/frpHosts',
        method: 'put',
        data,
    })
}

export function doSave(data: any) {
    return request({
        url: '/biz/frpHosts',
        method: 'post',
        data,
    })
}

export function searchById(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/frpHosts/${id}`,
        method: 'get',
    })
}

export function doDelete(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/frpHosts/${id}`,
        method: 'delete',
    })
}

export function doDisabled(data: any) {
    return request({
        url: '/biz/frpHosts/disabled',
        method: 'put',
        data,
    })
}

export function syncHosts(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/frpHosts/syncHosts/${id}`,
        method: 'get',
    })
}
