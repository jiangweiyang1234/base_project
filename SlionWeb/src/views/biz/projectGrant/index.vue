<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="项目ID" prop="projectId">
              <el-input v-model="queryParams.projectId" placeholder="请输入项目ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="授权发起人" prop="grantFrom">
              <el-input v-model="queryParams.grantFrom" placeholder="请输入授权发起人" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="授权接收对象" prop="grantTo">
              <el-input v-model="queryParams.grantTo" placeholder="请输入授权接收对象" clearable @keyup.enter="handleQuery" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['biz:projectGrant:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['biz:projectGrant:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['biz:projectGrant:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['biz:projectGrant:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="projectGrantList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键ID" align="center" prop="gid" v-if="true" />
        <el-table-column label="项目ID" align="center" prop="projectId" />
        <el-table-column label="授权类型: 1.授权给公司 2.授权给部门 3.授权给个人" align="center" prop="grantType" />
        <el-table-column label="授权发起人" align="center" prop="grantFrom" />
        <el-table-column label="授权接收对象" align="center" prop="grantTo" />
        <el-table-column label="操作" align="center" fixed="right"  class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['biz:projectGrant:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['biz:projectGrant:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改项目授权信息对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="projectGrantFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="项目ID" prop="projectId">
          <el-input v-model="form.projectId" placeholder="请输入项目ID" />
        </el-form-item>
        <el-form-item label="授权发起人" prop="grantFrom">
          <el-input v-model="form.grantFrom" placeholder="请输入授权发起人" />
        </el-form-item>
        <el-form-item label="授权接收对象" prop="grantTo">
          <el-input v-model="form.grantTo" placeholder="请输入授权接收对象" />
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

<script setup name="ProjectGrant" lang="ts">
import { listProjectGrant, getProjectGrant, delProjectGrant, addProjectGrant, updateProjectGrant } from '@/api/biz/projectGrant';
import { ProjectGrantVO, ProjectGrantQuery, ProjectGrantForm } from '@/api/biz/projectGrant/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const projectGrantList = ref<ProjectGrantVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const projectGrantFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: ProjectGrantForm = {
  gid: undefined,
  projectId: undefined,
  grantType: undefined,
  grantFrom: undefined,
  grantTo: undefined,
}
const data = reactive<PageData<ProjectGrantForm, ProjectGrantQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    projectId: undefined,
    grantType: undefined,
    grantFrom: undefined,
    grantTo: undefined,
    params: {
    }
  },
  rules: {
    gid: [
      { required: true, message: "主键ID不能为空", trigger: "blur" }
    ],
    grantType: [
      { required: true, message: "授权类型: 1.授权给公司 2.授权给部门 3.授权给个人不能为空", trigger: "change" }
    ],
    grantFrom: [
      { required: true, message: "授权发起人不能为空", trigger: "blur" }
    ],
    grantTo: [
      { required: true, message: "授权接收对象不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询项目授权信息列表 */
const getList = async () => {
  loading.value = true;
  const res = await listProjectGrant(queryParams.value);
  projectGrantList.value = res.rows;
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
  projectGrantFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: ProjectGrantVO[]) => {
  ids.value = selection.map(item => item.gid);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加项目授权信息";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: ProjectGrantVO) => {
  reset();
  const _gid = row?.gid || ids.value[0]
  const res = await getProjectGrant(_gid);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改项目授权信息";
}

/** 提交按钮 */
const submitForm = () => {
  projectGrantFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.gid) {
        await updateProjectGrant(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addProjectGrant(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: ProjectGrantVO) => {
  const _gids = row?.gid || ids.value;
  await proxy?.$modal.confirm('是否确认删除项目授权信息编号为"' + _gids + '"的数据项？').finally(() => loading.value = false);
  await delProjectGrant(_gids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('system/projectGrant/export', {
    ...queryParams.value
  }, `projectGrant_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
