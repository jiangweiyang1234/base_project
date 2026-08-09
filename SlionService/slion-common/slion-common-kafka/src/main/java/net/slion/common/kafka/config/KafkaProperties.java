package net.slion.common.kafka.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Kafka 配置项
 *
 * @author slion
 */
@Data
@ConfigurationProperties("kafka")
public class KafkaProperties {

    /**
     * 是否启用 Kafka
     */
    private Boolean enabled = false;

    /**
     * Kafka 集群地址，多个以逗号分隔
     */
    private String bootstrapServers = "localhost:9092";

    /**
     * 客户端标识
     */
    private String clientId;

    private final Producer producer = new Producer();

    private final Consumer consumer = new Consumer();

    @Data
    public static class Producer {

        /**
         * 应答级别：0 不等待确认，1 leader 确认，all 所有副本确认
         */
        private String acks = "all";

        /**
         * 发送失败重试次数
         */
        private Integer retries = 3;

        /**
         * 批量发送大小（字节）
         */
        private Integer batchSize = 16384;

        /**
         * 发送缓冲内存（字节）
         */
        private Long bufferMemory = 33554432L;

        /**
         * 消息 linger 时间（毫秒）
         */
        private Integer lingerMs = 0;
    }

    @Data
    public static class Consumer {

        /**
         * 消费者组 ID
         */
        private String groupId = "slion-group";

        /**
         * 无 offset 时的起始位置：earliest / latest
         */
        private String autoOffsetReset = "latest";

        /**
         * 是否自动提交 offset
         */
        private Boolean enableAutoCommit = true;

        /**
         * 自动提交 offset 间隔（毫秒）
         */
        private Integer autoCommitIntervalMs = 5000;

        /**
         * 单次 poll 最大记录数
         */
        private Integer maxPollRecords = 500;

        /**
         * 监听容器并发数
         */
        private Integer concurrency = 1;
    }

}
