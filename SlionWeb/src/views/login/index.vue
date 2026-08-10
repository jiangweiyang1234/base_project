<template>
    <div class="login-page">
        <div class="login-page__bg" aria-hidden="true">
            <div class="login-page__grid" />
            <div class="login-page__glow login-page__glow--a" />
            <div class="login-page__glow login-page__glow--b" />
            <div class="login-page__orb" />
        </div>

        <div class="login-page__shell">
            <section class="login-brand">
                <p class="login-brand__eyebrow">Enterprise Platform</p>
                <h1 class="login-brand__name">{{ title }}</h1>
                <p class="login-brand__desc">
                    统一业务中台 · 安全高效 · 智能协同
                </p>
            </section>

            <section class="login-panel">
                <el-form
                    ref="formRef"
                    class="login-form"
                    label-position="top"
                    :model="form"
                    :rules="rules"
                    @submit.prevent
                >
                    <header class="login-form__header">
                        <h2 class="login-form__title">
                            {{ translateTitle('欢迎登录') }}
                        </h2>
                        <p class="login-form__subtitle">
                            {{ translateTitle('请输入账号信息以继续') }}
                        </p>
                    </header>

                    <el-form-item prop="username">
                        <el-input
                            v-model.trim="form.username"
                            v-focus
                            :placeholder="translateTitle('请输入用户名')"
                            size="large"
                            tabindex="1"
                            type="text"
                        >
                            <template #prefix>
                                <vab-icon icon="user-line" />
                            </template>
                        </el-input>
                    </el-form-item>

                    <el-form-item prop="password">
                        <el-input
                            :key="passwordType"
                            ref="passwordRef"
                            v-model.trim="form.password"
                            :placeholder="translateTitle('请输入密码')"
                            size="large"
                            tabindex="2"
                            :type="passwordType"
                            @keyup.enter="handleLogin"
                        >
                            <template #prefix>
                                <vab-icon icon="lock-line" />
                            </template>
                            <template
                                v-if="passwordType === 'password'"
                                #suffix
                            >
                                <vab-icon
                                    class="show-password"
                                    icon="eye-off-line"
                                    @click="handlePassword"
                                />
                            </template>
                            <template v-else #suffix>
                                <vab-icon
                                    class="show-password"
                                    icon="eye-line"
                                    @click="handlePassword"
                                />
                            </template>
                        </el-input>
                    </el-form-item>

                    <el-form-item
                        v-if="codeUrl"
                        class="login-form__code-item"
                        prop="verificationCode"
                    >
                        <el-input
                            v-model.trim="form.code"
                            :placeholder="
                                translateTitle('验证码') + previewText
                            "
                            size="large"
                            tabindex="3"
                            type="text"
                            @keyup.enter="handleLogin"
                        >
                            <template #prefix>
                                <vab-icon icon="barcode-box-line" />
                            </template>
                        </el-input>
                        <el-image
                            class="login-form__code"
                            :src="codeUrl"
                            @click="changeCode"
                        />
                    </el-form-item>

                    <el-form-item class="login-form__actions">
                        <el-button
                            class="login-form__submit"
                            :loading="loading"
                            native-type="button"
                            size="large"
                            type="primary"
                            @click="handleLogin"
                        >
                            {{ translateTitle('登录') }}
                        </el-button>
                    </el-form-item>
                </el-form>
            </section>
        </div>

        <vab-footer />
    </div>
</template>

<script>
    import { useSettingsStore } from '@/store/modules/settings'
    import { useUserStore } from '@/store/modules/user'
    import { translate } from '@/i18n'
    import { isPassword } from '@/utils/validate'
    import { getCapture } from '@/api/user'
    import { clientId as appClientId } from '@/config'

    export default defineComponent({
        name: 'Login',
        directives: {
            focus: {
                mounted(el) {
                    el.querySelector('input').focus()
                },
            },
        },
        setup() {
            const route = useRoute()
            const router = useRouter()

            const userStore = useUserStore()
            const settingsStore = useSettingsStore()

            const login = (form) => userStore.login(form)

            const validateUsername = (rule, value, callback) => {
                if ('' === value)
                    callback(new Error(translate('用户名不能为空')))
                else callback()
            }
            const validatePassword = (rule, value, callback) => {
                if (!isPassword(value))
                    callback(new Error(translate('密码不能少于6位')))
                else callback()
            }

            const state = reactive({
                formRef: null,
                passwordRef: null,
                form: {
                    username: '',
                    password: '',
                    verificationCode: '',
                    uuid: '',
                    clientId: appClientId,
                    grantType: 'password',
                    tenantId: '000000',
                    code: '',
                },
                rules: {
                    username: [
                        {
                            required: true,
                            trigger: 'blur',
                            validator: validateUsername,
                        },
                    ],
                    password: [
                        {
                            required: true,
                            trigger: 'blur',
                            validator: validatePassword,
                        },
                    ],
                },
                loading: false,
                passwordType: 'password',
                redirect: undefined,
                timer: 0,
                codeUrl: '',
                previewText: '',
                uuid: '',
            })

            const handleRoute = () => {
                const redirect = state.redirect || '/'
                return redirect === '/404' || redirect === '/403'
                    ? '/'
                    : redirect
            }
            const handlePassword = () => {
                state.passwordType === 'password'
                    ? (state.passwordType = '')
                    : (state.passwordType = 'password')
                nextTick(() => {
                    state['passwordRef'].focus()
                })
            }
            const handleLogin = async () => {
                state['formRef'].validate(async (valid) => {
                    if (!valid) return
                    try {
                        state.loading = true
                        await login(state.form)
                        await router.replace(handleRoute())
                    } catch (e) {
                        console.error('登录失败:', e)
                    } finally {
                        state.loading = false
                    }
                })
            }
            const changeCode = () => {
                getCapture().then((res) => {
                    let captureRes = res.data
                    if (captureRes.captchaEnabled) {
                        state.uuid = captureRes.uuid
                        state.codeUrl = `data:image/gif;base64,${captureRes.img}`
                        state.form.uuid = captureRes.uuid
                    } else {
                        state.uuid = ''
                        state.codeUrl = ''
                        state.form.uuid = ''
                    }
                })
            }

            onBeforeMount(() => {
                state.form.username = 'admin'
                state.form.password = 'admin123'
                if (location.hostname === 'veujs-core.cn') {
                    state.previewText = '（演示地址验证码可不填）'
                    state.timer = setTimeout(() => {
                        handleLogin()
                    }, 5000)
                }
                changeCode()
            })

            watchEffect(() => {
                state.redirect = (route.query && route.query.redirect) || '/'
            })

            onBeforeRouteLeave((to, from, next) => {
                clearInterval(state.timer)
                next()
            })

            return {
                translateTitle: translate,
                ...toRefs(state),
                title: settingsStore.getTitle,
                handlePassword,
                handleLogin,
                changeCode,
            }
        },
    })
</script>

<style lang="scss" scoped>
    .login-page {
        --login-brand: #0052d9;
        --login-brand-deep: #0034a5;
        --login-ink: #e8f0ff;
        --login-muted: rgba(232, 240, 255, 0.72);

        position: relative;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        overflow: hidden;
        font-family: 'DIN Alternate', 'Avenir Next', 'Segoe UI', 'PingFang SC',
            'Microsoft YaHei', sans-serif;
        color: var(--login-ink);
        background: #04122e;
    }

    .login-page__bg {
        position: absolute;
        inset: 0;
        background:
            radial-gradient(
                1200px 600px at 12% 18%,
                rgba(0, 82, 217, 0.55),
                transparent 60%
            ),
            radial-gradient(
                900px 520px at 88% 12%,
                rgba(0, 168, 255, 0.28),
                transparent 55%
            ),
            linear-gradient(145deg, #020b1f 0%, #0a1f4d 48%, #04122e 100%);
    }

    .login-page__grid {
        position: absolute;
        inset: 0;
        background-image:
            linear-gradient(rgba(120, 170, 255, 0.08) 1px, transparent 1px),
            linear-gradient(90deg, rgba(120, 170, 255, 0.08) 1px, transparent 1px);
        background-size: 48px 48px;
        mask-image: radial-gradient(circle at 40% 40%, #000 20%, transparent 75%);
        opacity: 0.7;
        animation: login-grid-drift 28s linear infinite;
    }

    .login-page__glow {
        position: absolute;
        border-radius: 50%;
        filter: blur(40px);
        opacity: 0.55;
        pointer-events: none;
    }

    .login-page__glow--a {
        top: 18%;
        left: 8%;
        width: 280px;
        height: 280px;
        background: rgba(0, 132, 255, 0.45);
        animation: login-pulse 8s ease-in-out infinite;
    }

    .login-page__glow--b {
        right: 10%;
        bottom: 12%;
        width: 360px;
        height: 360px;
        background: rgba(0, 82, 217, 0.4);
        animation: login-pulse 10s ease-in-out infinite reverse;
    }

    .login-page__orb {
        position: absolute;
        top: 22%;
        left: 28%;
        width: 180px;
        height: 180px;
        border: 1px solid rgba(140, 190, 255, 0.28);
        border-radius: 50%;
        box-shadow:
            0 0 40px rgba(0, 132, 255, 0.2) inset,
            0 0 80px rgba(0, 82, 217, 0.15);
        animation: login-orbit 18s linear infinite;
    }

    .login-page__shell {
        position: relative;
        z-index: 1;
        display: grid;
        grid-template-columns: minmax(0, 1.15fr) minmax(320px, 420px);
        gap: clamp(32px, 6vw, 88px);
        align-items: center;
        width: min(1120px, calc(100% - 48px));
        margin: auto;
        padding: 48px 0 72px;
    }

    .login-brand__eyebrow {
        margin: 0 0 16px;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.22em;
        text-transform: uppercase;
        color: rgba(150, 200, 255, 0.85);
    }

    .login-brand__name {
        margin: 0;
        font-size: clamp(42px, 6vw, 72px);
        font-weight: 700;
        line-height: 1.05;
        letter-spacing: 0.02em;
        color: #fff;
        text-shadow: 0 12px 40px rgba(0, 40, 120, 0.35);
    }

    .login-brand__desc {
        max-width: 420px;
        margin: 20px 0 0;
        font-size: 16px;
        line-height: 1.7;
        color: var(--login-muted);
    }

    .login-panel {
        padding: 36px 32px 28px;
        background: rgba(8, 22, 56, 0.62);
        border: 1px solid rgba(140, 190, 255, 0.22);
        border-radius: 16px;
        box-shadow:
            0 24px 64px rgba(0, 16, 48, 0.45),
            inset 0 1px 0 rgba(255, 255, 255, 0.08);
        backdrop-filter: blur(18px);
    }

    .login-form__header {
        margin-bottom: 28px;
    }

    .login-form__title {
        margin: 0;
        font-size: 28px;
        font-weight: 650;
        color: #fff;
    }

    .login-form__subtitle {
        margin: 8px 0 0;
        font-size: 14px;
        color: var(--login-muted);
    }

    .login-form__code-item {
        :deep(.el-form-item__content) {
            display: flex;
            gap: 12px;
            align-items: stretch;
        }
    }

    .login-form__code {
        flex: 0 0 116px;
        height: 40px;
        overflow: hidden;
        cursor: pointer;
        border-radius: 8px;
        border: 1px solid rgba(140, 190, 255, 0.25);
    }

    .login-form__actions {
        margin-bottom: 0;
        margin-top: 8px;
    }

    .login-form__submit {
        width: 100%;
        height: 44px;
        font-size: 16px;
        font-weight: 600;
        letter-spacing: 0.08em;
        background: linear-gradient(135deg, #<PRIVATE_ADDRESS> 0%, var(--login-brand) 55%, #<PRIVATE_ADDRESS> 100%);
        border: 0;
        border-radius: 8px;
        box-shadow: 0 10px 28px rgba(0, 82, 217, 0.38);

        &:hover {
            filter: brightness(1.06);
        }
    }

    .show-password {
        cursor: pointer;
    }

    :deep(.el-form-item) {
        margin-bottom: 20px;
    }

    :deep(.el-input__wrapper) {
        min-height: 44px;
        padding: 0 14px;
        background: rgba(255, 255, 255, 0.92);
        border-radius: 8px;
        box-shadow: none;
    }

    :deep(.el-input__inner) {
        height: 44px;
        color: #1a2744;
    }

    :deep(.el-input__prefix),
    :deep(.el-input__suffix) {
        color: #5b6b8c;
    }

    :deep(.vab-footer) {
        position: absolute;
        bottom: 16px;
        left: 0;
        z-index: 1;
        width: 100%;
        color: rgba(220, 232, 255, 0.55) !important;
        text-align: center;
        background: transparent;
        border: 0;
    }

    @keyframes login-grid-drift {
        from {
            transform: translate3d(0, 0, 0);
        }

        to {
            transform: translate3d(48px, 48px, 0);
        }
    }

    @keyframes login-pulse {
        0%,
        100% {
            transform: scale(1);
            opacity: 0.45;
        }

        50% {
            transform: scale(1.12);
            opacity: 0.7;
        }
    }

    @keyframes login-orbit {
        from {
            transform: rotate(0deg) scale(1);
        }

        to {
            transform: rotate(360deg) scale(1.05);
        }
    }

    @media (max-width: 900px) {
        .login-page__shell {
            grid-template-columns: 1fr;
            width: min(440px, calc(100% - 32px));
            padding-top: 56px;
            gap: 28px;
        }

        .login-brand {
            text-align: center;
        }

        .login-brand__desc {
            max-width: none;
            margin-left: auto;
            margin-right: auto;
        }

        .login-brand__name {
            font-size: clamp(36px, 10vw, 48px);
        }

        .login-page__orb {
            display: none;
        }
    }
</style>
