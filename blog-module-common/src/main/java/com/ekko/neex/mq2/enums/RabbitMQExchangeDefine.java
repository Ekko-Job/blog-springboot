package com.ekko.neex.mq2.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * RabbitMQExchangeDefine
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@Getter
@AllArgsConstructor
public enum RabbitMQExchangeDefine {

    DELAY_EXCHANGE(RabbitMQExchangeTypeEnum.DIRECT, "delay_exchange", false),

    ;

    private final RabbitMQExchangeTypeEnum exchangeType;
    private final String exchangeName;
    private final Boolean isStitchingEnvironment;

}
