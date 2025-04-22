package com.ekko.neex.mq2.enums;

/**
 * RabbitMQRoutingKeyDefineInterface
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
public interface RabbitMQRoutingKeyDefineInterface {

    RabbitMQExchangeDefine getRabbitMQExchange();

    RabbitMQQueueDefine getRabbitMQQueue();

    String getRoutingKey();

}
