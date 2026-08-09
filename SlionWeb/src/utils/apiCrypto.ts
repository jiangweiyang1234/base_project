import CryptoJS from 'crypto-js'
import JSEncrypt from 'jsencrypt'

const ENCRYPT_HEADER = 'encrypt-key'

/** RSA 公钥（Base64，无 PEM 头尾），与后端 api-decrypt.publicKey 一致 */
const RSA_PUBLIC_KEY =
    process.env.VUE_APP_RSA_PUBLIC_KEY ||
    process.env.VUE_APP_API_PUBLIC_KEY ||
    ''

/**
 * 随机生成 32 位 AES 口令（与后端 EncryptUtils / Hutool 约定一致）
 */
export function generateAesPassword(): string {
    const array = new Uint8Array(32)
    crypto.getRandomValues(array)
    return Array.from(array, (b) => b.toString(16).padStart(2, '0'))
        .join('')
        .slice(0, 32)
}

export function encryptBase64(utf8Text: string): string {
    return CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(utf8Text))
}

export function decryptBase64ToUtf8(base64Text: string): string {
    return CryptoJS.enc.Base64.parse(base64Text).toString(CryptoJS.enc.Utf8)
}

export function encryptWithAes(message: string, aesPassword: string): string {
    const key = CryptoJS.enc.Utf8.parse(aesPassword)
    return CryptoJS.AES.encrypt(message, key, {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.Pkcs7,
    }).toString()
}

export function decryptWithAes(cipherText: string, aesPassword: string): string {
    const key = CryptoJS.enc.Utf8.parse(aesPassword)
    const decrypted = CryptoJS.AES.decrypt(cipherText, key, {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.Pkcs7,
    })
    return decrypted.toString(CryptoJS.enc.Utf8)
}

export function encryptWithRsa(plainText: string, publicKey = RSA_PUBLIC_KEY): string {
    if (!publicKey) {
        throw new Error('未配置 VUE_APP_RSA_PUBLIC_KEY，无法加密请求')
    }
    const encryptor = new JSEncrypt()
    encryptor.setPublicKey(
        `-----BEGIN PUBLIC KEY-----\n${publicKey}\n-----END PUBLIC KEY-----`
    )
    const result = encryptor.encrypt(plainText)
    if (!result) {
        throw new Error('RSA 加密失败，请检查公钥配置')
    }
    return result
}

export function decryptWithRsaPrivate(
    cipherText: string,
    privateKey: string
): string {
    const decryptor = new JSEncrypt()
    decryptor.setPrivateKey(
        `-----BEGIN PRIVATE KEY-----\n${privateKey}\n-----END PRIVATE KEY-----`
    )
    const result = decryptor.decrypt(cipherText)
    if (!result) {
        throw new Error('RSA 解密失败')
    }
    return result
}

/**
 * 按后端 DecryptRequestBodyWrapper 协议加密请求：
 * 1) 随机 AES 口令
 * 2) AES 加密 body
 * 3) RSA 公钥加密 Base64(AES口令)，放入 encrypt-key 头
 */
export function encryptRequestPayload(data: unknown): {
    body: string
    encryptKeyHeader: string
    headerName: string
} {
    const aesPassword = generateAesPassword()
    const plain =
        typeof data === 'string' ? data : JSON.stringify(data ?? {})
    const body = encryptWithAes(plain, aesPassword)
    const encryptKeyHeader = encryptWithRsa(encryptBase64(aesPassword))
    return { body, encryptKeyHeader, headerName: ENCRYPT_HEADER }
}

export function tryDecryptResponsePayload(
    data: unknown,
    encryptKeyHeader?: string | null
): unknown {
    if (!encryptKeyHeader || data == null || data === '') {
        return data
    }
    // 响应解密需要私钥，浏览器端一般不持有；仅当后端开启 response 加密且前端另有私钥时使用
    return data
}

export { ENCRYPT_HEADER, RSA_PUBLIC_KEY }
