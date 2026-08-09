import request from '@/utils/request'

export function listSpel(params?: any) {
    return request({
        url: '/workflow/spel/list',
        method: 'get',
        params,
    })
}

export function getSpel(id: string | number) {
    return request({
        url: `/workflow/spel/${id}`,
        method: 'get',
    })
}

export function addSpel(data: any) {
    return request({
        url: '/workflow/spel',
        method: 'post',
        data,
    })
}

export function updateSpel(data: any) {
    return request({
        url: '/workflow/spel',
        method: 'put',
        data,
    })
}

export function delSpel(ids: string | number | Array<string | number>) {
    return request({
        url: `/workflow/spel/${ids}`,
        method: 'delete',
    })
}
