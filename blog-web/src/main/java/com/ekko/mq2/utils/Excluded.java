package com.ekko.mq2.utils;

import lombok.AllArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * Excluded
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@AllArgsConstructor
public class Excluded {
    static List<String> EXCLUDE_EXCHANGE = new ArrayList<>();
    static List<String> EXCLUDE_QUEUE = new ArrayList<>();

    static {
        // EXCLUDE_EXCHANGE.add(RabbitMQExchangeDefine.UNIONF_FANOUT_TICKETS.getExchangeName());
    }

    static {
        // EXCLUDE_QUEUE.add(RabbitMQQueueDefine.COMMISSION_TICKET_CLOSED_ACTIVITY.getQueueName());
    }

}

