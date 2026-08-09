<template>
    <el-dialog v-model="dialogFormVisible" :title="title" width="560px" @close="close">
        <el-form ref="formRef" label-width="110px" :model="form" :rules="rules">
            <el-form-item label="公告标题" prop="noticeTitle">
                <el-input v-model="form.noticeTitle" />
            </el-form-item>
            <el-form-item label="公告类型" prop="noticeType">
                <el-select v-model="form.noticeType" clearable style="width: 100%">
                    <el-option label="通知" value="1" /><el-option label="公告" value="2" />
                </el-select>
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-radio-group v-model="form.status">
                    <el-radio value="0">正常</el-radio>
                    <el-radio value="1">停用</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="内容" prop="noticeContent">
                <el-input v-model="form.noticeContent" type="textarea" :rows="3" />
            </el-form-item>
        </el-form>
        <template #footer>
            <el-button @click="close">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </template>
    </el-dialog>
</template>

<script>
    import { addNotice, updateNotice } from '@/api/system/notice'

    const emptyForm = () => ({
        noticeId: undefined,
        noticeTitle: '',
        noticeType: '1',
        noticeContent: '',
        status: '0'
    })

    export default defineComponent({
        name: 'NoticeEdit',
        emits: ['fetch-data'],
        setup(props, { emit }) {
            const $baseMessage = inject('$baseMessage')
            const state = reactive({
                formRef: null,
                form: emptyForm(),
                rules: {
                    noticeTitle: [{ required: true, trigger: 'blur', message: '请输入公告标题' }],
                    noticeType: [{ required: true, trigger: 'blur', message: '请选择公告类型' }]
                },
                title: '',
                dialogFormVisible: false,
            })
            const showEdit = (row) => {
                if (row && row.noticeId) {
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
                    if (state.form.noticeId) {
                        const { msg } = await updateNotice(state.form)
                        $baseMessage(msg || '修改成功', 'success', 'vab-hey-message-success')
                    } else {
                        const { msg } = await addNotice(state.form)
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
