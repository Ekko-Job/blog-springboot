package com.ekko.neex.mq;// package com.mq;
//
// import org.springframework.amqp.core.Binding;
// import org.springframework.amqp.core.BindingBuilder;
// import org.springframework.amqp.core.DirectExchange;
// import org.springframework.amqp.core.Queue;
// import org.springframework.amqp.core.QueueBuilder;
// import org.springframework.context.annotation.Bean;
// import org.springframework.context.annotation.Configuration;
//
// /**
//  * RabbitConfig
//  *
//  * @author Ekko
//  * @date 2025-04-17
//  * @email ekko.zhang@unionftech.com
//  */
// @Configuration
// public class RabbitConfig {
//
//     public static final String DELAY_QUEUE_1 = "delay_queue_1";
//     public static final String DELAY_QUEUE_2 = "delay_queue_2";
//     public static final String DELAY_QUEUE_3 = "delay_queue_3";
//     public static final String DELAY_QUEUE_4 = "delay_queue_4";
//     public static final String DELAY_QUEUE_5 = "delay_queue_5";
//     @Bean
//     public Queue DELAY_QUEUE_1() {
//         return QueueBuilder.durable(DELAY_QUEUE_1)
//                 .withArgument("x-dead-letter-exchange", DELAY_EXCHANGE_NAME)
//                 .withArgument("x-dead-letter-routing-key", DELAY_PROCESS_QUEUE_NAME)
//                 .withArgument("x-message-ttl", 5000)
//                 .build();
//     }
//     @Bean
//     public Queue DELAY_QUEUE_2() {
//         return QueueBuilder.durable(DELAY_QUEUE_2)
//                 .withArgument("x-dead-letter-exchange", DELAY_EXCHANGE_NAME)
//                 .withArgument("x-dead-letter-routing-key", DELAY_PROCESS_QUEUE_NAME)
//                 .withArgument("x-message-ttl", 15000)
//                 .build();
//     }
//     @Bean
//     public Queue DELAY_QUEUE_3() {
//         return QueueBuilder.durable(DELAY_QUEUE_3)
//                 .withArgument("x-dead-letter-exchange", DELAY_EXCHANGE_NAME)
//                 .withArgument("x-dead-letter-routing-key", DELAY_PROCESS_QUEUE_NAME)
//                 .withArgument("x-message-ttl", 23000)
//                 .build();
//     }
//     @Bean
//     public Queue DELAY_QUEUE_4() {
//         return QueueBuilder.durable(DELAY_QUEUE_4)
//                 .withArgument("x-dead-letter-exchange", DELAY_EXCHANGE_NAME)
//                 .withArgument("x-dead-letter-routing-key", DELAY_PROCESS_QUEUE_NAME)
//                 .withArgument("x-message-ttl", 30000)
//                 .build();
//     }
//     @Bean
//     public Queue DELAY_QUEUE_5() {
//         return QueueBuilder.durable(DELAY_QUEUE_5)
//                 .withArgument("x-dead-letter-exchange", DELAY_EXCHANGE_NAME)
//                 .withArgument("x-dead-letter-routing-key", DELAY_PROCESS_QUEUE_NAME)
//                 .withArgument("x-message-ttl", 40000)
//                 .build();
//     }
//
//     public static final String DELAY_EXCHANGE_NAME = "delay_exchange"; // DLX
//     public static final String DELAY_PROCESS_QUEUE_NAME = "delay_process_queue";// 实际消费队列
//     // 创建实际消费队列
//     @Bean
//     public Queue delayProcessQueue() {
//         return QueueBuilder.durable(DELAY_PROCESS_QUEUE_NAME).build();
//     }
//     // 创建死信交换机
//     @Bean
//     public DirectExchange delayExchange() {
//         return new DirectExchange(DELAY_EXCHANGE_NAME);
//     }
//     // 绑定实际消费队列到死信交换机
//     @Bean
//     public Binding dlxBinding() {
//         return BindingBuilder.bind(delayProcessQueue())
//                 .to(delayExchange())
//                 .with(DELAY_PROCESS_QUEUE_NAME);
//     }
//
// }
//
