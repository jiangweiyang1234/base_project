<template>
    <div class="inner-link">
        <iframe v-if="link" class="inner-link__frame" :src="link" />
        <el-empty v-else description="无效的内链地址" />
    </div>
</template>

<script lang="ts">
    export default defineComponent({
        name: 'InnerLink',
        setup() {
            const route = useRoute()
            const link = computed(() => {
                const metaLink = (route.meta as any)?.link
                if (typeof metaLink === 'string' && metaLink) return metaLink
                return ''
            })
            return { link }
        },
    })
</script>

<style scoped>
    .inner-link {
        width: 100%;
        height: calc(100vh - 120px);
    }

    .inner-link__frame {
        width: 100%;
        height: 100%;
        border: 0;
    }
</style>
