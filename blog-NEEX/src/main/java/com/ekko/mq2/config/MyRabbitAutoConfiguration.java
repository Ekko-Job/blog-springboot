package com.ekko.mq2.config;

import com.ekko.mq2.enums.RabbitMQExchangeDefine;
import com.ekko.mq2.enums.RabbitMQExchangeTypeEnum;
import com.ekko.mq2.enums.RabbitMQQueueDefine;
import com.ekko.mq2.enums.RabbitMQRoutingKeyDefine;
import com.ekko.mq2.utils.MerchantsUtil;
import com.rabbitmq.client.ConnectionFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.AcknowledgeMode;
import org.springframework.amqp.core.AmqpAdmin;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Exchange;
import org.springframework.amqp.core.FanoutExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.amqp.rabbit.config.SimpleRabbitListenerContainerFactory;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * MyRabbitAutoConfiguration
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@Slf4j
@Configuration
@ConditionalOnProperty(name = "mq.server", havingValue = "rabbitmq", matchIfMissing = true)
public class MyRabbitAutoConfiguration {
    @Value("${spring.profiles.active}")
    private String active;
    @Value("${spring.rabbitmq.ssl.enable:false}")
    private Boolean enable;
    @Value("${spring.rabbitmq.ssl.skipTls:false}")
    private Boolean skipTls;
    @Value("${marketing.merchantsId:1}")
    private String merchantsId;

    private final RabbitProperties rabbitProperties;

    public MyRabbitAutoConfiguration(RabbitProperties rabbitProperties) {
        this.rabbitProperties = rabbitProperties;
    }

    @Bean
    public AmqpAdmin amqpAdmin(CachingConnectionFactory connectionFactory) {
        AmqpAdmin amqpAdmin = new RabbitAdmin(connectionFactory);

        for (RabbitMQExchangeTypeEnum exchangeTypeEnum : RabbitMQExchangeTypeEnum.values()) {
            List<RabbitMQExchangeDefine> exchangeDefines = Arrays.stream(RabbitMQExchangeDefine.values())
                    .filter(it -> it.getExchangeType().equals(exchangeTypeEnum))
                    .collect(Collectors.toList());

            for (RabbitMQExchangeDefine exchangeDefine : exchangeDefines) {
                String exchangeName = merchantsUtil().splitExchange(exchangeDefine.getExchangeName());

                Exchange exchange = null;
                switch (exchangeTypeEnum) {
                    case DIRECT:
                        exchange = new DirectExchange(exchangeName);
                        break;
                    case FANOUT:
                        exchange = new FanoutExchange(exchangeName);
                        break;
                    case TOPIC:
                        exchange = new TopicExchange(exchangeName);
                        break;
                    default:
                        break;
                }

                amqpAdmin.declareExchange(exchange);

                if (null != exchange) {
                    continue;
                }

                List<RabbitMQQueueDefine> queueDefines = Arrays.stream(RabbitMQQueueDefine.values())
                        .filter(it -> it.getExchangeDefine().equals(exchangeDefine))
                        .collect(Collectors.toList());

                for (RabbitMQQueueDefine queueDefine : queueDefines) {
                    String queueName = merchantsUtil().splitQueue(queueDefine.getQueueName());
                    Queue queue = null;

                    if (queueDefine.getTtl() != null) {

                        Map<String, Object> arguments = new HashMap<>();
                        arguments.put("x-dead-letter-exchange", merchantsUtil().splitExchange(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY.getRabbitMQExchange().getExchangeName()));
                        arguments.put("x-dead-letter-routing-key", merchantsUtil().splitExchange(RabbitMQRoutingKeyDefine.DELAY_ROUTING_KEY.getRoutingKey()));
                        arguments.put("x-message-ttl", queueDefine.getTtl());
                        queue = new Queue(queueName, true, false, false, arguments);
                    } else {
                        queue = new Queue(queueName);
                    }

                    amqpAdmin.declareExchange(exchange);
                    amqpAdmin.declareQueue(queue);

                    if (RabbitMQExchangeTypeEnum.FANOUT.equals(exchangeTypeEnum)) {
                        Binding binding = BindingBuilder.bind(queue).to((FanoutExchange) exchange);
                        amqpAdmin.declareBinding(binding);
                    } else {
                        String[] routingKeys = queueDefine.getRoutingKeys();
                        if (null == routingKeys || routingKeys.length == 0) {
                            continue;
                        }
                        for (String routingKey : routingKeys) {
                            amqpAdmin.declareBinding(BindingBuilder.bind(queue).to(exchange).with(routingKey).noargs());
                        }
                    }
                }
            }
        }

        return amqpAdmin;
    }

    @Bean
    public CachingConnectionFactory connectionFactory() {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setAutomaticRecoveryEnabled(false);
        try {
            factory.setHost(rabbitProperties.getHost());
            factory.setPort(rabbitProperties.getPort());
            factory.setUsername(rabbitProperties.getUsername());
            factory.setPassword(rabbitProperties.getPassword());
            factory.setVirtualHost(rabbitProperties.getVirtualHost());
            // Enable ssl protocol
            if (enable) {
                log.info("RabbitMQ Configuration Skip SSL Tls Check ~");
                factory.useSslProtocol();
            }
        } catch (NoSuchAlgorithmException | KeyManagementException e) {
            log.error("RabbitMQ CachingConnectionFactory init failed.", e);
        }
        CachingConnectionFactory cachingConnectionFactory = new CachingConnectionFactory(factory);
        cachingConnectionFactory.setPublisherConfirms(rabbitProperties.isPublisherConfirms());
        cachingConnectionFactory.setPublisherReturns(rabbitProperties.isPublisherReturns());
        return cachingConnectionFactory;
    }

    @Bean
    public RabbitTemplate rabbitTemplate() {
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory());
        rabbitTemplate.setMessageConverter(new Jackson2JsonMessageConverter());
        return rabbitTemplate;
    }

    @Bean
    public SimpleRabbitListenerContainerFactory listenerContainerFactory() {
        SimpleRabbitListenerContainerFactory simpleRabbitListenerContainerFactory = new SimpleRabbitListenerContainerFactory();
        simpleRabbitListenerContainerFactory.setConnectionFactory(connectionFactory());
        simpleRabbitListenerContainerFactory.setConcurrentConsumers(1);
        simpleRabbitListenerContainerFactory.setMaxConcurrentConsumers(10);
        simpleRabbitListenerContainerFactory.setPrefetchCount(1);
        simpleRabbitListenerContainerFactory.setDefaultRequeueRejected(true);
        simpleRabbitListenerContainerFactory.setAcknowledgeMode(AcknowledgeMode.MANUAL);
        return simpleRabbitListenerContainerFactory;
    }

    @Bean
    @Order(0)
    public MerchantsUtil merchantsUtil() {
        return new MerchantsUtil(merchantsId);
    }
}
