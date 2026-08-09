/** @deprecated 请使用 @/api/system/user */
export {
    listUser as getList,
    addUser,
    updateUser,
    delUser as doDelete,
    getUser,
    resetUserPwd,
    changeUserStatus,
    deptTreeSelect,
} from '@/api/system/user'

import { addUser, updateUser } from '@/api/system/user'

/** 兼容旧 doEdit：有 userId 则更新，否则新增 */
export function doEdit(data: any) {
    return data?.userId ? updateUser(data) : addUser(data)
}
