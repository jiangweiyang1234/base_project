import { baseURL, clientId } from '@/config'
import { getToken } from '@/utils/token'

/** 与登录、HTTP 请求保持一致的 clientid */
export const WS_CLIENT_ID =
    clientId || process.env.VUE_APP_CLIENT_ID || 'e5cd7e4891bf95d1d19206ce24a7b32e'

export type WebSocketStatus =
    | 'connecting'
    | 'open'
    | 'closing'
    | 'closed'
    | 'reconnecting'

export type WebSocketEventType =
    | 'open'
    | 'message'
    | 'error'
    | 'close'
    | 'reconnect'
    | 'reconnectFailed'

export interface WebSocketMessageEvent<T = unknown> {
    raw: MessageEvent
    data: T
}

export interface WebSocketOptions {
    /** WebSocket 完整地址，或由 resolveWsUrl 生成的地址 */
    url: string
    protocols?: string | string[]
    /** 是否自动重连，默认 true */
    reconnect?: boolean
    /** 最大重连次数，0 表示无限重连，默认 0 */
    maxReconnectAttempts?: number
    /** 初始重连间隔（毫秒），默认 3000 */
    reconnectInterval?: number
    /** 重连间隔上限（毫秒），默认 30000 */
    maxReconnectInterval?: number
    /** 心跳间隔（毫秒），0 表示关闭，默认 30000 */
    heartbeatInterval?: number
    /** 心跳报文，默认 { type: 'ping' } */
    heartbeatMessage?: string | Record<string, unknown> | (() => string | Record<string, unknown>)
    /** 重连成功后是否发送断线期间缓存的消息，默认 true */
    flushQueueOnReconnect?: boolean
    /** 是否在连接 URL 上附加鉴权参数，默认 true */
    withAuth?: boolean
    /** clientid，须与登录时一致，默认 WS_CLIENT_ID */
    clientId?: string
    /** 收到消息后是否自动 JSON.parse，默认 true */
    parseMessage?: boolean
}

type EventHandler = (payload?: any) => void

const DEFAULT_OPTIONS = {
    reconnect: true,
    maxReconnectAttempts: 0,
    reconnectInterval: 3000,
    maxReconnectInterval: 30000,
    heartbeatInterval: 30000,
    heartbeatMessage: { type: 'ping' },
    flushQueueOnReconnect: true,
    withAuth: true,
    clientId: WS_CLIENT_ID,
    parseMessage: true,
}

/**
 * @description 将 HTTP baseURL 转为 WebSocket 地址
 * @param path 接口路径，如 /ws/device
 * @param httpBase 可选，默认读取项目 baseURL
 */
export function resolveWsUrl(path: string, httpBase: string = baseURL): string {
    if (/^wss?:\/\//i.test(path)) return path

    const normalizedPath = path.startsWith('/') ? path : `/${path}`

    if (/^https?:\/\//i.test(httpBase)) {
        const wsBase = httpBase.replace(/^http/i, 'ws')
        return `${wsBase.replace(/\/$/, '')}${normalizedPath}`
    }

    const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:'
    const basePath = httpBase.startsWith('/') ? httpBase : `/${httpBase}`
    return `${protocol}//${window.location.host}${basePath.replace(/\/$/, '')}${normalizedPath}`
}

/**
 * @description 设备控制 WebSocket 客户端
 */
export class WebSocketClient {
    private readonly options: Required<
        Omit<WebSocketOptions, 'url' | 'protocols'>
    > & {
        url: string
        protocols?: string | string[]
    }

    private socket: WebSocket | null = null
    private status: WebSocketStatus = 'closed'
    private reconnectAttempts = 0
    private reconnectTimer: ReturnType<typeof setTimeout> | null = null
    private heartbeatTimer: ReturnType<typeof setInterval> | null = null
    private manualClose = false
    private suppressReconnect = false
    private connectPromise: Promise<void> | null = null
    private messageQueue: Array<string | Record<string, unknown>> = []
    private listeners = new Map<WebSocketEventType, Set<EventHandler>>()

    constructor(options: WebSocketOptions) {
        this.options = {
            ...DEFAULT_OPTIONS,
            ...options,
        }
        this.bindNetworkEvents()
    }

    /**
     * @description 建立 WebSocket 连接
     */
    connect(): Promise<void> {
        if (this.socket?.readyState === WebSocket.OPEN) {
            return Promise.resolve()
        }

        if (
            this.socket?.readyState === WebSocket.CONNECTING &&
            this.connectPromise
        ) {
            return this.connectPromise
        }

        if (this.connectPromise) return this.connectPromise

        this.manualClose = false
        this.clearReconnectTimer()
        this.cleanupSocket()
        this.setStatus('connecting')

        this.connectPromise = new Promise<void>((resolve, reject) => {
            try {
                const url = this.buildConnectUrl()
                this.socket = this.options.protocols
                    ? new WebSocket(url, this.options.protocols)
                    : new WebSocket(url)

                this.socket.onopen = () => {
                    this.reconnectAttempts = 0
                    this.clearReconnectTimer()
                    this.setStatus('open')
                    this.startHeartbeat()
                    this.emit('open')
                    this.flushQueue()
                    resolve()
                }

                this.socket.onmessage = (event) => {
                    const data = this.parseIncomingData(event.data)
                    this.emit('message', { raw: event, data })
                }

                this.socket.onerror = (event) => {
                    this.emit('error', event)
                    if (this.status === 'connecting') {
                        reject(event)
                    }
                }

                this.socket.onclose = (event) => {
                    this.stopHeartbeat()
                    this.setStatus('closed')
                    this.emit('close', event)
                    this.connectPromise = null

                    if (
                        !this.manualClose &&
                        !this.suppressReconnect &&
                        this.options.reconnect
                    ) {
                        this.scheduleReconnect()
                    }
                }
            } catch (error) {
                this.connectPromise = null
                this.setStatus('closed')
                reject(error)
            }
        })

        return this.connectPromise
    }

    /**
     * @description 发送消息，连接未就绪时会进入发送队列
     */
    send(data: string | Record<string, unknown>): boolean {
        const payload =
            typeof data === 'string' ? data : JSON.stringify(data)

        if (this.socket?.readyState === WebSocket.OPEN) {
            this.socket.send(payload)
            return true
        }

        this.messageQueue.push(data)
        return false
    }

    /**
     * @description 注册事件监听，返回取消订阅函数
     */
    on(type: WebSocketEventType, handler: EventHandler): () => void {
        if (!this.listeners.has(type)) {
            this.listeners.set(type, new Set())
        }
        this.listeners.get(type)!.add(handler)
        return () => this.off(type, handler)
    }

    /**
     * @description 取消事件监听
     */
    off(type: WebSocketEventType, handler: EventHandler): void {
        this.listeners.get(type)?.delete(handler)
    }

    /**
     * @description 主动关闭连接，关闭后不会自动重连
     */
    close(code = 1000, reason = 'client closed'): void {
        this.manualClose = true
        this.clearReconnectTimer()
        this.stopHeartbeat()
        this.setStatus('closing')

        if (this.socket) {
            this.socket.close(code, reason)
            this.socket = null
        }

        this.connectPromise = null
        this.setStatus('closed')
    }

    /**
     * @description 销毁实例，释放所有资源
     */
    destroy(): void {
        this.close()
        this.messageQueue = []
        this.listeners.clear()
        window.removeEventListener('online', this.handleOnline)
    }

    getStatus(): WebSocketStatus {
        return this.status
    }

    getReadyState(): number {
        return this.socket?.readyState ?? WebSocket.CLOSED
    }

    isConnected(): boolean {
        return this.socket?.readyState === WebSocket.OPEN
    }

    private cleanupSocket(): void {
        if (!this.socket) return

        const socket = this.socket
        this.socket = null
        this.suppressReconnect = true
        socket.onopen = null
        socket.onmessage = null
        socket.onerror = null
        socket.onclose = null

        if (
            socket.readyState === WebSocket.OPEN ||
            socket.readyState === WebSocket.CONNECTING
        ) {
            socket.close(1000, 'reconnecting')
        }

        this.suppressReconnect = false
    }

    private buildConnectUrl(): string {
        if (!this.options.withAuth) return this.options.url

        const token = getToken()
        if (!token) return this.options.url

        const url = new URL(this.options.url, window.location.origin)
        url.searchParams.set('Authorization', `Bearer ${token}`)
        url.searchParams.set('clientid', this.options.clientId)
        return url.toString()
    }

    private parseIncomingData(raw: unknown): unknown {
        if (!this.options.parseMessage || typeof raw !== 'string') return raw

        try {
            return JSON.parse(raw)
        } catch {
            return raw
        }
    }

    private flushQueue(): void {
        if (!this.options.flushQueueOnReconnect || !this.isConnected()) return

        const queue = [...this.messageQueue]
        this.messageQueue = []
        queue.forEach((item) => this.send(item))
    }

    private scheduleReconnect(): void {
        if (
            this.options.maxReconnectAttempts > 0 &&
            this.reconnectAttempts >= this.options.maxReconnectAttempts
        ) {
            this.emit('reconnectFailed')
            return
        }

        this.clearReconnectTimer()
        this.setStatus('reconnecting')
        this.reconnectAttempts += 1

        const delay = Math.min(
            this.options.reconnectInterval *
                Math.pow(2, this.reconnectAttempts - 1),
            this.options.maxReconnectInterval
        )

        this.reconnectTimer = setTimeout(() => {
            this.emit('reconnect', this.reconnectAttempts)
            this.connect().catch(() => {})
        }, delay)
    }

    private startHeartbeat(): void {
        this.stopHeartbeat()
        if (!this.options.heartbeatInterval) return

        this.heartbeatTimer = setInterval(() => {
            if (!this.isConnected()) return

            const heartbeat =
                typeof this.options.heartbeatMessage === 'function'
                    ? this.options.heartbeatMessage()
                    : this.options.heartbeatMessage

            this.send(heartbeat)
        }, this.options.heartbeatInterval)
    }

    private stopHeartbeat(): void {
        if (this.heartbeatTimer) {
            clearInterval(this.heartbeatTimer)
            this.heartbeatTimer = null
        }
    }

    private clearReconnectTimer(): void {
        if (this.reconnectTimer) {
            clearTimeout(this.reconnectTimer)
            this.reconnectTimer = null
        }
    }

    private setStatus(status: WebSocketStatus): void {
        this.status = status
    }

    private emit(type: WebSocketEventType, payload?: unknown): void {
        this.listeners.get(type)?.forEach((handler) => handler(payload))
    }

    private handleOnline = (): void => {
        if (
            !this.manualClose &&
            this.options.reconnect &&
            !this.isConnected()
        ) {
            this.reconnectAttempts = 0
            this.connect().catch(() => {})
        }
    }

    private bindNetworkEvents(): void {
        window.addEventListener('online', this.handleOnline)
    }
}

interface SharedWebSocketEntry {
    client: WebSocketClient
    refCount: number
}

const sharedClients = new Map<string, SharedWebSocketEntry>()

/**
 * @description 获取共享 WebSocket 连接（同一路径全局单例，避免重复连接被后端踢下线）
 */
export function useSharedDeviceWebSocket(
    path = '/websocket',
    options: Omit<WebSocketOptions, 'url'> = {}
): { client: WebSocketClient; release: () => void } {
    const url = resolveWsUrl(path)
    let entry = sharedClients.get(url)

    if (!entry) {
        entry = {
            client: new WebSocketClient({ url, ...options }),
            refCount: 0,
        }
        sharedClients.set(url, entry)
    }

    entry.refCount += 1

    const release = () => {
        const current = sharedClients.get(url)
        if (!current) return

        current.refCount -= 1
        if (current.refCount <= 0) {
            current.client.destroy()
            sharedClients.delete(url)
        }
    }

    return { client: entry.client, release }
}

/**
 * @description 创建设备 WebSocket 客户端（共享单例）
 */
export function createDeviceWebSocket(
    path = '/websocket',
    options: Omit<WebSocketOptions, 'url'> = {}
): WebSocketClient {
    return useSharedDeviceWebSocket(path, options).client
}
