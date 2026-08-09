package net.slion.disruptor.config;

import com.lmax.disruptor.BlockingWaitStrategy;
import com.lmax.disruptor.BusySpinWaitStrategy;
import com.lmax.disruptor.SleepingWaitStrategy;
import com.lmax.disruptor.WaitStrategy;
import com.lmax.disruptor.YieldingWaitStrategy;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.ProducerType;
import jakarta.annotation.PreDestroy;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.slion.disruptor.core.BusinessEvent;
import net.slion.disruptor.core.BusinessEventFactory;
import net.slion.disruptor.core.BusinessEventHandler;
import net.slion.disruptor.template.DisruptorTemplate;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

import java.util.List;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Disruptor 自动装配（disruptor.enabled=true）
 */
@Slf4j
@AutoConfiguration
@EnableConfigurationProperties(DisruptorProperties.class)
@ConditionalOnProperty(prefix = "disruptor", name = "enabled", havingValue = "true")
@RequiredArgsConstructor
public class DisruptorAutoConfiguration {

    private final DisruptorProperties properties;
    private DisruptorTemplate disruptorTemplate;

    @Bean(destroyMethod = "shutdown")
    public DisruptorTemplate disruptorTemplate(ObjectProvider<BusinessEventHandler> handlers) {
        WaitStrategy waitStrategy = resolveWaitStrategy(properties.getWaitStrategy());
        ThreadFactory threadFactory = new ThreadFactory() {
            private final AtomicInteger idx = new AtomicInteger(1);

            @Override
            public Thread newThread(Runnable r) {
                Thread t = new Thread(r);
                t.setName(properties.getThreadNamePrefix() + idx.getAndIncrement());
                t.setDaemon(true);
                return t;
            }
        };
        Disruptor<BusinessEvent> disruptor = new Disruptor<>(
            new BusinessEventFactory(),
            properties.getBufferSize(),
            threadFactory,
            ProducerType.MULTI,
            waitStrategy
        );
        List<BusinessEventHandler> handlerList = handlers.orderedStream().toList();
        if (handlerList.isEmpty()) {
            disruptor.handleEventsWith((event, sequence, endOfBatch) ->
                log.debug("disruptor event topic={} payload={}", event.getTopic(), event.getPayload()));
        } else {
            disruptor.handleEventsWith((event, sequence, endOfBatch) -> {
                for (BusinessEventHandler handler : handlerList) {
                    handler.onEvent(event);
                }
                event.clear();
            });
        }
        disruptor.start();
        this.disruptorTemplate = new DisruptorTemplate(disruptor);
        log.info("Disruptor started bufferSize={} waitStrategy={}", properties.getBufferSize(), properties.getWaitStrategy());
        return this.disruptorTemplate;
    }

    @PreDestroy
    public void destroy() {
        if (disruptorTemplate != null) {
            disruptorTemplate.shutdown();
        }
    }

    private WaitStrategy resolveWaitStrategy(String name) {
        if (name == null) {
            return new BlockingWaitStrategy();
        }
        return switch (name.toLowerCase()) {
            case "yielding" -> new YieldingWaitStrategy();
            case "sleeping" -> new SleepingWaitStrategy();
            case "busyspin" -> new BusySpinWaitStrategy();
            default -> new BlockingWaitStrategy();
        };
    }
}
