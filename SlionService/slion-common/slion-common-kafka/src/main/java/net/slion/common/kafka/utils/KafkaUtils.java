package net.slion.common.kafka.utils;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.slion.common.core.utils.SpringUtils;
import net.slion.common.json.utils.JsonUtils;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;

import java.util.concurrent.CompletableFuture;

/**
 * Kafka 工具类
 *
 * @author slion
 */
@Slf4j
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class KafkaUtils {

    private static final Boolean KAFKA_ENABLED = SpringUtils.getProperty("kafka.enabled", Boolean.class, false);

    /**
     * 是否启用 Kafka
     */
    public static boolean isEnable() {
        return Boolean.TRUE.equals(KAFKA_ENABLED);
    }

    /**
     * 发送消息（无 key）
     *
     * @param topic   主题
     * @param message 消息内容
     */
    public static void send(String topic, String message) {
        if (!isEnable()) {
            return;
        }
        getTemplate().send(topic, message);
    }

    /**
     * 发送消息（带 key，相同 key 路由到同一分区）
     *
     * @param topic   主题
     * @param key     消息 key
     * @param message 消息内容
     */
    public static void send(String topic, String key, String message) {
        if (!isEnable()) {
            return;
        }
        getTemplate().send(topic, key, message);
    }

    /**
     * 发送对象消息（序列化为 JSON）
     *
     * @param topic  主题
     * @param object 消息对象
     */
    public static void sendObject(String topic, Object object) {
        send(topic, JsonUtils.toJsonString(object));
    }

    /**
     * 发送对象消息（带 key，序列化为 JSON）
     *
     * @param topic  主题
     * @param key    消息 key
     * @param object 消息对象
     */
    public static void sendObject(String topic, String key, Object object) {
        send(topic, key, JsonUtils.toJsonString(object));
    }

    /**
     * 异步发送消息
     *
     * @param topic   主题
     * @param message 消息内容
     * @return 发送结果 Future
     */
    public static CompletableFuture<SendResult<String, String>> sendAsync(String topic, String message) {
        if (!isEnable()) {
            return CompletableFuture.completedFuture(null);
        }
        return getTemplate().send(topic, message);
    }

    /**
     * 异步发送消息（带 key）
     *
     * @param topic   主题
     * @param key     消息 key
     * @param message 消息内容
     * @return 发送结果 Future
     */
    public static CompletableFuture<SendResult<String, String>> sendAsync(String topic, String key, String message) {
        if (!isEnable()) {
            return CompletableFuture.completedFuture(null);
        }
        return getTemplate().send(topic, key, message);
    }

    private static KafkaTemplate<String, String> getTemplate() {
        return SpringUtils.getBean(KafkaTemplate.class);
    }

}
