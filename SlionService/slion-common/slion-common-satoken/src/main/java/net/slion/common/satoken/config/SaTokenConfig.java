package net.slion.common.satoken.config;

import cn.dev33.satoken.dao.SaTokenDao;
import cn.dev33.satoken.dao.SaTokenDaoDefaultImpl;
import cn.dev33.satoken.jwt.StpLogicJwtForSimple;
import cn.dev33.satoken.stp.StpInterface;
import cn.dev33.satoken.stp.StpLogic;
import net.slion.common.core.factory.YmlPropertySourceFactory;
import net.slion.common.satoken.core.dao.PlusSaTokenDao;
import net.slion.common.satoken.core.service.SaPermissionImpl;
import net.slion.common.satoken.handler.SaTokenExceptionHandler;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;

/**
 * sa-token 配置
 *
 * @author Lion Li
 */
@AutoConfiguration
@PropertySource(value = "classpath:common-satoken.yml", factory = YmlPropertySourceFactory.class)
public class SaTokenConfig {

    @Bean
    public StpLogic getStpLogicJwt() {
        // Sa-Token 整合 jwt (简单模式)
        return new StpLogicJwtForSimple();
    }

    /**
     * 权限接口实现(使用bean注入方便用户替换)
     */
    @Bean
    public StpInterface stpInterface() {
        return new SaPermissionImpl();
    }

    /**
     * Redis 可用时使用 Redis + Caffeine 多级缓存 Dao
     */
    @Bean
    @ConditionalOnProperty(value = "slion.redis.enabled", havingValue = "true", matchIfMissing = true)
    public SaTokenDao saTokenDao() {
        return new PlusSaTokenDao();
    }

    /**
     * Redis 关闭时降级为内存 Dao（仅单机）
     */
    @Bean
    @ConditionalOnProperty(value = "slion.redis.enabled", havingValue = "false")
    public SaTokenDao saTokenDaoLocal() {
        return new SaTokenDaoDefaultImpl();
    }

    /**
     * 异常处理器
     */
    @Bean
    public SaTokenExceptionHandler saTokenExceptionHandler() {
        return new SaTokenExceptionHandler();
    }

}
