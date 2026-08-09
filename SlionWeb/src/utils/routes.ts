import { resolve } from 'path'
import qs from 'qs'
import type { VabRoute, VabRouteRecord } from '/#/router'
import { hasPermission } from '@/utils/permission'
import { isExternal } from '@/utils/validate'
import { recordRoute } from '@/config'

/**
 * @description all模式渲染后端返回路由,支持包含views路径的所有页面
 * @param asyncRoutes
 * @returns {*}
 */
export function convertRouter(asyncRoutes: VabRouteRecord[]) {
    return asyncRoutes
        .map((route: any) => {
            // 外链仅保留菜单数据，不参与 vue-router 注册
            if (isExternal(route.path)) {
                if (route.meta == null) route.meta = {}
                route.meta.target = '_blank'
                delete route.component
                delete route.children
                return route
            }

            if (route.component) {
                const rawComponent = String(route.component).trim()
                const special =
                    rawComponent.match(/^(Layout|ParentView|InnerLink)$/i) ||
                    rawComponent.match(
                        /^@\/?(Layout|ParentView|InnerLink)$/i
                    )
                if (special) {
                    const name = (special[1] || special[0]).toLowerCase()
                    if (name === 'layout') {
                        route.component = () =>
                            import('@vab/layouts/index.vue')
                    } else if (name === 'parentview') {
                        route.component = () =>
                            import('@/views/ParentView.vue')
                    } else {
                        route.component = () =>
                            import('@/views/InnerLink.vue')
                    }
                } else if (
                    /^@\//.test(rawComponent) ||
                    !rawComponent.includes('://')
                ) {
                    // 后端多为 @/system/user/index 或 system/user/index，统一映射到 @/views/**
                    const raw = rawComponent.replace(/^@\/*/, '')
                    const viewPath = raw.startsWith('views/')
                        ? raw
                        : `views/${raw}`
                    route.component = () => import(`@/${viewPath}.vue`)
                } else {
                    console.error(
                        `后端路由组件无法识别，已跳过: ${route.path} -> ${rawComponent}`
                    )
                    delete route.component
                }
            }

            // 菜单侧栏隐藏字段兼容：后端 hidden / meta.hidden
            if (route.meta == null) route.meta = {}
            if (route.hidden === true) route.meta.hidden = true

            if (route.children)
                route.children.length > 0
                    ? (route.children = convertRouter(route.children))
                    : delete route.children

            return route
        })
        .filter(Boolean)
}

/**
 * @description 根据roles数组拦截路由
 * @param routes 路由
 * @param rolesControl 是否进行权限控制
 * @param baseUrl 基础路由
 * @returns {[]}
 */
export function filterRoutes(
    routes: VabRouteRecord[],
    rolesControl: boolean,
    baseUrl = '/'
): VabRouteRecord[] {
    return routes
        .filter((route: VabRouteRecord) =>
            rolesControl && !route.hidden && route.meta?.guard
                ? hasPermission(route.meta.guard)
                : true
        )
        .flatMap((route: VabRouteRecord) =>
            baseUrl !== '/' && route.children && route.meta?.levelHidden
                ? [...route.children]
                : route
        )
        .map((route: VabRouteRecord) => {
            route = { ...route }
            route.path =
                route.path !== '*' && !isExternal(route.path)
                    ? resolve(baseUrl, route.path)
                    : route.path
            if (route.children && route.children.length > 0) {
                route.children = filterRoutes(
                    route.children,
                    rolesControl,
                    route.path
                )
                if (route.children.length > 0) {
                    route.childrenPathList = route.children.flatMap(
                        (_) => <string[]>_.childrenPathList
                    )
                    if (!route.redirect) {
                        const firstInternal = route.children.find(
                            (child) =>
                                !isExternal(child.redirect || child.path)
                        )
                        if (firstInternal) {
                            route.redirect =
                                firstInternal.redirect || firstInternal.path
                        }
                    }
                }
            } else route.childrenPathList = [route.path]
            return route
        })
}

/**
 * 根据path路径获取matched
 * @param routes 菜单routes
 * @param path 路径
 * @returns {*} matched
 */
export function handleMatched(
    routes: VabRouteRecord[],
    path: string
): VabRouteRecord[] {
    return routes
        .filter(
            (route: VabRouteRecord) =>
                (route?.childrenPathList || []).indexOf(path) + 1
        )
        .flatMap((route: VabRouteRecord) =>
            route.children
                ? [route, ...handleMatched(route.children, path)]
                : [route]
        )
}

/**
 * 生成单个多标签元素，可用于同步/异步添加多标签
 * @param tag route页信息
 */
export function handleTabs(tag: VabRoute | VabRouteRecord): any {
    let parentIcon = null
    if ('matched' in tag)
        for (let i = tag.matched.length - 2; i >= 0; i--)
            if (!parentIcon && tag.matched[i].meta.icon)
                parentIcon = tag.matched[i].meta.icon
    if (!parentIcon) parentIcon = 'menu-line'
    const path = handleActivePath(<VabRoute>tag, true)
    if (tag.name && tag.meta.tabHidden !== true)
        return {
            path,
            query: 'query' in tag ? tag.query : {},
            params: 'params' in tag ? tag.params : {},
            name: tag.name as string,
            parentIcon,
            meta: { ...tag.meta },
        }
}

/**
 * 根据当前route获取激活菜单
 * @param route 当前路由
 * @param isTab 是否是标签
 * @returns {string|*}
 */
export function handleActivePath(route: VabRoute, isTab = false) {
    const { meta, path } = route
    const rawPath = route.matched
        ? route.matched[route.matched.length - 1].path
        : path
    const fullPath =
        route.query && Object.keys(route.query).length > 0
            ? `${route.path}?${qs.stringify(route.query)}`
            : route.path
    if (isTab) return meta.dynamicNewTab ? fullPath : rawPath
    if (meta.activeMenu) return meta.activeMenu
    return fullPath
}

/**
 * 获取当前跳转登录页的Route
 * @param currentPath 当前页面地址
 */
export function toLoginRoute(currentPath: string) {
    if (recordRoute && currentPath !== '/')
        return {
            path: '/login',
            query: { redirect: currentPath },
            replace: true,
        }
    else return { path: '/login', replace: true }
}

/**
 * 获取路由中所有的Name
 * @param routes 路由数组
 * @returns {*} Name数组
 */
export function getNames(routes: VabRouteRecord[]): string[] {
    return routes.flatMap((route: VabRouteRecord) => {
        const names = []
        if (route.name) names.push(route.name)
        if (route.children) names.push(...getNames(route.children))
        return names
    })
}
