import request from '@/utils/request'
import { encryptedData } from '@/utils/encrypt'
import { loginRSA } from '@/config'

export async function login(data: any) {
    if (loginRSA) {
        data = await encryptedData(data)
    }
    return request({
        url: '/auth/login',
        method: 'post',
        data: data,
    })
}

export async function socialLogin(data: any) {
    if (loginRSA) {
        data = await encryptedData(data)
    }
    return request({
        url: '/socialLogin',
        method: 'post',
        data,
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
        url: '/register',
        method: 'post',
        data,
    })
}
