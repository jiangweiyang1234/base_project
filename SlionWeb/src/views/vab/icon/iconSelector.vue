<template>
    <div class="icon-selector-container">
        <el-popover
            popper-class="icon-selector-popper"
            trigger="hover"
            :width="292"
        >
            <template #reference>
                <el-button>
                    <vab-icon :icon="icon" />
                    图标选择器
                    <vab-icon icon="arrow-down-s-line" />
                </el-button>
            </template>
            <vab-icon-selector @handle-icon="handleIcon" />
        </el-popover>
    </div>
</template>

<script>
    import VabIconSelector from '@/plugins/VabIconSelector'

    export default defineComponent({
        name: 'IconSelector',
        components: { VabIconSelector },
        setup() {
            const state = reactive({
                icon: '24-hours-fill',
            })

            const handleIcon = (item) => {
                state.icon = item
            }

            return {
                ...toRefs(state),
                handleIcon,
            }
        },
    })
</script>


<style lang="scss">
.icon-selector-popper {
   .vab-card{
    &:hover{
        border-color: var(--el-color-primary);
        background-color:  var(--el-color-primary-light-9);
        i{
          color: var(--el-color-primary);
        }
    }
   }
}
</style>
