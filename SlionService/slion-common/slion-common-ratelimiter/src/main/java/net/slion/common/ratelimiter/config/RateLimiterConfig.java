package net.slion.common.ratelimiter.config;

import net.slion.common.ratelimiter.aspectj.RateLimiterAspect;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.RedisConfiguration;

/**
 * @author guangxin
 * @date 2023/1/18
 */
@AutoConfiguration(after = RedisConfiguration.class)
@ConditionalOnProperty(value = "slion.redis.enabled", havingValue = "true", matchIfMissing = true)
public class RateLimiterConfig {

    @Bean
    public RateLimiterAspect rateLimiterAspect() {
        return new RateLimiterAspect();
    }

}
