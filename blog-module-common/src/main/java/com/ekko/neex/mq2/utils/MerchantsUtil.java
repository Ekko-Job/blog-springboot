package com.ekko.neex.mq2.utils;

import lombok.AllArgsConstructor;

/**
 * MerchantsUtil
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@AllArgsConstructor
public class MerchantsUtil {

    private String merchantsId;

    public String splitExchange(String name) {
        return Excluded.EXCLUDE_EXCHANGE.contains(name) ? name : name + "_" + merchantsId;
    }

    public String splitExchange(String name, String merchants) {
        return Excluded.EXCLUDE_EXCHANGE.contains(name) ? name : name + "_" + merchants;
    }

    public String splitQueue(String name) {
        return Excluded.EXCLUDE_QUEUE.contains(name) ? name : name + "_" + merchantsId;
    }

}
