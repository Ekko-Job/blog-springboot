package com.ekko.mq2.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * RabbitMQExchangeTypeEnum
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@Getter
@AllArgsConstructor
public enum RabbitMQExchangeTypeEnum {

    DIRECT,
    FANOUT,
    TOPIC,
    HEADERS;

}
