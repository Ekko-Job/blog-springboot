package com.ekko.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/**
 * MybatisPlusConfig
 *
 * @author Ekko
 * @date 2025-05-15
 * @email ekko.zhang@unionftech.com
 */
@Configuration
@MapperScan("com.ekko.domain.mapper")
public class MybatisPlusConfig {

}
