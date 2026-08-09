import request from '@/utils/request'

export function getList(params?: any) {
    return request({
        url: '/biz/deviceOrder/list',
        method: 'get',
        params,
    })
}

export function doEdit(data: any) {
    return request({
        url: '/biz/deviceOrder',
        method: 'put',
        data,
    })
}

export function doSave(data: any) {
    return request({
        url: '/biz/deviceOrder',
        method: 'post',
        data,
    })
}

export function searchById(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/deviceOrder/${id}`,
        method: 'get',
    })
}

export function doDelete(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/deviceOrder/${id}`,
        method: 'delete',
    })
}
