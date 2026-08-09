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
     * 默认客户端（Client Credentials）
     */
    private String clientId = "slion-open-api";

    /**
     * 默认客户端密钥（生产务必覆盖）
     */
    private String clientSecret = "CHANGE_ME_OAUTH_CLIENT_SECRET";

    /**
     * 默认 scope
     */
    private String scope = "open.api";
}
