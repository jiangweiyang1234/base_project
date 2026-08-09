package net.slion.disruptor.core;

import lombok.Data;

/**
 * 通用业务事件载体
 */
@Data
public class BusinessEvent {

    private String topic;
    private Object payload;
    private long timestamp;

    public void clear() {
        this.topic = null;
        this.payload = null;
        this.timestamp = 0L;
    }
}
