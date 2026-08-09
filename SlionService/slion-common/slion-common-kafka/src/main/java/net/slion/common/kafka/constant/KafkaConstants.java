package net.slion.common.kafka.constant;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

/**
 * Kafka 常量
 *
 * @author slion
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class KafkaConstants {

    /**
     * 默认监听容器工厂 Bean 名称，与 {@code @KafkaListener(containerFactory = ...)} 配合使用
     */
    public static final String LISTENER_CONTAINER_FACTORY = "kafkaListenerContainerFactory";

}
