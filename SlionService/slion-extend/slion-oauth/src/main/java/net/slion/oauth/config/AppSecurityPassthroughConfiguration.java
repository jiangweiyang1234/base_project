package net.slion.oauth.config;

import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

/**
 * 覆盖 Spring Security 默认「全站需登录 + HTTP Basic」行为。
 * <p>
 * slion-oauth 引入了 spring-security / oauth2 starter 后，即便 oauth2.enabled=false，
 * Boot 也会装配默认 SecurityFilterChain，导致 /auth/code 返回 401 并跳转 /login
 * （HTTPS 页面下再触发 Mixed Content）。
 * <p>
 * 管理端鉴权仍由 Sa-Token 负责；OAuth2 协议与 /open-api 由更高优先级链处理。
 */
@AutoConfiguration
@EnableWebSecurity
public class AppSecurityPassthroughConfiguration {

    @Bean
    @Order(Ordered.LOWEST_PRECEDENCE)
    public SecurityFilterChain saTokenPassthroughSecurityFilterChain(HttpSecurity http) throws Exception {
        http.securityMatcher("/**")
            .authorizeHttpRequests(authorize -> authorize.anyRequest().permitAll())
            .csrf(AbstractHttpConfigurer::disable)
            .httpBasic(AbstractHttpConfigurer::disable)
            .formLogin(AbstractHttpConfigurer::disable)
            .logout(AbstractHttpConfigurer::disable)
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            // 默认 DENY 会阻断同域 iframe（Warm-Flow 设计器）；SAMEORIGIN 仅允许本站嵌入
            .headers(headers -> headers.frameOptions(frame -> frame.sameOrigin()));
        return http.build();
    }
}
