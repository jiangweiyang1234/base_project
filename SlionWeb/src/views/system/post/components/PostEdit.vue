<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="560px" @close="close">
        <el-form ref="formRef" label-width="110px" :model="form" :rules="rules">
            <el-form-item label="岗位编码" prop="postCode">
                <el-input v-model="form.postCode" />
            </el-form-item>
            <el-form-item label="岗位名称" prop="postName">
                <el-input v-model="form.postName" />
            </el-form-item>
            <el-form-item label="显示排序" prop="postSort">
                <el-input-number v-model="form.postSort" :min="0" style="width: 100%" />
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
    import { addPost, updatePost } from '@/api/system/post'

    const emptyForm = () => ({
        postId: undefined,
        postCode: '',
        postName: '',
        postSort: 0,
        status: '0',
        remark: ''
    })

    export default defineComponent({
        name: 'PostEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    postCode: [{ required: true, trigger: 'blur', message: '请输入岗位编码' }],
                    postName: [{ required: true, trigger: 'blur', message: '请输入岗位名称' }]
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row) => {
                if (row && row.postId) {
                    state.title = '编辑'
                    state.form = { ...emptyForm(), ...row }
                } else {
                    state.title = '添加'
                    state.form = emptyForm()
                }
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
                    if (state.form.postId) {
                        const { msg } = await updatePost(state.form)
                        $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    } else {
                        const { msg } = await addPost(state.form)
                        $baseMessage(msg || '新增成功', 'success', 'vab-hey-message-success')
                    }
                    emit('fetch-data')
                    close()
                })
            }
            return { ...toRefs(state), showEdit, close, save }
        },
    })
</script>
