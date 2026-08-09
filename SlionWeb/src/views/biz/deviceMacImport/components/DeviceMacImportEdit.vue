<template>
    <el-dialog
        v-model="dialogFormVisible"
        :title="title"
        width="560px"
        @close="close"
    >
        <el-form ref="formRef" label-width="100px" :model="form" :rules="rules">
            <el-form-item label="MAC地址1" prop="macAddress1">
                <el-input
                    v-model="form.macAddress1"
                    placeholder="请输入MAC地址1"
                />
            </el-form-item>
            <el-form-item label="MAC地址2" prop="macAddress2">
                <el-input
                    v-model="form.macAddress2"
                    placeholder="请输入MAC地址2（可选）"
                />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { doEdit, doSave } from '@/api/biz/deviceMacImport'

    const macAddressPattern =
        /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/

    export default defineComponent({
        name: 'DeviceMacImportEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')

            const validateMacAddress = (rule, value, callback) => {
                if (!value) {
                    callback()
                    return
                }
                if (!macAddressPattern.test(value)) {
                    callback(new Error('MAC地址格式不正确'))
                    return
                }
                callback()
            }

            const state = reactive({
                formRef: null,
                form: {
                    id: undefined,
                    macAddress1: undefined,
                    macAddress2: undefined,
                },
                rules: {
                    macAddress1: [
                        {
                            required: true,
                            message: 'MAC地址1不能为空',
                            trigger: 'blur',
                        },
                        {
                            validator: validateMacAddress,
                            trigger: 'blur',
                        },
                    ],
                    macAddress2: [
                        {
                            validator: validateMacAddress,
                            trigger: 'blur',
                        },
                    ],
                },
                title: '',
                dialogFormVisible: false,
            })

            const showEdit = (row) => {
                state.title = row ? '修改MAC地址' : '新增MAC地址'
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
                    macAddress1: undefined,
                    macAddress2: undefined,
                }
                state.dialogFormVisible = false
            }

            const save = () => {
                state['formRef'].validate(async (valid) => {
                    if (valid) {
                        if (state.form.id === undefined) {
                            const { msg } = await doSave(state.form)
                            $baseMessage(
                                msg,
                                'success',
                                'vab-hey-message-success'
                            )
                        } else {
                            const { msg } = await doEdit(state.form)
                            $baseMessage(
                                msg,
                                'success',
                                'vab-hey-message-success'
                            )
                        }
                        emit('fetch-data')
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
