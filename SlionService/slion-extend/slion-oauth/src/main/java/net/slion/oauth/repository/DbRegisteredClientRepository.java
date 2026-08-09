package net.slion.oauth.repository;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import net.slion.common.core.utils.StringUtils;
import net.slion.oauth.domain.SlionOauthClient;
import net.slion.oauth.mapper.SlionOauthClientMapper;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.settings.ClientSettings;
import org.springframework.security.oauth2.server.authorization.settings.TokenSettings;
import org.springframework.util.Assert;

import java.time.Duration;
import java.util.Arrays;

/**
 * 从 slion_oauth_client 加载 OAuth2 RegisteredClient（仅启用状态）
 */
@RequiredArgsConstructor
public class DbRegisteredClientRepository implements RegisteredClientRepository {

    private final SlionOauthClientMapper mapper;

    @Override
    public void save(RegisteredClient registeredClient) {
        // 客户端统一由管理后台维护，协议端不再回写
        Assert.notNull(registeredClient, "registeredClient cannot be null");
    }

    @Override
    public RegisteredClient findById(String id) {
        if (StringUtils.isBlank(id)) {
            return null;
        }
        try {
            SlionOauthClient client = mapper.selectOne(Wrappers.<SlionOauthClient>lambdaQuery()
                .eq(SlionOauthClient::getId, Long.valueOf(id))
                .eq(SlionOauthClient::getStatus, "0"));
            return toRegisteredClient(client);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    @Override
    public RegisteredClient findByClientId(String clientId) {
        if (StringUtils.isBlank(clientId)) {
            return null;
        }
        SlionOauthClient client = mapper.selectOne(Wrappers.<SlionOauthClient>lambdaQuery()
            .eq(SlionOauthClient::getAppKey, clientId)
            .eq(SlionOauthClient::getStatus, "0"));
        return toRegisteredClient(client);
    }

    private RegisteredClient toRegisteredClient(SlionOauthClient client) {
        if (client == null) {
            return null;
        }
        RegisteredClient.Builder builder = RegisteredClient.withId(String.valueOf(client.getId()))
            .clientId(client.getAppKey())
            .clientSecret(client.getAppSecret())
            .clientName(client.getAppName())
            .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
            .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_POST)
            .clientSettings(ClientSettings.builder().requireAuthorizationConsent(false).build())
            .tokenSettings(TokenSettings.builder()
                .accessTokenTimeToLive(Duration.ofSeconds(
                    client.getAccessTokenTtl() == null || client.getAccessTokenTtl() <= 0
                        ? 7200 : client.getAccessTokenTtl()))
                .refreshTokenTimeToLive(Duration.ofDays(7))
                .build());

        String grantTypes = StringUtils.blankToDefault(client.getGrantTypes(), "client_credentials");
        Arrays.stream(grantTypes.split(","))
            .map(String::trim)
            .filter(StringUtils::isNotBlank)
            .forEach(type -> builder.authorizationGrantType(new AuthorizationGrantType(type)));

        String scopes = StringUtils.blankToDefault(client.getScopes(), "open.api");
        Arrays.stream(scopes.split(","))
            .map(String::trim)
            .filter(StringUtils::isNotBlank)
            .forEach(builder::scope);

        return builder.build();
    }
}
