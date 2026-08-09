<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="设备ID" prop="deviceId">
              <el-input v-model="queryParams.deviceId" placeholder="请输入设备ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="业务Key" prop="bizKey">
              <el-input v-model="queryParams.bizKey" placeholder="请输入业务Key" clearable @keyup.enter="handleQuery" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['biz:deviceFrp:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['biz:deviceFrp:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['biz:deviceFrp:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['biz:deviceFrp:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="deviceFrpList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键ID" align="center" prop="id" v-if="true" />
        <el-table-column label="设备ID" align="center" prop="deviceId" />
        <el-table-column label="FRP Client配置参数,以json进行参数存储" align="center" prop="frpConfig" />
        <el-table-column label="业务Key" align="center" prop="bizKey" />
        <el-table-column label="操作" align="center" fixed="right"  class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['biz:deviceFrp:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['biz:deviceFrp:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改设备Mac数据导入对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="deviceFrpFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="设备ID" prop="deviceId">
          <el-input v-model="form.deviceId" placeholder="请输入设备ID" />
        </el-form-item>
        <el-form-item label="业务Key" prop="bizKey">
          <el-input v-model="form.bizKey" placeholder="请输入业务Key" />
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

<script setup name="DeviceFrp" lang="ts">
import { listDeviceFrp, getDeviceFrp, delDeviceFrp, addDeviceFrp, updateDeviceFrp } from '@/api/biz/deviceFrp';
import { DeviceFrpVO, DeviceFrpQuery, DeviceFrpForm } from '@/api/biz/deviceFrp/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const deviceFrpList = ref<DeviceFrpVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const deviceFrpFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: DeviceFrpForm = {
  id: undefined,
  deviceId: undefined,
  frpConfig: undefined,
  bizKey: undefined,
}
const data = reactive<PageData<DeviceFrpForm, DeviceFrpQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    deviceId: undefined,
    frpConfig: undefined,
    bizKey: undefined,
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
    frpConfig: [
      { required: true, message: "FRP Client配置参数,以json进行参数存储不能为空", trigger: "blur" }
    ],
    bizKey: [
      { required: true, message: "业务Key不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询设备Mac数据导入列表 */
const getList = async () => {
  loading.value = true;
  const res = await listDeviceFrp(queryParams.value);
  deviceFrpList.value = res.rows;
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
  deviceFrpFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: DeviceFrpVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加设备Mac数据导入";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: DeviceFrpVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getDeviceFrp(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改设备Mac数据导入";
}

/** 提交按钮 */
const submitForm = () => {
  deviceFrpFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateDeviceFrp(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addDeviceFrp(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: DeviceFrpVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除设备Mac数据导入编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delDeviceFrp(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('system/deviceFrp/export', {
    ...queryParams.value
  }, `deviceFrp_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
