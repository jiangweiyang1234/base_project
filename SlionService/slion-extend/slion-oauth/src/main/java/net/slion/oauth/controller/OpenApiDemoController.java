package net.slion.oauth.controller;

import net.slion.common.core.domain.R;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * open-api 示例接口（需 OAuth2 access_token）
 */
@RestController
@RequestMapping("/open-api")
@ConditionalOnProperty(prefix = "oauth2", name = "enabled", havingValue = "true")
public class OpenApiDemoController {

    @GetMapping("/ping")
    public R<Map<String, Object>> ping(@AuthenticationPrincipal Jwt jwt) {
        return R.ok(Map.of(
            "message", "pong",
            "clientId", jwt.getSubject() == null ? jwt.getClaimAsString("sub") : jwt.getSubject(),
            "scopes", jwt.getClaimAsStringList("scope")
        ));
    }
}
