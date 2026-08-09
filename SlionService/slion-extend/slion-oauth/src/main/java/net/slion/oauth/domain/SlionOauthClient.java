package net.slion.oauth.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import net.slion.common.mybatis.core.domain.BaseEntity;

import java.io.Serial;

/**
 * OAuth2 开放应用（AppKey / AppSecret）
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("slion_oauth_client")
public class SlionOauthClient extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "id")
    private Long id;

    /** 应用名称 */
    private String appName;

    /** AppKey（OAuth2 client_id） */
    private String appKey;

    /** AppSecret（加密存储） */
    private String appSecret;

    /** 授权类型，逗号分隔 */
    private String grantTypes;

    /** 授权范围，逗号分隔 */
    private String scopes;

    /** 访问令牌有效期（秒） */
    private Integer accessTokenTtl;

    /** 状态（0正常 1停用） */
    private String status;

    /** 删除标志（0存在 1删除） */
    @TableLogic
    private String delFlag;

    /** 备注 */
    private String remark;
}
