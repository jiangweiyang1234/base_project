package net.slion.oauth.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import net.slion.common.core.domain.R;
import net.slion.common.core.validate.AddGroup;
import net.slion.common.core.validate.EditGroup;
import net.slion.common.excel.utils.ExcelUtil;
import net.slion.common.idempotent.annotation.RepeatSubmit;
import net.slion.common.log.annotation.Log;
import net.slion.common.log.enums.BusinessType;
import net.slion.common.mybatis.core.page.PageQuery;
import net.slion.common.mybatis.core.page.TableDataInfo;
import net.slion.common.web.core.BaseController;
import net.slion.oauth.domain.bo.SlionOauthClientBo;
import net.slion.oauth.domain.vo.SlionOauthClientVo;
import net.slion.oauth.service.ISlionOauthClientService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * OAuth2 开放应用管理（AppKey / AppSecret）
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/oauthClient")
public class SlionOauthClientController extends BaseController {

    private final ISlionOauthClientService oauthClientService;

    @SaCheckPermission("system:oauthClient:list")
    @GetMapping("/list")
    public TableDataInfo<SlionOauthClientVo> list(SlionOauthClientBo bo, PageQuery pageQuery) {
        return oauthClientService.queryPageList(bo, pageQuery);
    }

    @SaCheckPermission("system:oauthClient:export")
    @Log(title = "开放应用", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(SlionOauthClientBo bo, HttpServletResponse response) {
        List<SlionOauthClientVo> list = oauthClientService.queryList(bo);
        ExcelUtil.exportExcel(list, "开放应用", SlionOauthClientVo.class, response);
    }

    @SaCheckPermission("system:oauthClient:query")
    @GetMapping("/{id}")
    public R<SlionOauthClientVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(oauthClientService.queryById(id));
    }

    /**
     * 新增；响应中 appSecretPlain 为明文密钥（仅此一次）
     */
    @SaCheckPermission("system:oauthClient:add")
    @Log(title = "开放应用", businessType = BusinessType.INSERT)
    @RepeatSubmit
    @PostMapping
    public R<SlionOauthClientVo> add(@Validated(AddGroup.class) @RequestBody SlionOauthClientBo bo) {
        return R.ok(oauthClientService.insertByBo(bo));
    }

    @SaCheckPermission("system:oauthClient:edit")
    @Log(title = "开放应用", businessType = BusinessType.UPDATE)
    @RepeatSubmit
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody SlionOauthClientBo bo) {
        return toAjax(oauthClientService.updateByBo(bo));
    }

    /**
     * 重置 AppSecret；响应中 appSecretPlain 为新明文（仅此一次）
     */
    @SaCheckPermission("system:oauthClient:edit")
    @Log(title = "开放应用", businessType = BusinessType.UPDATE)
    @PutMapping("/resetSecret/{id}")
    public R<SlionOauthClientVo> resetSecret(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(oauthClientService.resetSecret(id));
    }

    @SaCheckPermission("system:oauthClient:edit")
    @Log(title = "开放应用", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public R<Void> changeStatus(@RequestBody SlionOauthClientBo bo) {
        return toAjax(oauthClientService.updateStatus(bo.getId(), bo.getStatus()));
    }

    @SaCheckPermission("system:oauthClient:remove")
    @Log(title = "开放应用", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(oauthClientService.deleteWithValidByIds(Arrays.asList(ids)));
    }
}
