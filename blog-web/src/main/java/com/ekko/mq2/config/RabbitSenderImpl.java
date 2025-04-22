// package com.ekko.mq2.config;
//
// import cn.hutool.json.JSONUtil;
// import com.ekko.mq2.enums.RabbitMQQueueDefine;
// import com.ekko.mq2.enums.RabbitMQRoutingKeyDefine;
// import com.ekko.mq2.enums.RabbitMQRoutingKeyDefineInterface;
// import com.ekko.mq2.utils.MerchantsUtil;
// import lombok.AllArgsConstructor;
// import lombok.extern.slf4j.Slf4j;
// import org.slf4j.Logger;
// import org.slf4j.LoggerFactory;
// import org.springframework.amqp.core.Message;
// import org.springframework.amqp.rabbit.connection.CorrelationData;
// import org.springframework.amqp.rabbit.core.RabbitTemplate;
// import org.springframework.stereotype.Component;
//
// /**
//  * RabbitSenderImpl
//  *
//  * @author Ekko
//  * @date 2025-04-17
//  * @email ekko.zhang@unionftech.com
//  */
// @Slf4j
// @Component
// @AllArgsConstructor
// public class RabbitSenderImpl implements RabbitSender, RabbitTemplate.ConfirmCallback, RabbitTemplate.ReturnCallback {
//
//     private static final Logger logger = LoggerFactory.getLogger(RabbitSenderImpl.class);
//
//     private final MerchantsUtil merchantsUtil;
//
//     private final RabbitTemplate rabbitTemplate;
//
//     @Override
//     public void sendMessage(String exchange, String routingKey, Object msg, boolean ignore) {
//         rabbitTemplate.setMandatory(true);
//         rabbitTemplate.setConfirmCallback(this);
//         rabbitTemplate.setReturnCallback(this);
//         rabbitTemplate.convertAndSend(exchange, routingKey, msg);
//     }
//
//     @Override
//     public void sendMessage(RabbitMQRoutingKeyDefine define, String msg, boolean ignore) {
//         sendMessage(merchantsUtil.splitExchange(define.getRabbitMQExchange().getExchangeName()), define.getRoutingKey(), msg, ignore);
//     }
//
//     @Override
//     public void sendMessageTtl(RabbitMQQueueDefine rabbitMQQueueDefine, Object msg, boolean ignore) {
//         String exchangeName = rabbitMQQueueDefine.getExchangeDefine().getExchangeName();
//         sendMessage(merchantsUtil.splitExchange(exchangeName), rabbitMQQueueDefine.getRoutingKeys()[0], msg, ignore);
//     }
//
//     @Override
//     public void sendMessage(RabbitMQRoutingKeyDefineInterface defineInterface, String msg, boolean ignore) {
//         RabbitMQQueueDefine queueDefine = defineInterface.getRabbitMQQueue();
//         String exchangeName = queueDefine.getExchangeDefine().getExchangeName();
//         String queueName = queueDefine.getQueueName();
//         sendMessage(merchantsUtil.splitExchange(exchangeName), defineInterface.getRoutingKey(), msg, ignore);
//     }
//
//
//     @Override
//     public void confirm(CorrelationData correlationData, boolean ack, String cause) {
//         logger.info("Rabbit 消息确认回调 - 是否成功：{}，原因：{}", ack ? "成功" : "失败", cause == null ? "无" : cause);
//         logger.info("Rabbit 消息确认回调 - 消息元数据：{}", JSONUtil.toJsonStr(correlationData));
//     }
//
//     @Override
//     public void returnedMessage(Message message, int replyCode, String replyText, String exchange, String routingKey) {
//         logger.info("Rabbit 消息返回回调 - 消息内容：{}，回复码：{}，原因：{}，交换机：{}，路由键：{}", JSONUtil.toJsonStr(message), replyCode, replyText, exchange, routingKey);
//     }
//
// }
