/** @deprecated 请使用 @/api/system/role */
export {
    listRole as getList,
    addRole,
    updateRole,
    delRole as doDelete,
    getRole,
    changeRoleStatus,
    dataScope,
    roleDeptTreeselect,
} from '@/api/system/role'

import { addRole, updateRole } from '@/api/system/role'

export function doEdit(data: any) {
    return data?.roleId ? updateRole(data) : addRole(data)
}
