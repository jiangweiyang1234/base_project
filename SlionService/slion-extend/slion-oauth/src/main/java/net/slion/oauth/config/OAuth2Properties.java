package net.slion.oauth.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * OAuth2 扩展配置
 */
@Data
@ConfigurationProperties(prefix = "oauth2")
public class OAuth2Properties {

    /**
     * 是否启用 OAuth2 授权服务
     */
    private boolean enabled = false;

    /**
     * Issuer，例如 https://api.example.com
     */
    private String issuer = "http://localhost:8080";

    /**
     * 空库时可选种子 AppKey；正式客户端请在管理台「开放应用」维护
     */
    private String clientId = "";

    /**
     * 空库时可选种子 AppSecret
     */
    private String clientSecret = "";

    /**
     * 默认 scope（种子与默认值）
     */
    private String scope = "open.api";
}
