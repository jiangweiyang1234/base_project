package net.slion.workflow.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * 工作流增强开关
 */
@Data
@ConfigurationProperties(prefix = "warm-flow.features")
public class WorkflowFeatureProperties {

    /** 允许撤销已发起流程 */
    private boolean cancelEnabled = true;

    /** 允许转办 */
    private boolean transferEnabled = true;

    /** 允许委派 */
    private boolean delegateEnabled = true;

    /** 抄送 */
    private boolean copyEnabled = true;

    /** SpEL 规则管理（生产建议关闭或严格授权） */
    private boolean spelManageEnabled = true;
}
