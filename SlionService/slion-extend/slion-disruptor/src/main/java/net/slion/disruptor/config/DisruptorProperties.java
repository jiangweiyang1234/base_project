package net.slion.disruptor.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@ConfigurationProperties(prefix = "disruptor")
public class DisruptorProperties {

    /**
     * 是否启用 Disruptor 模块
     */
    private boolean enabled = false;

    /**
     * RingBuffer 大小，必须为 2 的幂
     */
    private int bufferSize = 1024;

    /**
     * 消费者线程名前缀
     */
    private String threadNamePrefix = "slion-disruptor-";

    /**
     * 等待策略：blocking / yielding / sleeping / busySpin
     */
    private String waitStrategy = "blocking";
}
