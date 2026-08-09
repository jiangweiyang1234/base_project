/**
 * @description router全局配置。authentication=all 时由后端 getRouters 驱动菜单；
 * asyncRoutes 仅在 intelligence 模式使用。已精简 demo 路由（vab/other/mall/tools/github）。
 */
import type { VabRouteRecord } from '/#/router'
import {
    createRouter,
    createWebHashHistory,
    createWebHistory,
} from 'vue-router'
import Layout from '@vab/layouts/index.vue'
import { setupPermissions } from './permissions'

import type { RouteRecordName, RouteRecordRaw } from 'vue-router'

import { authentication, isHashRouterMode, publicPath } from '@/config'

export const constantRoutes: VabRouteRecord[] = [
    {
        path: '/login',
        name: 'Login',
        component: () => import('@/views/login/index.vue'),
        meta: {
            hidden: true,
        },
    },
    {
        path: '/register',
        name: 'Register',
        component: () => import('@/views/register/index.vue'),
        meta: {
            hidden: true,
        },
    },
    {
        path: '/callback',
        name: 'Callback',
        component: () => import('@/views/callback/index.vue'),
        meta: {
            hidden: true,
        },
    },
    {
        path: '/direct',
        name: 'Direct',
        component: () => import('@/views/direct/index.vue'),
        meta: {
            hidden: true,
        },
    },
    {
        path: '/404',
        name: '404',
        component: () => import('@/views/404.vue'),
        meta: {
            hidden: true,
        },
    },
]

export const asyncRoutes: VabRouteRecord[] = [
    {
        path: '/',
        name: 'Root',
        component: Layout,
        meta: {
            title: '首页',
            icon: 'home-2-line',
            breadcrumbHidden: true,
        },
        children: [
            {
                path: 'index',
                name: 'Index',
                component: () => import('@/views/index/index.vue'),
                meta: {
                    title: '首页',
                    icon: 'home-2-line',
                    noClosable: true,
                },
            },
            {
                path: 'dashboard',
                name: 'Dashboard',
                component: () => import('@/views/index/dashboard.vue'),
                meta: {
                    title: '看板',
                    icon: 'dashboard-line',
                },
            },
            {
                path: 'workbench',
                name: 'Workbench',
                component: () => import('@/views/index/workbench.vue'),
                meta: {
                    title: '工作台',
                    icon: 'settings-6-line',
                },
            },
        ],
    },
    {
        path: '/setting',
        name: 'PersonnelManagement',
        component: Layout,
        meta: {
            title: '配置',
            icon: 'user-settings-line',
            guard: ['Admin'],
        },
        children: [
            {
                path: 'personalCenter',
                name: 'PersonalCenter',
                component: () =>
                    import('@/views/setting/personalCenter/index.vue'),
                meta: {
                    title: '个人中心',
                    icon: 'map-pin-user-line',
                },
            },
            {
                path: 'userManagement',
                name: 'UserManagement',
                component: () =>
                    import('@/views/setting/userManagement/index.vue'),
                meta: {
                    title: '用户管理',
                    icon: 'user-3-line',
                },
            },
            {
                path: 'roleManagement',
                name: 'RoleManagement',
                component: () =>
                    import('@/views/setting/roleManagement/index.vue'),
                meta: {
                    title: '角色管理',
                    icon: 'admin-line',
                },
            },
            {
                path: 'departmentManagement',
                name: 'DepartmentManagement',
                component: () =>
                    import('@/views/setting/departmentManagement/index.vue'),
                meta: {
                    title: '部门管理',
                    icon: 'group-line',
                },
            },
            {
                path: 'menuManagement',
                name: 'MenuManagement',
                component: () =>
                    import('@/views/setting/menuManagement/index.vue'),
                meta: {
                    title: '菜单管理',
                    icon: 'menu-2-fill',
                },
            },
            {
                path: 'tenantManagement',
                name: 'TenantManagement',
                component: () =>
                    import('@/views/setting/tenantManagement/index.vue'),
                meta: {
                    title: '租户管理',
                    icon: 'building-line',
                },
            },
            {
                path: 'dictionaryManagement',
                name: 'DictionaryManagement',
                component: () =>
                    import('@/views/setting/dictionaryManagement/index.vue'),
                meta: {
                    title: '字典管理',
                    icon: 'book-2-line',
                },
            },
            {
                path: 'systemLog',
                name: 'SystemLog',
                component: () => import('@/views/setting/systemLog/index.vue'),
                meta: {
                    title: '系统日志',
                    icon: 'file-shield-2-line',
                },
            },
        ],
    },
    {
        path: '/workflow',
        name: 'Workflow',
        component: Layout,
        meta: {
            title: '工作流',
            icon: 'flow-chart',
            guard: ['Admin'],
        },
        children: [
            {
                path: 'category',
                name: 'WorkflowCategory',
                component: () => import('@/views/workflow/category/index.vue'),
                meta: {
                    title: '流程分类',
                    icon: 'node-tree',
                },
            },
            {
                path: 'definition',
                name: 'WorkflowDefinition',
                component: () =>
                    import('@/views/workflow/definition/index.vue'),
                meta: {
                    title: '流程定义',
                    icon: 'file-list-3-line',
                },
            },
            {
                path: 'task/todo',
                name: 'WorkflowTaskTodo',
                component: () => import('@/views/workflow/task/todo.vue'),
                meta: {
                    title: '待办任务',
                    icon: 'todo-line',
                },
            },
            {
                path: 'task/finished',
                name: 'WorkflowTaskFinished',
                component: () => import('@/views/workflow/task/finished.vue'),
                meta: {
                    title: '已办任务',
                    icon: 'check-double-line',
                },
            },
            {
                path: 'instance',
                name: 'WorkflowInstance',
                component: () => import('@/views/workflow/instance/index.vue'),
                meta: {
                    title: '流程实例',
                    icon: 'stack-line',
                },
            },
        ],
    },
    // --- 以下 demo 路由已移除（vab / other / mall / tools / github）---
    // 如需本地预览组件示例，可从 git 历史恢复对应路由块
    {
        path: '/error',
        name: 'Error',
        component: Layout,
        meta: {
            title: '错误页',
            icon: 'error-warning-line',
            levelHidden: true,
        },
        children: [
            {
                path: '403',
                name: 'Error403',
                component: () => import('@/views/403.vue'),
                meta: {
                    title: '403',
                    icon: 'error-warning-line',
                },
            },
            {
                path: '404',
                name: 'Error404',
                component: () => import('@/views/404.vue'),
                meta: {
                    title: '404',
                    icon: 'error-warning-line',
                },
            },
        ],
    },
    {
        path: '/:pathMatch(.*)*',
        redirect: '/404',
        name: 'NotFound',
        meta: {
            hidden: true,
        },
    },
]

const router = createRouter({
    history: isHashRouterMode
        ? createWebHashHistory(publicPath)
        : createWebHistory(publicPath),
    routes: constantRoutes as RouteRecordRaw[],
})

function fatteningRoutes(routes: VabRouteRecord[]): VabRouteRecord[] {
    return routes.flatMap((route: VabRouteRecord) => {
        return route.children ? fatteningRoutes(route.children) : route
    })
}

function addRouter(routes: VabRouteRecord[]) {
    routes.forEach((route: VabRouteRecord) => {
        if (!router.hasRoute(route.name))
            router.addRoute(route as RouteRecordRaw)
        if (route.children) addRouter(route.children)
    })
}

export function resetRouter(routes: VabRouteRecord[] = constantRoutes) {
    routes.map((route: VabRouteRecord) => {
        if (route.children) route.children = fatteningRoutes(route.children)
    })
    router.getRoutes().forEach(({ name }) => {
        router.hasRoute(<RouteRecordName>name) &&
            router.removeRoute(<RouteRecordName>name)
    })
    addRouter(routes)
}

export function setupRouter(app: any) {
    if (authentication === 'intelligence') addRouter(asyncRoutes)
    setupPermissions(router)
    app.use(router)
    return router
}

export default router
