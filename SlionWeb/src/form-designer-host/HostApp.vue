<template>
    <div class="fc-host">
        <fc-designer
            v-if="ready"
            ref="designerRef"
            :config="config"
            :height="height"
        />
    </div>
</template>

<script setup>
    import { nextTick, onBeforeUnmount, onMounted, reactive, ref } from 'vue'

    const designerRef = ref(null)
    const ready = ref(false)
    const height = ref(Math.max(window.innerHeight, 480))
    const config = reactive({
        showSaveBtn: false,
        showDevice: true,
        showFormConfig: true,
        showConfig: true,
        // 默认表单：标签与控件同一行；支持栅格列宽
        formOptions: {
            form: {
                labelPosition: 'right',
                labelWidth: '100px',
                size: 'default',
                hideRequiredAsterisk: false,
                // inline 为整表横排；多字段同行优先用「布局组件 → 栅格布局」
                inline: false,
            },
            row: {
                gutter: 16,
            },
            submitBtn: false,
            resetBtn: false,
        },
    })

    const syncHeight = () => {
        height.value = Math.max(window.innerHeight, 480)
    }

    const getApi = () => designerRef.value

    /** 始终经 getJson 再 parse，避免把设计器内部响应式对象传给父页导致卡死 */
    const readRules = () => {
        const api = getApi()
        if (!api) return []
        try {
            if (typeof api.getJson === 'function') {
                const json = api.getJson()
                const parsed = typeof json === 'string' ? JSON.parse(json || '[]') : json
                return Array.isArray(parsed) ? parsed : []
            }
            return api.getRule?.() || []
        } catch {
            return []
        }
    }

    const writeRules = (rules) => {
        const api = getApi()
        if (!api?.setRule) return
        api.setRule(Array.isArray(rules) ? rules : [])
    }

    const openPreview = () => {
        const api = getApi()
        if (typeof api?.openPreview === 'function') {
            api.openPreview()
            return
        }
        post('preview-fallback', { rules: readRules() })
    }

    const post = (type, payload = {}) => {
        window.parent?.postMessage({ source: 'fc-designer-host', type, ...payload }, '*')
    }

    const onMessage = (event) => {
        const data = event?.data
        if (!data || data.target !== 'fc-designer-host') return
        switch (data.type) {
            case 'setRule':
                writeRules(data.rules || [])
                break
            case 'getRule':
                post('rule', { requestId: data.requestId, rules: readRules() })
                break
            case 'preview':
                openPreview()
                break
            case 'ping':
                post('pong')
                break
            default:
                break
        }
    }

    onMounted(async () => {
        syncHeight()
        window.addEventListener('resize', syncHeight)
        window.addEventListener('message', onMessage)
        ready.value = true
        await nextTick()
        // 再设一次 option，确保默认标签同行生效
        try {
            getApi()?.setOption?.(config.formOptions)
        } catch {
            /* ignore */
        }
        post('ready')
    })

    onBeforeUnmount(() => {
        window.removeEventListener('resize', syncHeight)
        window.removeEventListener('message', onMessage)
    })
</script>

<style>
    .fc-host {
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: #fff;
    }

    .fc-host ._fc-designer {
        width: 100% !important;
        height: 100% !important;
    }
</style>
