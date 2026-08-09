package net.slion.common.kafka.handler;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import org.springframework.kafka.support.ProducerListener;

/**
 * Kafka 消息发送结果监听
 *
 * @author slion
 */
@Slf4j
public class KafkaSendResultHandler implements ProducerListener<String, String> {

    @Override
    public void onSuccess(ProducerRecord<String, String> producerRecord, RecordMetadata recordMetadata) {
        log.debug("[kafka] send success topic={} partition={} offset={}",
            recordMetadata.topic(), recordMetadata.partition(), recordMetadata.offset());
    }

    @Override
    public void onError(ProducerRecord<String, String> producerRecord, RecordMetadata recordMetadata, Exception exception) {
        log.error("[kafka] send failed topic={} key={}", producerRecord.topic(), producerRecord.key(), exception);
    }

}
