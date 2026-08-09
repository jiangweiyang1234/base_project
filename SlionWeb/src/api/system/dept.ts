import request from '@/utils/request'

/** 部门列表（后端返回平铺 List，前端可建树） */
export function listDept(params?: any) {
    return request({
        url: '/system/dept/list',
        method: 'get',
        params,
    })
}

/** 部门详情 */
export function getDept(deptId: string | number) {
    return request({
        url: `/system/dept/${deptId}`,
        method: 'get',
    })
}

/**
 * 部门树（兼容 RuoYi 命名）。
 * 当前后端无独立 treeselect，使用 list 接口；调用方可用 handleTree 建树。
 */
export function treeselect(params?: any) {
    return listDept(params)
}

/** 排除节点后的部门列表 */
export function listDeptExcludeChild(deptId: string | number) {
    return request({
        url: `/system/dept/list/exclude/${deptId}`,
        method: 'get',
    })
}

/** 新增部门 */
export function addDept(data: any) {
    return request({
        url: '/system/dept',
        method: 'post',
        data,
    })
}

/** 修改部门 */
export function updateDept(data: any) {
    return request({
        url: '/system/dept',
        method: 'put',
        data,
    })
}

/** 删除部门 */
export function delDept(deptId: string | number) {
    return request({
        url: `/system/dept/${deptId}`,
        method: 'delete',
    })
}

/** 将平铺部门列表转为树 */
export function handleTree(
    data: any[],
    id = 'deptId',
    parentId = 'parentId',
    children = 'children'
) {
    const config = { id, parentId, children }
    const childrenListMap: Record<string, any[]> = {}
    const nodeIds: Record<string, any> = {}
    const tree: any[] = []

    for (const d of data) {
        const pid = d[config.parentId]
        if (childrenListMap[pid] == null) childrenListMap[pid] = []
        nodeIds[d[config.id]] = d
        childrenListMap[pid].push(d)
    }

    for (const d of data) {
        const pid = d[config.parentId]
        if (nodeIds[pid] == null) tree.push(d)
    }

    const adaptToChildrenList = (o: any) => {
        if (childrenListMap[o[config.id]] != null) {
            o[config.children] = childrenListMap[o[config.id]]
        }
        if (o[config.children]) {
            for (const c of o[config.children]) adaptToChildrenList(c)
        }
    }
    for (const t of tree) adaptToChildrenList(t)
    return tree
}
