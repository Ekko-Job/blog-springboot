package com.ekko.mq;

import com.ekko.mq2.config.RabbitSender;
import com.ekko.mq2.enums.RabbitMQRoutingKeyDefine;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * RabbitMQTest
 *
 * @author Ekko
 * @date 2025-04-18
 * @email ekko.zhang@unionftech.com
 */
@SpringBootTest
public class RabbitMQTest {

    private static final Logger logger = LoggerFactory.getLogger(RabbitMQTest.class);

    @Autowired
    RabbitSender rabbitSender;

    @Test
    public void MQ2() throws InterruptedException {

        rabbitSender.sendMessage(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY_5_SECONDS, "  |消息DELAY_ROUTING_KEY_5_SECONDS  | ", false);
        rabbitSender.sendMessage(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY_15_SECONDS, " |消息DELAY_ROUTING_KEY_15_SECONDS | ", false);
        rabbitSender.sendMessage(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY_30_SECONDS, " |消息DELAY_ROUTING_KEY_30_SECONDS | ", false);
        rabbitSender.sendMessage(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY_45_SECONDS, " |消息DELAY_ROUTING_KEY_45_SECONDS | ", false);
        rabbitSender.sendMessage(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY_60_SECONDS, " |消息DELAY_ROUTING_KEY_60_SECONDS | ", false);
        Thread.sleep(10000);
        rabbitSender.sendMessage(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY_5_SECONDS, "  |消息DELAY_ROUTING_KEY_5_SECONDS  | ", false);


        System.out.println("=================================================================");
    }

}

