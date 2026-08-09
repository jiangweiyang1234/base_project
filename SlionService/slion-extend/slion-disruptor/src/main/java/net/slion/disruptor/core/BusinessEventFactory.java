package net.slion.disruptor.core;

import com.lmax.disruptor.EventFactory;

public class BusinessEventFactory implements EventFactory<BusinessEvent> {

    @Override
    public BusinessEvent newInstance() {
        return new BusinessEvent();
    }
}
