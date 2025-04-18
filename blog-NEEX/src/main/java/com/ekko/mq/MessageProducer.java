package com.ekko.mq;// package com.mq;
//
// import org.springframework.amqp.rabbit.core.RabbitTemplate;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Service;
//
// /**
//  * MessageProducer
//  *
//  * @author Ekko
//  * @date 2025-04-17
//  * @email ekko.zhang@unionftech.com
//  */
// @Service
// public class MessageProducer {
//
//     @Autowired
//     private RabbitTemplate rabbitTemplate;
//
//     public void sendMessageWithTTL(String queue, String message) {
//         rabbitTemplate.convertAndSend(queue, message
//                 // , msg -> {
//                 //     msg.getMessageProperties().setExpiration(String.valueOf(ttl));
//                 //     System.out.println(queue + message + msg);
//                 //     return msg;
//                 // }
//         );
//     }
// }
