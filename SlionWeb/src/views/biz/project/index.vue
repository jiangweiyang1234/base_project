<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="项目名称" prop="projectName">
              <el-input v-model="queryParams.projectName" placeholder="请输入项目名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="上级项目ID" prop="upProjectId">
              <el-input v-model="queryParams.upProjectId" placeholder="请输入上级项目ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="项目级别" prop="projectLevel">
              <el-input v-model="queryParams.projectLevel" placeholder="请输入项目级别" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="国家ID" prop="country">
              <el-input v-model="queryParams.country" placeholder="请输入国家ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="省级ID" prop="province">
              <el-input v-model="queryParams.province" placeholder="请输入省级ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="城市ID" prop="city">
              <el-input v-model="queryParams.city" placeholder="请输入城市ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="区域ID" prop="area">
              <el-input v-model="queryParams.area" placeholder="请输入区域ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="街道ID" prop="street">
              <el-input v-model="queryParams.street" placeholder="请输入街道ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="详细地址" prop="address">
              <el-input v-model="queryParams.address" placeholder="请输入详细地址" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="纬度" prop="lat">
              <el-input v-model="queryParams.lat" placeholder="请输入纬度" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="经度" prop="lon">
              <el-input v-model="queryParams.lon" placeholder="请输入经度" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="联系人姓名" prop="linkerName">
              <el-input v-model="queryParams.linkerName" placeholder="请输入联系人姓名" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="联系人电话" prop="linkerMobile">
              <el-input v-model="queryParams.linkerMobile" placeholder="请输入联系人电话" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="项目状态: 1.施工中 2.部分离线 3.在线 4.报警 5.已拆除" prop="projectState">
              <el-input v-model="queryParams.projectState" placeholder="请输入项目状态: 1.施工中 2.部分离线 3.在线 4.报警 5.已拆除" clearable @keyup.enter="handleQuery" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['biz:project:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['biz:project:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['biz:project:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['biz:project:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="projectList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="项目ID" align="center" prop="projectId" v-if="true" />
        <el-table-column label="项目名称" align="center" prop="projectName" />
        <el-table-column label="上级项目ID" align="center" prop="upProjectId" />
        <el-table-column label="项目类型: 1.停车道闸场景 2.校园门禁场景" align="center" prop="projectType" />
        <el-table-column label="项目级别" align="center" prop="projectLevel" />
        <el-table-column label="国家ID" align="center" prop="country" />
        <el-table-column label="省级ID" align="center" prop="province" />
        <el-table-column label="城市ID" align="center" prop="city" />
        <el-table-column label="区域ID" align="center" prop="area" />
        <el-table-column label="街道ID" align="center" prop="street" />
        <el-table-column label="详细地址" align="center" prop="address" />
        <el-table-column label="纬度" align="center" prop="lat" />
        <el-table-column label="经度" align="center" prop="lon" />
        <el-table-column label="联系人姓名" align="center" prop="linkerName" />
        <el-table-column label="联系人电话" align="center" prop="linkerMobile" />
        <el-table-column label="项目状态: 1.施工中 2.部分离线 3.在线 4.报警 5.已拆除" align="center" prop="projectState" />
        <el-table-column label="操作" align="center" fixed="right"  class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['biz:project:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['biz:project:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改项目数据对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="projectFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="项目名称" prop="projectName">
          <el-input v-model="form.projectName" placeholder="请输入项目名称" />
        </el-form-item>
        <el-form-item label="上级项目ID" prop="upProjectId">
          <el-input v-model="form.upProjectId" placeholder="请输入上级项目ID" />
        </el-form-item>
        <el-form-item label="项目级别" prop="projectLevel">
          <el-input v-model="form.projectLevel" placeholder="请输入项目级别" />
        </el-form-item>
        <el-form-item label="国家ID" prop="country">
          <el-input v-model="form.country" placeholder="请输入国家ID" />
        </el-form-item>
        <el-form-item label="省级ID" prop="province">
          <el-input v-model="form.province" placeholder="请输入省级ID" />
        </el-form-item>
        <el-form-item label="城市ID" prop="city">
          <el-input v-model="form.city" placeholder="请输入城市ID" />
        </el-form-item>
        <el-form-item label="区域ID" prop="area">
          <el-input v-model="form.area" placeholder="请输入区域ID" />
        </el-form-item>
        <el-form-item label="街道ID" prop="street">
          <el-input v-model="form.street" placeholder="请输入街道ID" />
        </el-form-item>
        <el-form-item label="详细地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入详细地址" />
        </el-form-item>
        <el-form-item label="纬度" prop="lat">
          <el-input v-model="form.lat" placeholder="请输入纬度" />
        </el-form-item>
        <el-form-item label="经度" prop="lon">
          <el-input v-model="form.lon" placeholder="请输入经度" />
        </el-form-item>
        <el-form-item label="联系人姓名" prop="linkerName">
          <el-input v-model="form.linkerName" placeholder="请输入联系人姓名" />
        </el-form-item>
        <el-form-item label="联系人电话" prop="linkerMobile">
          <el-input v-model="form.linkerMobile" placeholder="请输入联系人电话" />
        </el-form-item>
        <el-form-item label="项目状态: 1.施工中 2.部分离线 3.在线 4.报警 5.已拆除" prop="projectState">
          <el-input v-model="form.projectState" placeholder="请输入项目状态: 1.施工中 2.部分离线 3.在线 4.报警 5.已拆除" />
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

<script setup name="Project" lang="ts">
import { listProject, getProject, delProject, addProject, updateProject } from '@/api/biz/project';
import { ProjectVO, ProjectQuery, ProjectForm } from '@/api/biz/project/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const projectList = ref<ProjectVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const projectFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: ProjectForm = {
  projectId: undefined,
  projectName: undefined,
  upProjectId: undefined,
  projectType: undefined,
  projectLevel: undefined,
  country: undefined,
  province: undefined,
  city: undefined,
  area: undefined,
  street: undefined,
  address: undefined,
  lat: undefined,
  lon: undefined,
  linkerName: undefined,
  linkerMobile: undefined,
  projectState: undefined,
}
const data = reactive<PageData<ProjectForm, ProjectQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    projectName: undefined,
    upProjectId: undefined,
    projectType: undefined,
    projectLevel: undefined,
    country: undefined,
    province: undefined,
    city: undefined,
    area: undefined,
    street: undefined,
    address: undefined,
    lat: undefined,
    lon: undefined,
    linkerName: undefined,
    linkerMobile: undefined,
    projectState: undefined,
    params: {
    }
  },
  rules: {
    projectId: [
      { required: true, message: "项目ID不能为空", trigger: "blur" }
    ],
    projectName: [
      { required: true, message: "项目名称不能为空", trigger: "blur" }
    ],
    upProjectId: [
      { required: true, message: "上级项目ID不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询项目数据列表 */
const getList = async () => {
  loading.value = true;
  const res = await listProject(queryParams.value);
  projectList.value = res.rows;
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
  projectFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: ProjectVO[]) => {
  ids.value = selection.map(item => item.projectId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加项目数据";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: ProjectVO) => {
  reset();
  const _projectId = row?.projectId || ids.value[0]
  const res = await getProject(_projectId);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改项目数据";
}

/** 提交按钮 */
const submitForm = () => {
  projectFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.projectId) {
        await updateProject(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addProject(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: ProjectVO) => {
  const _projectIds = row?.projectId || ids.value;
  await proxy?.$modal.confirm('是否确认删除项目数据编号为"' + _projectIds + '"的数据项？').finally(() => loading.value = false);
  await delProject(_projectIds);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('system/project/export', {
    ...queryParams.value
  }, `project_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
