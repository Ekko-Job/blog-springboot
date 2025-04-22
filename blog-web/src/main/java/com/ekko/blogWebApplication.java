package com.ekko;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

/**
 * blogWebApplication
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@SpringBootApplication
@ComponentScan(basePackages = {"com.ekko.*"}) // 多模块项目中，必需手动指定扫描 com.ekko 包下面的所有类
public class blogWebApplication {
    public static void main(String[] args) {
        SpringApplication.run(blogWebApplication.class, args);
    }
}
