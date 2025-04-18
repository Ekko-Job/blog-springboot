package com.ekko.mq2.config;

import com.ekko.mq2.enums.RabbitMQQueueDefine;
import com.ekko.mq2.enums.RabbitMQRoutingKeyDefine;
import com.ekko.mq2.enums.RabbitMQRoutingKeyDefineInterface;

/**
 * RabbitSender
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
public interface RabbitSender {

    void sendMessage(String exchange, String routingKey, Object msg, boolean ignore);

    void sendMessage(RabbitMQRoutingKeyDefine define, String msg, boolean ignore);

    void sendMessageTtl(RabbitMQQueueDefine rabbitMQQueueDefine, Object msg, boolean ignore);

    void sendMessage(RabbitMQRoutingKeyDefineInterface define, String msg, boolean ignore);
}
