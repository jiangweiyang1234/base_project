import request from '@/utils/request'
import { loginRSA } from '@/config'

export async function login(data: any) {
    return request({
        url: '/auth/login',
        method: 'post',
        data,
        headers: loginRSA ? { isEncrypt: 'true' } : undefined,
    })
}

export async function socialLogin(data: any) {
    return request({
        url: '/socialLogin',
        method: 'post',
        data,
        headers: loginRSA ? { isEncrypt: 'true' } : undefined,
    })
}

export function getUserInfo() {
    return request({
        url: '/system/user/getInfo',
        method: 'get',
    })
}

export function logout() {
    return request({
        url: '/auth/logout',
        method: 'post',
    })
}

export function getCapture() {
    return request({
        url: '/auth/code',
        method: 'get',
    })
}

export function register(data: any) {
    return request({
        url: '/auth/register',
        method: 'post',
        data,
        headers: loginRSA ? { isEncrypt: 'true' } : undefined,
    })
}
