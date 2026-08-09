package net.slion.common.redis.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.env.EnvironmentPostProcessor;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * 当 slion.redis.enabled=false 时排除 Redis/Redisson/Lock4j 自动装配，避免无 Redis 时启动失败。
 */
public class RedisDisableEnvironmentPostProcessor implements EnvironmentPostProcessor {

    private static final String REDIS_ENABLED = "slion.redis.enabled";

    private static final List<String> REDIS_EXCLUDES = List.of(
        "org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration",
        "org.springframework.boot.autoconfigure.data.redis.RedisReactiveAutoConfiguration",
        "org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration",
        "org.redisson.spring.starter.RedissonAutoConfigurationV2",
        "org.redisson.spring.starter.RedissonAutoConfiguration",
        "com.baomidou.lock.spring.boot.autoconfigure.LockAutoConfiguration"
    );

    @Override
    public void postProcessEnvironment(ConfigurableEnvironment environment, SpringApplication application) {
        Boolean enabled = environment.getProperty(REDIS_ENABLED, Boolean.class, Boolean.TRUE);
        if (Boolean.TRUE.equals(enabled)) {
            return;
        }
        Set<String> excludes = new LinkedHashSet<>();
        String existing = environment.getProperty("spring.autoconfigure.exclude");
        if (existing != null && !existing.isBlank()) {
            Arrays.stream(existing.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .forEach(excludes::add);
        }
        excludes.addAll(REDIS_EXCLUDES);
        environment.getPropertySources().addFirst(new MapPropertySource(
            "slionRedisDisableAutoConfig",
            java.util.Map.of("spring.autoconfigure.exclude", String.join(",", new ArrayList<>(excludes)))
        ));
    }
}
