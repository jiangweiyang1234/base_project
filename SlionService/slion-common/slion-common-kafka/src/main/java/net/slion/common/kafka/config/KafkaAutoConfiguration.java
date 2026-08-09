package net.slion.common.kafka.config;

import lombok.extern.slf4j.Slf4j;
import net.slion.common.core.utils.StringUtils;
import net.slion.common.kafka.handler.KafkaSendResultHandler;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.config.ConcurrentKafkaListenerContainerFactory;
import org.springframework.kafka.core.ConsumerFactory;
import org.springframework.kafka.core.DefaultKafkaConsumerFactory;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.core.ProducerFactory;
import org.springframework.kafka.listener.CommonErrorHandler;
import org.springframework.kafka.listener.DefaultErrorHandler;
import org.springframework.util.backoff.FixedBackOff;

import java.util.HashMap;
import java.util.Map;

/**
 * Kafka 自动装配
 *
 * @author slion
 */
@Slf4j
@AutoConfiguration
@ConditionalOnProperty(value = "kafka.enabled", havingValue = "true")
@EnableConfigurationProperties(KafkaProperties.class)
@EnableKafka
public class KafkaAutoConfiguration {

    @Bean
    public ProducerFactory<String, String> kafkaProducerFactory(KafkaProperties properties) {
        Map<String, Object> config = new HashMap<>();
        config.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, properties.getBootstrapServers());
        config.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        config.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        config.put(ProducerConfig.ACKS_CONFIG, properties.getProducer().getAcks());
        config.put(ProducerConfig.RETRIES_CONFIG, properties.getProducer().getRetries());
        config.put(ProducerConfig.BATCH_SIZE_CONFIG, properties.getProducer().getBatchSize());
        config.put(ProducerConfig.BUFFER_MEMORY_CONFIG, properties.getProducer().getBufferMemory());
        config.put(ProducerConfig.LINGER_MS_CONFIG, properties.getProducer().getLingerMs());
        if (StringUtils.isNotBlank(properties.getClientId())) {
            config.put(ProducerConfig.CLIENT_ID_CONFIG, properties.getClientId());
        }
        log.info("[kafka] producer initialized, bootstrapServers={}", properties.getBootstrapServers());
        return new DefaultKafkaProducerFactory<>(config);
    }

    @Bean
    public KafkaTemplate<String, String> kafkaTemplate(ProducerFactory<String, String> kafkaProducerFactory,
                                                       KafkaSendResultHandler sendResultHandler) {
        KafkaTemplate<String, String> template = new KafkaTemplate<>(kafkaProducerFactory);
        template.setProducerListener(sendResultHandler);
        return template;
    }

    @Bean
    public ConsumerFactory<String, String> kafkaConsumerFactory(KafkaProperties properties) {
        Map<String, Object> config = new HashMap<>();
        config.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, properties.getBootstrapServers());
        config.put(ConsumerConfig.GROUP_ID_CONFIG, properties.getConsumer().getGroupId());
        config.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        config.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, properties.getConsumer().getAutoOffsetReset());
        config.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, properties.getConsumer().getEnableAutoCommit());
        config.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, properties.getConsumer().getAutoCommitIntervalMs());
        config.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, properties.getConsumer().getMaxPollRecords());
        log.info("[kafka] consumer initialized, groupId={}", properties.getConsumer().getGroupId());
        return new DefaultKafkaConsumerFactory<>(config);
    }

    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, String> kafkaListenerContainerFactory(
        ConsumerFactory<String, String> kafkaConsumerFactory,
        KafkaProperties properties) {
        ConcurrentKafkaListenerContainerFactory<String, String> factory =
            new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(kafkaConsumerFactory);
        factory.setConcurrency(properties.getConsumer().getConcurrency());
        factory.setCommonErrorHandler(kafkaErrorHandler());
        return factory;
    }

    @Bean
    public CommonErrorHandler kafkaErrorHandler() {
        // 消费失败间隔 1s 重试，最多 3 次
        return new DefaultErrorHandler(new FixedBackOff(1000L, 3L));
    }

    @Bean
    public KafkaSendResultHandler kafkaSendResultHandler() {
        return new KafkaSendResultHandler();
    }

}
