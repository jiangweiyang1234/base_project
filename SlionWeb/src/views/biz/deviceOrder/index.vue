<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="设备ID" prop="deviceId">
              <el-input v-model="queryParams.deviceId" placeholder="请输入设备ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="指令OrderNo" prop="orderNo">
              <el-input v-model="queryParams.orderNo" placeholder="请输入指令OrderNo" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="指令发送时间" prop="sendTime">
              <el-date-picker clearable
                v-model="queryParams.sendTime"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择指令发送时间"
              />
            </el-form-item>
            <el-form-item label="指令接收时间" prop="recvTime">
              <el-date-picker clearable
                v-model="queryParams.recvTime"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择指令接收时间"
              />
            </el-form-item>
            <el-form-item label="指令内容" prop="command">
              <el-input v-model="queryParams.command" placeholder="请输入指令内容" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="指令执行进度,主要用于服务升级进度显示" prop="process">
              <el-input v-model="queryParams.process" placeholder="请输入指令执行进度,主要用于服务升级进度显示" clearable @keyup.enter="handleQuery" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['biz:deviceOrder:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['biz:deviceOrder:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['biz:deviceOrder:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['biz:deviceOrder:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="deviceOrderList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键ID" align="center" prop="id" v-if="true" />
        <el-table-column label="设备ID" align="center" prop="deviceId" />
        <el-table-column label="指令OrderNo" align="center" prop="orderNo" />
        <el-table-column label="指令类型: 1.本地指令 2.服务升级 3.修改本地参数" align="center" prop="orderType" />
        <el-table-column label="指令发送时间" align="center" prop="sendTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.sendTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="指令接收时间" align="center" prop="recvTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.recvTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="指令内容" align="center" prop="command" />
        <el-table-column label="指令执行进度,主要用于服务升级进度显示" align="center" prop="process" />
        <el-table-column label="${comment}" align="center" prop="response" />
        <el-table-column label="指令执行状态: 1.未触发 2.进行中 3.执行成功 4.执行失败" align="center" prop="status" />
        <el-table-column label="操作" align="center" fixed="right"  class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['biz:deviceOrder:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['biz:deviceOrder:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改设备指令信息对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="deviceOrderFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="设备ID" prop="deviceId">
          <el-input v-model="form.deviceId" placeholder="请输入设备ID" />
        </el-form-item>
        <el-form-item label="指令OrderNo" prop="orderNo">
          <el-input v-model="form.orderNo" placeholder="请输入指令OrderNo" />
        </el-form-item>
        <el-form-item label="指令发送时间" prop="sendTime">
          <el-date-picker clearable
            v-model="form.sendTime"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择指令发送时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="指令接收时间" prop="recvTime">
          <el-date-picker clearable
            v-model="form.recvTime"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择指令接收时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="指令内容" prop="command">
          <el-input v-model="form.command" placeholder="请输入指令内容" />
        </el-form-item>
        <el-form-item label="指令执行进度,主要用于服务升级进度显示" prop="process">
          <el-input v-model="form.process" placeholder="请输入指令执行进度,主要用于服务升级进度显示" />
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

<script setup name="DeviceOrder" lang="ts">
import { listDeviceOrder, getDeviceOrder, delDeviceOrder, addDeviceOrder, updateDeviceOrder } from '@/api/biz/deviceOrder';
import { DeviceOrderVO, DeviceOrderQuery, DeviceOrderForm } from '@/api/biz/deviceOrder/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const deviceOrderList = ref<DeviceOrderVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const deviceOrderFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: DeviceOrderForm = {
  id: undefined,
  deviceId: undefined,
  orderNo: undefined,
  orderType: undefined,
  sendTime: undefined,
  recvTime: undefined,
  command: undefined,
  process: undefined,
  response: undefined,
  status: undefined,
}
const data = reactive<PageData<DeviceOrderForm, DeviceOrderQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    deviceId: undefined,
    orderNo: undefined,
    orderType: undefined,
    sendTime: undefined,
    recvTime: undefined,
    command: undefined,
    process: undefined,
    response: undefined,
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
    orderNo: [
      { required: true, message: "指令OrderNo不能为空", trigger: "blur" }
    ],
    orderType: [
      { required: true, message: "指令类型: 1.本地指令 2.服务升级 3.修改本地参数不能为空", trigger: "change" }
    ],
    command: [
      { required: true, message: "指令内容不能为空", trigger: "blur" }
    ],
    process: [
      { required: true, message: "指令执行进度,主要用于服务升级进度显示不能为空", trigger: "blur" }
    ],
    response: [
      { required: true, message: "$comment不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "指令执行状态: 1.未触发 2.进行中 3.执行成功 4.执行失败不能为空", trigger: "change" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询设备指令信息列表 */
const getList = async () => {
  loading.value = true;
  const res = await listDeviceOrder(queryParams.value);
  deviceOrderList.value = res.rows;
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
  deviceOrderFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: DeviceOrderVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加设备指令信息";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: DeviceOrderVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getDeviceOrder(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改设备指令信息";
}

/** 提交按钮 */
const submitForm = () => {
  deviceOrderFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateDeviceOrder(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addDeviceOrder(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: DeviceOrderVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除设备指令信息编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delDeviceOrder(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('system/deviceOrder/export', {
    ...queryParams.value
  }, `deviceOrder_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
