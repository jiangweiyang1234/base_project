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
    })

    const syncHeight = () => {
        height.value = Math.max(window.innerHeight, 480)
    }

    const getApi = () => designerRef.value

    const readRules = () => {
        const api = getApi()
        if (!api?.getRule) return []
        try {
            return api.getRule() || []
        } catch {
            return []
        }
    }

    const writeRules = (rules) => {
        const api = getApi()
        if (!api?.setRule) return
        api.setRule(Array.isArray(rules) ? rules : [])
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
