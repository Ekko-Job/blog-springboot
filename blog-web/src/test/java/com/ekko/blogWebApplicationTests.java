package com.ekko;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * blogWebApplicationTests
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@SpringBootTest
@Slf4j
public class blogWebApplicationTests {

    @Test
    public void test() {
        log.info("测试");
    }

    @Test
    void testLog() {
        log.info("这是一行 Info 级别日志");
        log.warn("这是一行 Warn 级别日志");
        log.error("这是一行 Error 级别日志");

        // 占位符
        String author = "Ekko";
        log.info("这是一行带有占位符日志，作者：{}", author);
    }

}
