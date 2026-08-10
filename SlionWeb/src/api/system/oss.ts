import request from '@/utils/request'
import type { AxiosRequestConfig } from 'axios'

export function listOss(params?: any) {
    return request({ url: '/resource/oss/list', method: 'get', params })
}
export function delOss(ossIds: string | number | Array<string | number>) {
    return request({ url: `/resource/oss/${ossIds}`, method: 'delete' })
}

export type UploadOssOptions = {
    /** 上传进度回调（已上传字节、总字节） */
    onUploadProgress?: AxiosRequestConfig['onUploadProgress']
    /** 取消信号 */
    signal?: AbortSignal
    /** 超时毫秒，默认 10 分钟 */
    timeout?: number
}

/**
 * 上传单个文件到 OSS
 * 支持进度、取消；上传超时单独加长，避免默认 10s 误报成功
 */
export function uploadOss(data: FormData, options: UploadOssOptions = {}) {
    const { onUploadProgress, signal, timeout = 10 * 60 * 1000 } = options
    return request({
        url: '/resource/oss/upload',
        method: 'post',
        data,
        timeout,
        signal,
        onUploadProgress,
        headers: { 'Content-Type': 'multipart/form-data' },
    })
}
