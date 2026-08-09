package net.slion.workflow.config;

import net.slion.workflow.common.ConditionalOnEnable;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * warmFlow配置
 *
 * @author may
 */
@ConditionalOnEnable
@Configuration
@EnableConfigurationProperties(WorkflowFeatureProperties.class)
public class WarmFlowConfig {

}

