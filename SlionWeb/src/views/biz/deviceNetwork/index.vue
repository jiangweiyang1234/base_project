<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="设备ID" prop="deviceId">
              <el-input v-model="queryParams.deviceId" placeholder="请输入设备ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="网口名称" prop="netName">
              <el-input v-model="queryParams.netName" placeholder="请输入网口名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="IP地址" prop="ipAddress">
              <el-input v-model="queryParams.ipAddress" placeholder="请输入IP地址" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="MAC地址" prop="macAddress">
              <el-input v-model="queryParams.macAddress" placeholder="请输入MAC地址" clearable @keyup.enter="handleQuery" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['biz:deviceNetwork:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['biz:deviceNetwork:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['biz:deviceNetwork:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['biz:deviceNetwork:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="deviceNetworkList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键ID" align="center" prop="id" v-if="true" />
        <el-table-column label="设备ID" align="center" prop="deviceId" />
        <el-table-column label="网口名称" align="center" prop="netName" />
        <el-table-column label="IP地址" align="center" prop="ipAddress" />
        <el-table-column label="MAC地址" align="center" prop="macAddress" />
        <el-table-column label="通讯状态 1.正常 2.异常" align="center" prop="status" />
        <el-table-column label="操作" align="center" fixed="right"  class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['biz:deviceNetwork:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['biz:deviceNetwork:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改设备网络对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="deviceNetworkFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="设备ID" prop="deviceId">
          <el-input v-model="form.deviceId" placeholder="请输入设备ID" />
        </el-form-item>
        <el-form-item label="网口名称" prop="netName">
          <el-input v-model="form.netName" placeholder="请输入网口名称" />
        </el-form-item>
        <el-form-item label="IP地址" prop="ipAddress">
          <el-input v-model="form.ipAddress" placeholder="请输入IP地址" />
        </el-form-item>
        <el-form-item label="MAC地址" prop="macAddress">
          <el-input v-model="form.macAddress" placeholder="请输入MAC地址" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="DeviceNetwork" lang="ts">
import { listDeviceNetwork, getDeviceNetwork, delDeviceNetwork, addDeviceNetwork, updateDeviceNetwork } from '@/api/biz/deviceNetwork';
import { DeviceNetworkVO, DeviceNetworkQuery, DeviceNetworkForm } from '@/api/biz/deviceNetwork/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const deviceNetworkList = ref<DeviceNetworkVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const deviceNetworkFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: DeviceNetworkForm = {
  id: undefined,
  deviceId: undefined,
  netName: undefined,
  ipAddress: undefined,
  macAddress: undefined,
  status: undefined,
}
const data = reactive<PageData<DeviceNetworkForm, DeviceNetworkQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    deviceId: undefined,
    netName: undefined,
    ipAddress: undefined,
    macAddress: undefined,
    status: undefined,
    params: {
    }
  },
  rules: {
    id: [
      { required: true, message: "主键ID不能为空", trigger: "blur" }
    ],
    deviceId: [
      { required: true, message: "设备ID不能为空", trigger: "blur" }
    ],
    netName: [
      { required: true, message: "网口名称不能为空", trigger: "blur" }
    ],
    ipAddress: [
      { required: true, message: "IP地址不能为空", trigger: "blur" }
    ],
    macAddress: [
      { required: true, message: "MAC地址不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "通讯状态 1.正常 2.异常不能为空", trigger: "change" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询设备网络列表 */
const getList = async () => {
  loading.value = true;
  const res = await listDeviceNetwork(queryParams.value);
  deviceNetworkList.value = res.rows;
  total.value = res.total;
  loading.value = false;
}

/** 取消按钮 */
const cancel = () => {
  reset();
  dialog.visible = false;
}

/** 表单重置 */
const reset = () => {
  form.value = {...initFormData};
  deviceNetworkFormRef.value?.resetFields();
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
}

/** 多选框选中数据 */
const handleSelectionChange = (selection: DeviceNetworkVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加设备网络";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: DeviceNetworkVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getDeviceNetwork(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改设备网络";
}

/** 提交按钮 */
const submitForm = () => {
  deviceNetworkFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateDeviceNetwork(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addDeviceNetwork(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: DeviceNetworkVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除设备网络编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delDeviceNetwork(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('system/deviceNetwork/export', {
    ...queryParams.value
  }, `deviceNetwork_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
