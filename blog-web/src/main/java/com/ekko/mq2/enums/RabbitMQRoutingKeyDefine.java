package com.ekko.mq2.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * RabbitMQRoutingKeyDefine
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@Getter
@AllArgsConstructor
public enum RabbitMQRoutingKeyDefine {

    DELAY_ROUTING_KEY(RabbitMQExchangeDefine.DELAY_EXCHANGE, RabbitMQQueueDefine.DELAY_PROCESS_QUEUE, "delay_routing_key"),
    DELAY_ROUTING_KEY_5_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, RabbitMQQueueDefine.DELAY_QUEUE_5_SECONDS, "routing_key_5_seconds"),
    DELAY_ROUTING_KEY_15_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, RabbitMQQueueDefine.DELAY_QUEUE_15_SECONDS, "routing_key_15_seconds"),
    DELAY_ROUTING_KEY_30_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, RabbitMQQueueDefine.DELAY_QUEUE_30_SECONDS, "routing_key_30_seconds"),
    DELAY_ROUTING_KEY_45_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, RabbitMQQueueDefine.DELAY_QUEUE_45_SECONDS, "routing_key_45_seconds"),
    DELAY_ROUTING_KEY_60_SECONDS(RabbitMQExchangeDefine.DELAY_EXCHANGE, RabbitMQQueueDefine.DELAY_QUEUE_60_SECONDS, "routing_key_60_seconds"),

    ;

    private final RabbitMQExchangeDefine rabbitMQExchange;
    private final RabbitMQQueueDefine rabbitMQQueue;
    private final String routingKey;
}
