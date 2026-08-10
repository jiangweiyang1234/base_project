import { getDicts } from '@/api/system/dict'

/**
 * 将系统字典转为 form-create options
 */
export async function loadDictOptions(dictType: string) {
    if (!dictType) return []
    const res: any = await getDicts(dictType)
    const list = res?.data || res || []
    return (Array.isArray(list) ? list : []).map((item: any) => ({
        label: item.dictLabel ?? item.label,
        value: item.dictValue ?? item.value,
    }))
}

/** 字典接口地址（设计器 / 运行时远程选项） */
export function dictDataAction(dictType: string) {
    return `/system/dict/data/type/${encodeURIComponent(dictType)}`
}

/**
 * 解析字典接口响应为 options
 */
export function parseDictResponse(res: any) {
    const list = res?.data ?? res ?? []
    return (Array.isArray(list) ? list : []).map((item: any) => ({
        label: item.dictLabel ?? item.label,
        value: item.dictValue ?? item.value,
    }))
}

/**
 * 为带 props.dictType 的控件补齐 effect.fetch，便于运行时自动拉选项
 */
export function attachDictFetch(rules: any[]): any[] {
    if (!Array.isArray(rules)) return []
    const cloned = JSON.parse(JSON.stringify(rules))
    const walk = (nodes: any[]) => {
        for (const node of nodes) {
            const dictType =
                node?.props?.dictType ||
                node?.effect?.fetch?.dictType ||
                node?.props?.dict
            if (dictType && typeof dictType === 'string') {
                node.props = node.props || {}
                node.props.dictType = dictType
                node.effect = node.effect || {}
                node.effect.fetch = {
                    action: dictDataAction(dictType),
                    to: 'options',
                    method: 'GET',
                    dictType,
                }
            }
            if (Array.isArray(node.children)) walk(node.children)
            if (Array.isArray(node.control)) {
                for (const c of node.control) {
                    if (Array.isArray(c.rule)) walk(c.rule)
                }
            }
        }
    }
    walk(cloned)
    return cloned
}

/**
 * 为设计器 rule 注入远程字典（props.dictType → options）
 */
export async function hydrateDictOptions(rules: any[]): Promise<any[]> {
    if (!Array.isArray(rules)) return []
    const withFetch = attachDictFetch(rules)
    const walk = async (nodes: any[]) => {
        for (const node of nodes) {
            const dictType =
                node?.props?.dictType ||
                node?.effect?.fetch?.dictType ||
                node?.props?.dict
            if (dictType && typeof dictType === 'string') {
                try {
                    const options = await loadDictOptions(dictType)
                    node.options = options
                    node.props = node.props || {}
                    node.props.options = options
                } catch (e) {
                    console.warn('加载字典失败:', dictType, e)
                }
            }
            if (Array.isArray(node.children)) {
                await walk(node.children)
            }
            if (Array.isArray(node.control)) {
                for (const c of node.control) {
                    if (Array.isArray(c.rule)) await walk(c.rule)
                }
            }
        }
    }
    await walk(withFetch)
    return withFetch
}

/**
 * 根据 rule 生成简易 Vue SFC 片段（外挂页可参考）
 */
export function buildVueSfcSnippet(rules: any[], formName = 'BizForm') {
    const json = JSON.stringify(rules || [], null, 2)
    return `<template>
  <form-create
    v-model:api="fapi"
    :rule="rule"
    :option="option"
    @submit="onSubmit"
  />
</template>

<script setup>
import { ref, reactive } from 'vue'

const fapi = ref(null)
const rule = ref(${json})
const option = reactive({
  form: { labelWidth: '100px' },
  submitBtn: { innerText: '提交' },
  resetBtn: true,
})

const onSubmit = (formData) => {
  console.log('${formName} submit', formData)
}
<\/script>
`
}

/**
 * HTML 预览说明 + 结构摘要（真实渲染由 form-create 组件完成）
 */
export function buildHtmlPreviewHint(rules: any[]) {
    const count = Array.isArray(rules) ? rules.length : 0
    return `<!-- 由 form-create 根据 rule JSON 动态渲染，共 ${count} 个根字段 -->
<!-- 预览请切换到「设计」或下方实时预览区 -->
<div id="form-create-preview" data-fields="${count}"></div>
`
}
