package net.slion.oauth.config;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jose.jwk.source.ImmutableJWKSet;
import com.nimbusds.jose.jwk.source.JWKSource;
import com.nimbusds.jose.proc.SecurityContext;
import lombok.extern.slf4j.Slf4j;
import net.slion.common.core.utils.StringUtils;
import net.slion.oauth.domain.SlionOauthClient;
import net.slion.oauth.mapper.SlionOauthClientMapper;
import net.slion.oauth.repository.DbRegisteredClientRepository;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.config.annotation.web.configuration.OAuth2AuthorizationServerConfiguration;
import org.springframework.security.oauth2.server.authorization.config.annotation.web.configurers.OAuth2AuthorizationServerConfigurer;
import org.springframework.security.oauth2.server.authorization.settings.AuthorizationServerSettings;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.RequestMatcher;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.util.UUID;

/**
 * Spring Authorization Server 配置（仅匹配 OAuth2 协议端点与 /open-api/**）。
 * 其余路径由 {@link AppSecurityPassthroughConfiguration} 放行，交 Sa-Token 处理。
 */
@Slf4j
@AutoConfiguration
@EnableConfigurationProperties(OAuth2Properties.class)
@ConditionalOnProperty(prefix = "oauth2", name = "enabled", havingValue = "true")
public class OAuth2AuthorizationServerConfig {

    @Bean
    @Order(1)
    public SecurityFilterChain authorizationServerSecurityFilterChain(HttpSecurity http) throws Exception {
        OAuth2AuthorizationServerConfigurer authorizationServerConfigurer =
            new OAuth2AuthorizationServerConfigurer();
        RequestMatcher endpointsMatcher = authorizationServerConfigurer.getEndpointsMatcher();

        http.securityMatcher(endpointsMatcher)
            .with(authorizationServerConfigurer, authorizationServer ->
                authorizationServer.oidc(Customizer.withDefaults()))
            .authorizeHttpRequests(authorize -> authorize.anyRequest().authenticated())
            .csrf(csrf -> csrf.ignoringRequestMatchers(endpointsMatcher))
            // 协议端点统一返回 401，避免浏览器被重定向到 /login 触发 Mixed Content
            .exceptionHandling(exceptions -> exceptions.authenticationEntryPoint(
                (request, response, authException) -> {
                    response.setStatus(401);
                    response.setHeader("WWW-Authenticate", "Bearer");
                }));
        return http.build();
    }

    @Bean
    @Order(2)
    public SecurityFilterChain openApiSecurityFilterChain(HttpSecurity http) throws Exception {
        http.securityMatcher("/open-api/**")
            .authorizeHttpRequests(authorize -> authorize.anyRequest().authenticated())
            .oauth2ResourceServer(resourceServer -> resourceServer.jwt(Customizer.withDefaults()))
            .csrf(AbstractHttpConfigurer::disable);
        return http.build();
    }

    @Bean
    public RegisteredClientRepository registeredClientRepository(SlionOauthClientMapper mapper,
                                                                 PasswordEncoder passwordEncoder,
                                                                 OAuth2Properties properties) {
        seedDefaultClientIfEmpty(mapper, passwordEncoder, properties);
        return new DbRegisteredClientRepository(mapper);
    }

    @Bean
    public JWKSource<SecurityContext> jwkSource() {
        KeyPair keyPair = generateRsaKey();
        RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();
        RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();
        RSAKey rsaKey = new RSAKey.Builder(publicKey)
            .privateKey(privateKey)
            .keyID(UUID.randomUUID().toString())
            .build();
        return new ImmutableJWKSet<>(new JWKSet(rsaKey));
    }

    @Bean
    public JwtDecoder jwtDecoder(JWKSource<SecurityContext> jwkSource) {
        return OAuth2AuthorizationServerConfiguration.jwtDecoder(jwkSource);
    }

    @Bean
    public AuthorizationServerSettings authorizationServerSettings(OAuth2Properties properties) {
        return AuthorizationServerSettings.builder()
            .issuer(properties.getIssuer())
            .build();
    }

    private void seedDefaultClientIfEmpty(SlionOauthClientMapper mapper,
                                          PasswordEncoder passwordEncoder,
                                          OAuth2Properties properties) {
        if (StringUtils.isBlank(properties.getClientId()) || StringUtils.isBlank(properties.getClientSecret())) {
            return;
        }
        Long count = mapper.selectCount(Wrappers.emptyWrapper());
        if (count != null && count > 0) {
            return;
        }
        SlionOauthClient seed = new SlionOauthClient();
        seed.setAppName("默认开放应用");
        seed.setAppKey(properties.getClientId());
        seed.setAppSecret(passwordEncoder.encode(properties.getClientSecret()));
        seed.setGrantTypes("client_credentials");
        seed.setScopes(StringUtils.blankToDefault(properties.getScope(), "open.api"));
        seed.setAccessTokenTtl(7200);
        seed.setStatus("0");
        seed.setRemark("空库自动种子，可在管理台「开放应用」中修改或删除");
        mapper.insert(seed);
        log.warn("已写入默认 OAuth 开放应用 AppKey={}，请尽快在管理台维护正式客户端", properties.getClientId());
    }

    private static KeyPair generateRsaKey() {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
            keyPairGenerator.initialize(2048);
            return keyPairGenerator.generateKeyPair();
        } catch (Exception ex) {
            throw new IllegalStateException(ex);
        }
    }
}
