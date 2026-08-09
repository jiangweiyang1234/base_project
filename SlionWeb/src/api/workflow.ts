/** @deprecated 请使用 @/api/workflow/definition 等模块 */
export {
    listDefinition as getList,
    addDefinition,
    updateDefinition,
    delDefinition,
    publishDefinition,
    unPublishDefinition,
    activeDefinition,
} from '@/api/workflow/definition'

import { addDefinition, updateDefinition } from '@/api/workflow/definition'

export function doEdit(data: any) {
    return data?.id ? updateDefinition(data) : addDefinition(data)
}
