/** @deprecated 请使用 @/api/system/dept */
export {
    listDept as getList,
    addDept,
    updateDept,
    delDept as doDelete,
    getDept,
    treeselect,
    handleTree,
} from '@/api/system/dept'

import { addDept, updateDept } from '@/api/system/dept'

export function doEdit(data: any) {
    return data?.deptId ? updateDept(data) : addDept(data)
}
