package com.ekko;

import com.ekko.domain.entity.UserDO;
import com.ekko.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;

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



    @Autowired
    private UserMapper userMapper;

    @Test
    void insertTest() {
        // 构建数据库实体类
        UserDO userDO = UserDO.builder()
                .username("Ekko")
                .password("123456")
                .createTime(new Date())
                .updateTime(new Date())
                .isDel(false)
                .build();

        userMapper.insert(userDO);
    }

}
