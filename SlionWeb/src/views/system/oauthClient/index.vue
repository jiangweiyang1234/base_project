<template>
  <div class="p-2">
    <transition
      :enter-active-class="proxy?.animate.searchAnimate.enter"
      :leave-active-class="proxy?.animate.searchAnimate.leave"
    >
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="应用名称" prop="appName">
              <el-input
                v-model="queryParams.appName"
                placeholder="请输入应用名称"
                clearable
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="AppKey" prop="appKey">
              <el-input
                v-model="queryParams.appKey"
                placeholder="请输入 AppKey"
                clearable
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="状态" prop="status">
              <el-select v-model="queryParams.status" placeholder="状态" clearable>
                <el-option label="正常" value="0" />
                <el-option label="停用" value="1" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </transition>

    <el-card shadow="never">
      <template #header>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              type="primary"
              plain
              icon="Plus"
              v-hasPermi="['system:oauthClient:add']"
              @click="handleAdd"
            >
              新增
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="Delete"
              :disabled="multiple"
              v-hasPermi="['system:oauthClient:remove']"
              @click="handleDelete()"
            >
              删除
            </el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
        </el-row>
      </template>

      <el-table
        v-loading="loading"
        border
        :data="clientList"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="应用名称" align="center" prop="appName" min-width="120" />
        <el-table-column label="AppKey" align="center" prop="appKey" min-width="180" show-overflow-tooltip />
        <el-table-column label="授权类型" align="center" prop="grantTypes" min-width="140" />
        <el-table-column label="Scopes" align="center" prop="scopes" min-width="120" />
        <el-table-column label="令牌有效期(秒)" align="center" prop="accessTokenTtl" width="130" />
        <el-table-column label="状态" align="center" prop="status" width="90">
          <template #default="scope">
            <el-switch
              v-model="scope.row.status"
              active-value="0"
              inactive-value="1"
              v-hasPermi="['system:oauthClient:edit']"
              @change="(val: string) => handleStatusChange(scope.row, val)"
            />
          </template>
        </el-table-column>
        <el-table-column label="备注" align="center" prop="remark" min-width="120" show-overflow-tooltip />
        <el-table-column label="操作" align="center" fixed="right" width="220">
          <template #default="scope">
            <el-button
              link
              type="primary"
              icon="Edit"
              v-hasPermi="['system:oauthClient:edit']"
              @click="handleUpdate(scope.row)"
            >
              修改
            </el-button>
            <el-button
              link
              type="primary"
              icon="Key"
              v-hasPermi="['system:oauthClient:edit']"
              @click="handleResetSecret(scope.row)"
            >
              重置密钥
            </el-button>
            <el-button
              link
              type="primary"
              icon="Delete"
              v-hasPermi="['system:oauthClient:remove']"
              @click="handleDelete(scope.row)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
      />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="560px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="应用名称" prop="appName">
          <el-input v-model="form.appName" placeholder="合作方 / 应用名称" />
        </el-form-item>
        <el-form-item label="AppKey" prop="appKey">
          <el-input
            v-model="form.appKey"
            :placeholder="form.id ? 'AppKey' : '留空自动生成'"
            :disabled="!!form.id"
          />
        </el-form-item>
        <el-form-item v-if="!form.id" label="AppSecret" prop="appSecret">
          <el-input v-model="form.appSecret" placeholder="留空自动生成" show-password />
        </el-form-item>
        <el-form-item label="授权类型" prop="grantTypes">
          <el-input v-model="form.grantTypes" placeholder="默认 client_credentials" />
        </el-form-item>
        <el-form-item label="Scopes" prop="scopes">
          <el-input v-model="form.scopes" placeholder="默认 open.api，多个用逗号分隔" />
        </el-form-item>
        <el-form-item label="令牌有效期" prop="accessTokenTtl">
          <el-input-number v-model="form.accessTokenTtl" :min="60" :max="86400" />
          <span class="ml-2 text-gray-400">秒</span>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="备注" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </template>
    </el-dialog>

    <el-dialog title="请妥善保存 AppSecret" v-model="secretDialog.visible" width="520px" append-to-body>
      <el-alert
        type="warning"
        :closable="false"
        title="明文密钥仅展示一次，关闭后无法再次查看，请立即复制给合作方。"
        class="mb-3"
      />
      <el-form label-width="100px">
        <el-form-item label="AppKey">
          <el-input v-model="secretDialog.appKey" readonly>
            <template #append>
              <el-button @click="copyText(secretDialog.appKey)">复制</el-button>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="AppSecret">
          <el-input v-model="secretDialog.appSecretPlain" readonly>
            <template #append>
              <el-button @click="copyText(secretDialog.appSecretPlain)">复制</el-button>
            </template>
          </el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="secretDialog.visible = false">我已保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="OauthClient" lang="ts">
import {
  listOauthClient,
  getOauthClient,
  addOauthClient,
  updateOauthClient,
  delOauthClient,
  resetOauthClientSecret,
  changeOauthClientStatus,
} from '@/api/system/oauthClient'

const { proxy } = getCurrentInstance() as ComponentInternalInstance

const clientList = ref<any[]>([])
const buttonLoading = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref<Array<string | number>>([])
const multiple = ref(true)
const total = ref(0)

const queryFormRef = ref<ElFormInstance>()
const formRef = ref<ElFormInstance>()

const dialog = reactive({ visible: false, title: '' })
const secretDialog = reactive({
  visible: false,
  appKey: '',
  appSecretPlain: '',
})

const initForm = {
  id: undefined as number | undefined,
  appName: undefined as string | undefined,
  appKey: undefined as string | undefined,
  appSecret: undefined as string | undefined,
  grantTypes: 'client_credentials',
  scopes: 'open.api',
  accessTokenTtl: 7200,
  remark: undefined as string | undefined,
  status: '0',
}

const data = reactive({
  form: { ...initForm },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    appName: undefined as string | undefined,
    appKey: undefined as string | undefined,
    status: undefined as string | undefined,
  },
  rules: {
    appName: [{ required: true, message: '应用名称不能为空', trigger: 'blur' }],
  },
})

const { queryParams, form, rules } = toRefs(data)

const getList = async () => {
  loading.value = true
  const res: any = await listOauthClient(queryParams.value)
  clientList.value = res.rows || []
  total.value = res.total || 0
  loading.value = false
}

const cancel = () => {
  reset()
  dialog.visible = false
}

const reset = () => {
  form.value = { ...initForm }
  formRef.value?.resetFields()
}

const handleQuery = () => {
  queryParams.value.pageNum = 1
  getList()
}

const resetQuery = () => {
  queryFormRef.value?.resetFields()
  handleQuery()
}

const handleSelectionChange = (selection: any[]) => {
  ids.value = selection.map((item) => item.id)
  multiple.value = !selection.length
}

const handleAdd = () => {
  reset()
  dialog.visible = true
  dialog.title = '新增开放应用'
}

const handleUpdate = async (row?: any) => {
  reset()
  const id = row?.id || ids.value[0]
  const res: any = await getOauthClient(id)
  Object.assign(form.value, res.data)
  dialog.visible = true
  dialog.title = '修改开放应用'
}

const showSecretOnce = (payload: any) => {
  if (!payload?.appSecretPlain) return
  secretDialog.appKey = payload.appKey || ''
  secretDialog.appSecretPlain = payload.appSecretPlain
  secretDialog.visible = true
}

const submitForm = () => {
  formRef.value?.validate(async (valid: boolean) => {
    if (!valid) return
    buttonLoading.value = true
    try {
      if (form.value.id) {
        await updateOauthClient(form.value)
        proxy?.$modal.msgSuccess('修改成功')
      } else {
        const res: any = await addOauthClient(form.value)
        proxy?.$modal.msgSuccess('新增成功')
        showSecretOnce(res.data)
      }
      dialog.visible = false
      await getList()
    } finally {
      buttonLoading.value = false
    }
  })
}

const handleDelete = async (row?: any) => {
  const deleteIds = row?.id || ids.value
  await proxy?.$modal.confirm(`是否确认删除开放应用编号为"${deleteIds}"的数据项？`)
  await delOauthClient(deleteIds)
  proxy?.$modal.msgSuccess('删除成功')
  await getList()
}

const handleResetSecret = async (row: any) => {
  await proxy?.$modal.confirm(`确认重置应用「${row.appName}」的 AppSecret？旧密钥将立即失效。`)
  const res: any = await resetOauthClientSecret(row.id)
  proxy?.$modal.msgSuccess('已重置')
  showSecretOnce(res.data)
}

const handleStatusChange = async (row: any, status: string) => {
  try {
    await changeOauthClientStatus({ id: row.id, status })
    proxy?.$modal.msgSuccess(status === '0' ? '已启用' : '已停用')
  } catch {
    row.status = status === '0' ? '1' : '0'
  }
}

const copyText = async (text: string) => {
  try {
    await navigator.clipboard.writeText(text || '')
    proxy?.$modal.msgSuccess('已复制')
  } catch {
    proxy?.$modal.msgError('复制失败，请手动选择复制')
  }
}

onMounted(() => {
  getList()
})
</script>
