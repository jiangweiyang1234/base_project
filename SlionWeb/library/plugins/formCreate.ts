import type { App } from 'vue'
import FcDesigner from '@form-create/designer'
import request from '@/utils/request'
import { parseDictResponse } from '@/utils/formDesigner'

/**
 * 注册 FormCreate 可视化表单设计器（Element Plus）
 * 并为远程选项（含系统字典）配置统一请求器
 */
export default {
    install(app: App) {
        app.use(FcDesigner as any)
        app.use(FcDesigner.formCreate as any)

        const formCreate = FcDesigner.formCreate
        if (formCreate && typeof formCreate.fetch !== 'undefined') {
            formCreate.fetch = (opt: any) => {
                const action = opt?.action || opt?.url
                return request({
                    url: action,
                    method: (opt?.method || 'get').toLowerCase(),
                    params: opt?.data || opt?.params,
                    data: opt?.data,
                }).then((res: any) => {
                    if (typeof opt?.parse === 'function') {
                        return opt.parse(res)
                    }
                    if (
                        typeof action === 'string' &&
                        action.includes('/system/dict/data/type/')
                    ) {
                        return parseDictResponse(res)
                    }
                    return res?.data ?? res
                })
            }
        }
    },
}
