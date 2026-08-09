import request from '@/utils/request'

/** 流程分类列表 */
export function listCategory(params?: any) {
    return request({
        url: '/workflow/category/list',
        method: 'get',
        params,
    })
}

/** 流程分类树 */
export function categoryTree(params?: any) {
    return request({
        url: '/workflow/category/categoryTree',
        method: 'get',
        params,
    })
}

/** 分类详情 */
export function getCategory(categoryId: string | number) {
    return request({
        url: `/workflow/category/${categoryId}`,
        method: 'get',
    })
}

/** 新增分类 */
export function addCategory(data: any) {
    return request({
        url: '/workflow/category',
        method: 'post',
        data,
    })
}

/** 修改分类 */
export function updateCategory(data: any) {
    return request({
        url: '/workflow/category',
        method: 'put',
        data,
    })
}

/** 删除分类 */
export function delCategory(categoryId: string | number) {
    return request({
        url: `/workflow/category/${categoryId}`,
        method: 'delete',
    })
}
