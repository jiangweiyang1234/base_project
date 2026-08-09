<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="520px" @close="close">
        <el-form ref="formRef" label-width="100px" :model="form" :rules="rules">
            <el-form-item label="字典名称" prop="dictName">
                <el-input v-model="form.dictName" />
            </el-form-item>
            <el-form-item label="字典类型" prop="dictType">
                <el-input v-model="form.dictType" />
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.status">
                    <el-radio value="0">正常</el-radio>
                    <el-radio value="1">停用</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="备注" prop="remark">
                <el-input v-model="form.remark" type="textarea" :rows="3" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>
<script>
    import { addDictType, updateDictType } from '@/api/system/dict'
    const emptyForm = () => ({
        dictId: undefined,
        dictName: '',
        dictType: '',
        status: '0',
        remark: '',
    })
    export default defineComponent({
        name: 'DictTypeEdit',
        emits: ['fetch-data'],
        setup(_, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    dictName: [{ required: true, trigger: 'blur', message: '请输入字典名称' }],
                    dictType: [{ required: true, trigger: 'blur', message: '请输入字典类型' }],
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row) => {
                state.title = row?.dictId ? '编辑字典类型' : '添加字典类型'
                state.form = row?.dictId ? { ...emptyForm(), ...row } : emptyForm()
                state.dialogFormVisible = true
            }
            const close = () => {
                state['formRef']?.resetFields?.()
                state.form = emptyForm()
                state.dialogFormVisible = false
            }
            const save = () => {
                state['formRef'].validate(async (valid) => {
                    if (!valid) return
                    const api = state.form.dictId ? updateDictType : addDictType
                    const { msg } = await api(state.form)
                    $baseMessage(msg || '保存成功', 'success', 'vab-hey-message-success')
                    emit('fetch-data')
                    close()
                })
            }
            return { ...toRefs(state), showEdit, close, save }
        },
    })
</script>
