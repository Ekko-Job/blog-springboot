package com.ekko.neex.mq2.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * RabbitMQQueueDefine
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@Getter
@AllArgsConstructor
public enum RabbitMQQueueDefine {

    DELAY_PROCESS_QUEUE(RabbitMQExchangeDefine.DELAY_EXCHANGE, "delay_process_queue", false, new String[]{"delay_routing_key"}),
    DELAY_QUEUE_5_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, "delay_queue_5_seconds", false, new String[]{"routing_key_5_seconds"}, 5000),
    DELAY_QUEUE_15_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, "delay_queue_15_seconds", false, new String[]{"routing_key_15_seconds"}, 15000),
    DELAY_QUEUE_30_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, "delay_queue_30_seconds", false, new String[]{"routing_key_30_seconds"}, 30000),
    DELAY_QUEUE_45_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, "delay_queue_45_seconds", false, new String[]{"routing_key_45_seconds"}, 45000),
    DELAY_QUEUE_60_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, "delay_queue_60_seconds", false, new String[]{"routing_key_60_seconds"}, 60000),

    ;

    private final RabbitMQExchangeDefine exchangeDefine;
    private final String queueName;
    private final Boolean isStitchingEnvironment;
    private final String[] routingKeys;
    private final Integer ttl;

    RabbitMQQueueDefine(RabbitMQExchangeDefine exchangeDefine, String queueName, Boolean isStitchingEnvironment, String[] routingKeys) {
        this.exchangeDefine = exchangeDefine;
        this.queueName = queueName;
        this.isStitchingEnvironment = isStitchingEnvironment;
        this.routingKeys = routingKeys;
        this.ttl = null;
    }

}
