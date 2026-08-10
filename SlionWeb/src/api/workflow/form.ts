import request from '@/utils/request'

export function listForm(params?: any) {
    return request({
        url: '/workflow/form/list',
        method: 'get',
        params,
    })
}

export function publishedFormList(params?: any) {
    return request({
        url: '/workflow/form/publishedList',
        method: 'get',
        params,
    })
}

export function getForm(id: string | number) {
    return request({
        url: `/workflow/form/${id}`,
        method: 'get',
    })
}

export function addForm(data: any) {
    return request({
        url: '/workflow/form',
        method: 'post',
        data,
    })
}

export function updateForm(data: any) {
    return request({
        url: '/workflow/form',
        method: 'put',
        data,
    })
}

export function saveFormContent(data: { id: string | number; formContent?: string }) {
    return request({
        url: '/workflow/form/content',
        method: 'put',
        data,
    })
}

export function delForm(ids: string | number | Array<string | number>) {
    return request({
        url: `/workflow/form/${ids}`,
        method: 'delete',
    })
}

export function publishForm(id: string | number) {
    return request({
        url: `/workflow/form/publish/${id}`,
        method: 'put',
    })
}

export function unPublishForm(id: string | number) {
    return request({
        url: `/workflow/form/unPublish/${id}`,
        method: 'put',
    })
}

export function copyForm(id: string | number) {
    return request({
        url: `/workflow/form/copy/${id}`,
        method: 'post',
    })
}
