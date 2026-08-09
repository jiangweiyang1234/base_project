import { clientId } from '@/config'
import { getToken } from '@/utils/token'

const WARM_PREFIX = 'Warm-'
const TOKEN_NAME_KEY = `${WARM_PREFIX}TokenName`
const TOKEN_NAMES = 'Authorization,clientid'

/**
 * Warm-Flow 设计器从 localStorage 的 Warm-* 键读取鉴权头。
 * 打开 iframe 前同步当前登录态，避免设计器接口 401。
 */
export function syncWarmFlowAuth() {
    const token = getToken()
    const auth = token
        ? token.startsWith('Bearer ')
            ? token
            : `Bearer ${token}`
        : ''
    const cid =
        clientId ||
        process.env.VUE_APP_CLIENT_ID ||
        'e5cd7e4891bf95d1d19206ce24a7b32e'

    localStorage.setItem(TOKEN_NAME_KEY, TOKEN_NAMES)
    if (auth) {
        localStorage.setItem(`${WARM_PREFIX}Authorization`, auth)
    }
    localStorage.setItem(`${WARM_PREFIX}clientid`, cid)

    return { auth, clientId: cid }
}

/** 生成带鉴权查询参数的设计器地址（query 供 warm-flow-ui 初始化写入） */
export function buildWarmFlowDesignerUrl(definitionId?: string | number) {
    const { auth, clientId: cid } = syncWarmFlowAuth()
    const query = new URLSearchParams()
    if (auth) query.set('Authorization', auth)
    if (cid) query.set('clientid', cid)
    const qs = query.toString()
    const hash = definitionId
        ? `#/design?id=${encodeURIComponent(String(definitionId))}`
        : '#/'
    return `/warm-flow-ui/${qs ? `?${qs}` : ''}${hash}`
}
