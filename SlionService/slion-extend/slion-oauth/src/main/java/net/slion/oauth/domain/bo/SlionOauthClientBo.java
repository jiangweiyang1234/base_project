package net.slion.oauth.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import net.slion.common.core.validate.AddGroup;
import net.slion.common.core.validate.EditGroup;
import net.slion.common.mybatis.core.domain.BaseEntity;
import net.slion.oauth.domain.SlionOauthClient;

/**
 * OAuth2 开放应用业务对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = SlionOauthClient.class, reverseConvertGenerate = false)
public class SlionOauthClientBo extends BaseEntity {

    @NotNull(message = "主键不能为空", groups = {EditGroup.class})
    private Long id;

    @NotBlank(message = "应用名称不能为空", groups = {AddGroup.class, EditGroup.class})
    private String appName;

    /** 留空则自动生成 */
    private String appKey;

    /** 新增留空则自动生成；修改留空则不更新 */
    private String appSecret;

    /** 默认 client_credentials */
    private String grantTypes;

    /** 默认 open.api */
    private String scopes;

    /** 默认 7200 秒 */
    private Integer accessTokenTtl;

    /** 状态（0正常 1停用） */
    private String status;

    private String remark;
}
