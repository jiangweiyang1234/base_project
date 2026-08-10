import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn.mjs'
import 'element-plus/dist/index.css'
import FcDesigner from '@form-create/designer'
import HostApp from './HostApp.vue'

/**
 * 独立宿主页：只装 Element Plus + FcDesigner，不加载 VAB 全局样式，
 * 避免后台 Layout 把设计器三列挤成上下结构。
 */
const app = createApp(HostApp)
app.use(ElementPlus, { locale: zhCn })
app.use(FcDesigner as any)
app.use(FcDesigner.formCreate as any)
app.mount('#app')
