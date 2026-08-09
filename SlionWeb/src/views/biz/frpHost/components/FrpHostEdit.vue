<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="780px"
        @close="close"
    >
        <el-form ref="formRef" label-width="120px" :model="form" :rules="rules">
            <el-form-item label="设备主机" prop="deviceId">
                <el-select v-model="form.deviceId" clearable filterable>
                    <el-option
                        v-for="item in deviceSelectList"
                        :key="item.id"
                        :label="`${item.hostname} - [${item.deviceSn}]`"
                        :value="item.id"
                    />
                </el-select>
            </el-form-item>
            <el-form-item label="链路名称" prop="hostName">
                <el-input v-model="form.hostName" />
            </el-form-item>
            <el-form-item label="服务协议" prop="protocol">
                <el-select v-model="form.protocol" placeholder="请选择服务协议">
                    <el-option value="SSH" label="SSH" />
                    <el-option value="TCP" label="TCP" />
                    <el-option value="HTTP" label="HTTP" />
                    <el-option value="SOCKS" label="SOCKS" />
                </el-select>
            </el-form-item>
            <el-form-item label="服务主机IP" prop="host">
                <el-input v-model="form.host" placeholder="192.168.0.100" />
            </el-form-item>
            <el-form-item label="主机端口" prop="port">
                <el-input v-model="form.port" placeholder="80" />
            </el-form-item>

            <el-form-item
                v-if="form.protocol === 'SOCKS5'"
                label="Socks用户名"
                prop="pluginUser"
            >
                <el-input v-model="form.pluginUser" />
            </el-form-item>
            <el-form-item
                v-if="form.protocol === 'SOCKS5'"
                label="Socks密码"
                prop="pluginPwd"
            >
                <el-input v-model="form.pluginPwd" />
            </el-form-item>
            <el-form-item
                v-if="form.protocol === 'SOCKS5'"
                label="是否启用加密"
                prop="useEncryption"
            >
                <el-radio-group v-model="form.useEncryption">
                    <el-radio :label="true">是</el-radio>
                    <el-radio :label="false">否</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item
                v-if="form.protocol === 'SOCKS5'"
                label="是否启用压缩"
                prop="useCompression"
            >
                <el-radio-group v-model="form.useCompression">
                    <el-radio :label="true">是</el-radio>
                    <el-radio :label="false">否</el-radio>
                </el-radio-group>
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { doEdit, doSave } from '@/api/biz/frpHost'
    import { getDeviceList } from '@/api/biz/device'

    export default defineComponent({
        name: 'FrpHostEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const state = reactive({
                formRef: null,
                form: {
                    id: undefined,
                    deviceId: undefined,
                    hostName: undefined,
                    protocol: undefined,
                    host: undefined,
                    port: undefined,
                    pluginUser: undefined,
                    pluginPwd: undefined,
                    useEncryption: true,
                    useCompression: true,
                },
                rules: {
                    deviceId: [
                        {
                            required: true,
                            message: '设备主机不能为空',
                            trigger: 'blur',
                        },
                    ],
                    hostName: [
                        {
                            required: true,
                            message: '链路名称不能为空',
                            trigger: 'blur',
                        },
                    ],
                    protocol: [
                        {
                            required: true,
                            message: '通讯协议不能为空',
                            trigger: 'blur',
                        },
                    ],
                    host: [
                        {
                            required: true,
                            message: '服务主机IP不能为空',
                            trigger: 'blur',
                        },
                    ],
                    port: [
                        {
                            required: true,
                            message: '端口号:默认80不能为空',
                            trigger: 'blur',
                        },
                    ],
                },
                title: '',
                dialogFormVisible: false,
                deviceSelectList: [],
            })
            const showEdit = (row) => {
                state.title = '添加/编辑'
                if (row) {
                    state.form = {
                        ...JSON.parse(JSON.stringify(row)),
                    }
                }
                state.dialogFormVisible = true
            }
            const close = () => {
                state['formRef'].resetFields()
                state.form = {
                    id: undefined,
                    deviceId: undefined,
                    hostName: undefined,
                    protocol: undefined,
                    host: undefined,
                    port: undefined,
                    pluginUser: undefined,
                    pluginPwd: undefined,
                    useEncryption: true,
                    useCompression: true,
                }
                state.dialogFormVisible = false
            }
            const save = () => {
                state['formRef'].validate(async (valid) => {
                    if (valid) {
                        if (state.form.id === undefined) {
                            // save
                            const { msg } = await doSave(state.form)
                            $baseMessage(
                                msg,
                                'success',
                                'vab-hey-message-success'
                            )
                            emit('fetch-data')
                            // emit('fetch-data', { key: state.form.parentKey })
                            close()
                        } else {
                            // update
                            const { msg } = await doEdit(state.form)
                            $baseMessage(
                                msg,
                                'success',
                                'vab-hey-message-success'
                            )
                            emit('fetch-data')
                            // emit('fetch-data', { key: state.form.parentKey })
                            close()
                        }
                    }
                })
            }

            const fetchDeviceList = async () => {
                const { code, data } = await getDeviceList()
                if (code === 200) {
                    state.deviceSelectList = data
                } else {
                    state.deviceSelectList = []
                }
            }

            onMounted(() => {
                // 加载设备主机列表
                fetchDeviceList()
            })

            return {
                ...toRefs(state),
                showEdit,
                close,
                save,
            }
        },
    })
</script>
