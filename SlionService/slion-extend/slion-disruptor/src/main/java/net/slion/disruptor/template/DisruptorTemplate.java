package net.slion.disruptor.template;

import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.dsl.Disruptor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.slion.disruptor.core.BusinessEvent;

/**
 * Disruptor 发布模板
 */
@Slf4j
@RequiredArgsConstructor
public class DisruptorTemplate {

    private final Disruptor<BusinessEvent> disruptor;

    public void publish(String topic, Object payload) {
        RingBuffer<BusinessEvent> ringBuffer = disruptor.getRingBuffer();
        long sequence = ringBuffer.next();
        try {
            BusinessEvent event = ringBuffer.get(sequence);
            event.setTopic(topic);
            event.setPayload(payload);
            event.setTimestamp(System.currentTimeMillis());
        } finally {
            ringBuffer.publish(sequence);
        }
    }

    public void shutdown() {
        disruptor.shutdown();
    }
}
