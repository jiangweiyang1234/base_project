package net.slion.common.social.config;

import me.zhyd.oauth.cache.AuthStateCache;
import net.slion.common.social.config.properties.SocialProperties;
import net.slion.common.social.utils.AuthRedisStateCache;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

/**
 * Social 配置属性
 * @author thiszhc
 */
@AutoConfiguration
@EnableConfigurationProperties(SocialProperties.class)
public class SocialAutoConfiguration {

    @Bean
    @ConditionalOnProperty(value = "slion.social.enabled", havingValue = "true")
    public AuthStateCache authStateCache() {
        return new AuthRedisStateCache();
    }

}
