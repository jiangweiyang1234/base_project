package net.slion.oauth.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import net.slion.common.excel.annotation.ExcelDictFormat;
import net.slion.common.excel.convert.ExcelDictConvert;
import net.slion.oauth.domain.SlionOauthClient;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * OAuth2 开放应用视图对象
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = SlionOauthClient.class)
public class SlionOauthClientVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @ExcelProperty("主键")
    private Long id;

    @ExcelProperty("应用名称")
    private String appName;

    @ExcelProperty("AppKey")
    private String appKey;

    /**
     * 列表/详情不回传密文；仅新增/重置时返回明文一次
     */
    private String appSecret;

    /** 明文密钥（仅创建/重置时返回一次） */
    private String appSecretPlain;

    @ExcelProperty("授权类型")
    private String grantTypes;

    @ExcelProperty("授权范围")
    private String scopes;

    @ExcelProperty("令牌有效期(秒)")
    private Integer accessTokenTtl;

    @ExcelProperty(value = "状态", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "0=正常,1=停用")
    private String status;

    @ExcelProperty("备注")
    private String remark;

    private Date createTime;
}
