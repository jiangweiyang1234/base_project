import request from '@/utils/request'

export function getList(params?: any) {
    return request({
        url: '/biz/deviceMacImport/list',
        method: 'get',
        params,
    })
}

export function doEdit(data: any) {
    return request({
        url: '/biz/deviceMacImport',
        method: 'put',
        data,
    })
}

export function doSave(data: any) {
    return request({
        url: '/biz/deviceMacImport',
        method: 'post',
        data,
    })
}

export function searchById(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/deviceMacImport/${id}`,
        method: 'get',
    })
}

export function doDelete(id: string | number | Array<string | number>) {
    return request({
        url: `/biz/deviceMacImport/${id}`,
        method: 'delete',
    })
}

export function importExcel(data: FormData) {
    return request({
        url: '/biz/deviceMacImport/import',
        method: 'post',
        data,
        headers: {
            'Content-Type': 'multipart/form-data',
        },
    })
}

export function getImportTemplate() {
    return request({
        url: '/biz/deviceMacImport/importTemplate',
        method: 'get',
        responseType: 'blob',
    })
}
