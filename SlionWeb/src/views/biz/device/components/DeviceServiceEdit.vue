<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="500px"
        @close="close"
    >
        <el-form ref="formRef" label-width="80px" :model="form" :rules="rules">
            <!--
            <el-form-item label="业务服务" prop="bizService">
                <el-radio-group v-model="form.bizService">
                    <el-radio :label="2">停车服务</el-radio>
                    <el-radio :label="1">校园服务</el-radio>
                </el-radio-group>
            </el-form-item>
            -->
            <el-form-item label="基础服务" prop="baseService">
                <el-checkbox-group v-model="form.baseService">
                    <el-checkbox label="内网穿透" value="1" />
                </el-checkbox-group>
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { gp } from '@gp'

    export default defineComponent({
        name: 'DeviceServiceEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseConfirm = inject('$baseConfirm')
            const deviceWs = inject('deviceWs')

            const state = reactive({
                formRef: null,
                form: {
                    bizService: undefined,
                    baseService: undefined,
                    deviceId: undefined,
                },
                rules: {
                    bizService: [
                        {
                            required: true,
                            message: '业务服务不能为空',
                            trigger: 'blur',
                        },
                    ],
                    baseService: [
                        {
                            required: true,
                            message: '基础服务不能为空',
                            trigger: 'blur',
                        },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })

            const showEdit = (row, type) => {
                if (type === 2) {
                    state.title = '服务卸载'
                } else {
                    state.title = '服务安装'
                }
                state.form.deviceId = row.id
                state.dialogFormVisible = true
            }

            const close = () => {
                state['formRef'].resetFields()
                state.dialogFormVisible = false
            }
            const save = () => {
                state['formRef'].validate(async (valid) => {
                    if (valid) {
                        $baseConfirm('你确定要安装服务吗', null, async () => {
                            deviceWs.send({
                                deviceId: state.form.deviceId,
                                bizType: 'install_service',
                            })
                            deviceWs.loadingInstance.value = gp.$baseLoading(
                                0,
                                '请求数据至设备网关,请稍候...'
                            )
                        })
                        close()
                    }
                })
            }

            return {
                ...toRefs(state),
                showEdit,
                close,
                save,
            }
        },
    })
</script>
