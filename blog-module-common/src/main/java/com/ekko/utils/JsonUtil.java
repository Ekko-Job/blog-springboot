package com.ekko.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.Map;

/**
 * JsonUtil
 *
 * @author Ekko
 * @date 2025-04-25
 * @email ekko.zhang@unionftech.com
 */
@Slf4j
public class JsonUtil {

    private static final ObjectMapper INSTANCE = new ObjectMapper();

    static {
        INSTANCE.registerModule(new JavaTimeModule());
    }

    public static String toJsonString(Object obj) {
        try {
            return INSTANCE.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            log.error("json序列化出错：{}", obj, e);
            return obj.toString();
        }
    }

    public static void main(String[] args) {
        Map<String, Object> map = new HashMap<>();
        map.put("name", "ekko");
        map.put("age", 30);
        System.out.println(map);
        System.out.println(toJsonString(map));

    }
}
