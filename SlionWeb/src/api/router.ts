import { getRouters } from '@/api/system/menu'

/** 获取动态路由（后端 getRouters） */
export function getList() {
    return getRouters()
}
