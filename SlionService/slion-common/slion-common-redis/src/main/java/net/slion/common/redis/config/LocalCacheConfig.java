package net.slion.common.redis.config;

import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.concurrent.ConcurrentMapCacheManager;
import org.springframework.context.annotation.Bean;

/**
 * Redis 关闭时的本地缓存降级（仅适合单机/本地演示）。
 */
@AutoConfiguration
@EnableCaching
@ConditionalOnProperty(value = "slion.redis.enabled", havingValue = "false")
public class LocalCacheConfig {

    @Bean
    public CacheManager cacheManager() {
        return new ConcurrentMapCacheManager();
    }
}
