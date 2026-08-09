import request from '@/utils/request'

export function getList(params?: any) {
    return request({
        url: '/biz/projectGrant/list',
        method: 'get',
        params,
    })
}

export function doEdit(data: any) {
    return request({
        url: '/biz/projectGrant',
        method: 'put',
        data,
    })
}

export function doSave(data: any) {
    return request({
        url: '/biz/projectGrant',
        method: 'post',
        data,
    })
}

export function searchById(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/projectGrant/${id}`,
        method: 'get',
    })
}

export function doDelete(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/projectGrant/${id}`,
        method: 'delete',
    })
}
