import request from '@/utils/request'

/** 用户列表 */
export function listUser(params?: any) {
    return request({
        url: '/system/user/list',
        method: 'get',
        params,
    })
}

/** 用户详情（含角色/岗位选项） */
export function getUser(userId?: string | number) {
    return request({
        url: userId ? `/system/user/${userId}` : '/system/user/',
        method: 'get',
    })
}

/** 新增用户 */
export function addUser(data: any) {
    return request({
        url: '/system/user',
        method: 'post',
        data,
    })
}

/** 修改用户 */
export function updateUser(data: any) {
    return request({
        url: '/system/user',
        method: 'put',
        data,
    })
}

/** 删除用户 */
export function delUser(userIds: string | number | Array<string | number>) {
    return request({
        url: `/system/user/${userIds}`,
        method: 'delete',
    })
}

/** 重置密码 */
export function resetUserPwd(data: { userId: string | number; password: string }) {
    return request({
        url: '/system/user/resetPwd',
        method: 'put',
        data,
    })
}

/** 修改状态 */
export function changeUserStatus(data: { userId: string | number; status: string }) {
    return request({
        url: '/system/user/changeStatus',
        method: 'put',
        data,
    })
}

/** 部门树（用户侧） */
export function deptTreeSelect(params?: any) {
    return request({
        url: '/system/user/deptTree',
        method: 'get',
        params,
    })
}

/** 查询用户授权角色 */
export function getAuthRole(userId: string | number) {
    return request({
        url: `/system/user/authRole/${userId}`,
        method: 'get',
    })
}

/** 保存用户授权角色 */
export function updateAuthRole(data: {
    userId: string | number
    roleIds: string | number | Array<string | number>
}) {
    return request({
        url: '/system/user/authRole',
        method: 'put',
        params: data,
    })
}
