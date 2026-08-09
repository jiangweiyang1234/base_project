import { createApp } from 'vue'
import App from './App.vue'
import { pwa } from './config'
import { setupVab } from '~/library'
import { setupI18n } from '@/i18n'
import { setupStore } from '@/store'
import { setupRouter } from '@/router'
import { validateSecretKey } from '@/utils'

validateSecretKey()

const app = createApp(App)

/**
 * @description 已移除生产环境 mockXHR，统一走真实后端（/prod-api 或网关）。
 */
//if (process.env.NODE_ENV === 'development') app.config.performance = true

if (pwa) require('./registerServiceWorker')

setupVab(app)
setupI18n(app)
setupStore(app)
setupRouter(app)
    .isReady()
    .then(() => app.mount('#app'))
