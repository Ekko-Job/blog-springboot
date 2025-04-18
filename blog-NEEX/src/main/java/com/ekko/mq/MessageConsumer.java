package com.ekko.mq;// package com.mq;
//
// import com.rabbitmq.client.Channel;
// import org.slf4j.Logger;
// import org.slf4j.LoggerFactory;
// import org.springframework.amqp.core.Message;
// import org.springframework.amqp.rabbit.annotation.RabbitListener;
// import org.springframework.stereotype.Service;
//
// import java.io.IOException;
// import java.io.UnsupportedEncodingException;
//
// /**
//  * MessageConsumer
//  *
//  * @author Ekko
//  * @date 2025-04-17
//  * @email ekko.zhang@unionftech.com
//  */
// @Service
// public class MessageConsumer {
//
//     private static final Logger logger = LoggerFactory.getLogger(MessageConsumer.class);
//
//     @RabbitListener(queues = "delay_process_queue")
//     public void receiveMessage(Message message,Channel channel) throws UnsupportedEncodingException {
//         //
//         byte[] body = message.getBody();
//         String messageStr = new String(body, "UTF-8");
//
//         logger.info("delay_queue_1_1  队列开始消费: " + messageStr);
//
//         try {
//             channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
//         } catch (IOException e) {
//             throw new RuntimeException(e);
//         }
//     }
//
//     // @RabbitListener(queues = "delay_queue_1")
//     // public void DELAY_QUEUE_1(Message message,Channel channel) throws UnsupportedEncodingException {
//     //     byte[] body = message.getBody();
//     //     String messageStr = new String(body, "UTF-8");
//     //
//     //     System.out.println("delay_queue_1  队列开始消费: " + messageStr);
//     //
//     //     try {
//     //         channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
//     //     } catch (IOException e) {
//     //         throw new RuntimeException(e);
//     //     }
//     // }
//     //
//     // @RabbitListener(queues = "delay_queue_2")
//     // public void DELAY_QUEUE_2(Message message,Channel channel) throws UnsupportedEncodingException {
//     //     byte[] body = message.getBody();
//     //     String messageStr = new String(body, "UTF-8");
//     //
//     //     System.out.println("delay_queue_2  队列开始消费: " + messageStr);
//     //
//     //     try {
//     //         channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
//     //     } catch (IOException e) {
//     //         throw new RuntimeException(e);
//     //     }
//     // }
//     // @RabbitListener(queues = "delay_queue_3")
//     // public void DELAY_QUEUE_3(Message message,Channel channel) throws UnsupportedEncodingException {
//     //     byte[] body = message.getBody();
//     //     String messageStr = new String(body, "UTF-8");
//     //
//     //     System.out.println("delay_queue_3  队列开始消费: " + messageStr);
//     //
//     //     try {
//     //         channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
//     //     } catch (IOException e) {
//     //         throw new RuntimeException(e);
//     //     }
//     // }
//     // @RabbitListener(queues = "delay_queue_4")
//     // public void DELAY_QUEUE_4(Message message,Channel channel) throws UnsupportedEncodingException {
//     //     byte[] body = message.getBody();
//     //     String messageStr = new String(body, "UTF-8");
//     //
//     //     System.out.println("delay_queue_4  队列开始消费: " + messageStr);
//     //
//     //     try {
//     //         channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
//     //     } catch (IOException e) {
//     //         throw new RuntimeException(e);
//     //     }
//     // }
//     // @RabbitListener(queues = "delay_queue_5")
//     // public void DELAY_QUEUE_5(Message message,Channel channel) throws UnsupportedEncodingException {
//     //     byte[] body = message.getBody();
//     //     String messageStr = new String(body, "UTF-8");
//     //
//     //     System.out.println("delay_queue_5  队列开始消费: " + messageStr);
//     //
//     //     try {
//     //         channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
//     //     } catch (IOException e) {
//     //         throw new RuntimeException(e);
//     //     }
//     // }
//
// }
//
