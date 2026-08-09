<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="520px" @close="close">
        <el-form ref="formRef" label-width="100px" :model="form" :rules="rules">
            <el-form-item label="字典类型" prop="dictType">
                <el-input v-model="form.dictType" disabled />
            </el-form-item>
            <el-form-item label="数据标签" prop="dictLabel">
                <el-input v-model="form.dictLabel" />
            </el-form-item>
            <el-form-item label="数据键值" prop="dictValue">
                <el-input v-model="form.dictValue" />
            </el-form-item>
            <el-form-item label="显示排序" prop="dictSort">
                <el-input-number v-model="form.dictSort" :min="0" style="width: 100%" />
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.status">
                    <el-radio value="0">正常</el-radio>
                    <el-radio value="1">停用</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="备注" prop="remark">
                <el-input v-model="form.remark" type="textarea" :rows="2" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>
<script>
    import { addDictData, updateDictData } from '@/api/system/dict'
    const emptyForm = () => ({
        dictCode: undefined,
        dictType: '',
        dictLabel: '',
        dictValue: '',
        dictSort: 0,
        status: '0',
        remark: '',
    })
    export default defineComponent({
        name: 'DictDataEdit',
        emits: ['fetch-data'],
        setup(_, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    dictLabel: [{ required: true, trigger: 'blur', message: '请输入数据标签' }],
                    dictValue: [{ required: true, trigger: 'blur', message: '请输入数据键值' }],
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row, dictType) => {
                state.title = row?.dictCode ? '编辑字典数据' : '添加字典数据'
                state.form = row?.dictCode
                    ? { ...emptyForm(), ...row }
                    : { ...emptyForm(), dictType }
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
                    const api = state.form.dictCode ? updateDictData : addDictData
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
