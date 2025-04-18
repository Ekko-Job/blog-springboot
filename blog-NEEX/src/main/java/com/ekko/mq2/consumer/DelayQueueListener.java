package com.ekko.mq2.consumer;

import com.rabbitmq.client.Channel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

/**
 * DelayQueueListener
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@Service
public class DelayQueueListener {

    private static final Logger logger = LoggerFactory.getLogger(DelayQueueListener.class);

    @RabbitListener(queues = "#{T(com.mq2.enums.RabbitMQQueueDefine).DELAY_PROCESS_QUEUE.getQueueName()}" + "_" + "${marketing.merchantsId}")
    public void receiveMessage2(Message message, Channel channel) throws UnsupportedEncodingException {
        logger.info("成功接收到死信消息: " + new String(message.getBody(), "UTF-8"));
        logger.info("消息的的来源交换机: " + message.getMessageProperties().getHeaders().get("x-first-death-exchange"));
        logger.info("消息进入的延时队列: " + message.getMessageProperties().getHeaders().get("x-first-death-queue") + "。路由键: " + ((List<String>) ((Map<String, Object>) ((List<?>) message.getMessageProperties().getHeaders().get("x-death")).get(0)).get("routing-keys")).get(0));
        logger.info("消息进入队列的原因: " + message.getMessageProperties().getHeaders().get("x-first-death-reason"));
        logger.info("最终消费的消费队列: " + message.getMessageProperties().getConsumerQueue() + "。路由键: " + message.getMessageProperties().getReceivedRoutingKey());
        logger.info("============================================================================================================");
        System.out.println();


        try {
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

