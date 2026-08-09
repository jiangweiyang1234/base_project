import request from '@/utils/request'

interface NoticeListResult {
    code: number
    msg: string
    rows: any[]
    total: number
}

export function getList() {
    return request<NoticeListResult>({
        url: '/system/notice/list',
        method: 'get',
    })
}
