package net.slion.disruptor.core;

/**
 * 业务事件处理器
 */
@FunctionalInterface
public interface BusinessEventHandler {

    void onEvent(BusinessEvent event) throws Exception;
}
