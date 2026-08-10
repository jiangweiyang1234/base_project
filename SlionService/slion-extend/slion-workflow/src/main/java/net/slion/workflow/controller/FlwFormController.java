package net.slion.workflow.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ObjectUtil;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import net.slion.common.core.domain.R;
import net.slion.common.idempotent.annotation.RepeatSubmit;
import net.slion.common.log.annotation.Log;
import net.slion.common.log.enums.BusinessType;
import net.slion.common.mybatis.core.page.PageQuery;
import net.slion.common.mybatis.core.page.TableDataInfo;
import net.slion.common.web.core.BaseController;
import net.slion.workflow.common.ConditionalOnEnable;
import net.slion.workflow.service.IFlwFormService;
import org.dromara.warm.flow.orm.entity.FlowForm;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 流程表单管理（供设计器关联自定义/动态表单）
 */
@ConditionalOnEnable
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/workflow/form")
public class FlwFormController extends BaseController {

    private final IFlwFormService flwFormService;

    /**
     * 分页查询表单
     */
    @SaCheckPermission("workflow:form:list")
    @GetMapping("/list")
    public TableDataInfo<FlowForm> list(FlowForm form, PageQuery pageQuery) {
        return flwFormService.queryPageList(form, pageQuery);
    }

    /**
     * 已发布表单列表（设计器下拉选用）
     */
    @SaCheckPermission("workflow:form:list")
    @GetMapping("/publishedList")
    public R<List<FlowForm>> publishedList(String formName) {
        return R.ok(flwFormService.listPublished(formName));
    }

    /**
     * 表单详情
     */
    @SaCheckPermission("workflow:form:query")
    @GetMapping("/{id}")
    public R<FlowForm> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(flwFormService.queryById(id));
    }

    /**
     * 新增表单
     */
    @SaCheckPermission("workflow:form:add")
    @Log(title = "流程表单", businessType = BusinessType.INSERT)
    @RepeatSubmit
    @PostMapping
    public R<FlowForm> add(@RequestBody FlowForm form) {
        return flwFormService.insertForm(form) ? R.ok(form) : R.fail();
    }

    /**
     * 修改表单
     */
    @SaCheckPermission("workflow:form:edit")
    @Log(title = "流程表单", businessType = BusinessType.UPDATE)
    @RepeatSubmit
    @PutMapping
    public R<Void> edit(@RequestBody FlowForm form) {
        return toAjax(flwFormService.updateForm(form));
    }

    /**
     * 保存表单内容（内置表单）
     */
    @SaCheckPermission("workflow:form:edit")
    @Log(title = "流程表单内容", businessType = BusinessType.UPDATE)
    @RepeatSubmit
    @PutMapping("/content")
    public R<Void> saveContent(@RequestBody Map<String, Object> body) {
        Long id = ObjectUtil.isNotNull(body.get("id")) ? Long.valueOf(String.valueOf(body.get("id"))) : null;
        String formContent = body.get("formContent") == null ? null : String.valueOf(body.get("formContent"));
        if (id == null) {
            return R.fail("主键不能为空");
        }
        return toAjax(flwFormService.saveContent(id, formContent));
    }

    /**
     * 删除表单
     */
    @SaCheckPermission("workflow:form:remove")
    @Log(title = "流程表单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(flwFormService.deleteByIds(List.of(ids)));
    }

    /**
     * 发布表单
     */
    @SaCheckPermission("workflow:form:publish")
    @Log(title = "流程表单发布", businessType = BusinessType.UPDATE)
    @RepeatSubmit
    @PutMapping("/publish/{id}")
    public R<Void> publish(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return toAjax(flwFormService.publish(id));
    }

    /**
     * 取消发布
     */
    @SaCheckPermission("workflow:form:publish")
    @Log(title = "流程表单取消发布", businessType = BusinessType.UPDATE)
    @RepeatSubmit
    @PutMapping("/unPublish/{id}")
    public R<Void> unPublish(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return toAjax(flwFormService.unPublish(id));
    }

    /**
     * 复制表单
     */
    @SaCheckPermission("workflow:form:add")
    @Log(title = "流程表单复制", businessType = BusinessType.INSERT)
    @RepeatSubmit
    @PostMapping("/copy/{id}")
    public R<Void> copy(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return toAjax(flwFormService.copyForm(id));
    }
}
