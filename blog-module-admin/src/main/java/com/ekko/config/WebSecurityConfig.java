package com.ekko.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;

/**
 * WebSecurityConfig
 *
 * @author Ekko
 * @date 2025-05-15
 * @email ekko.zhang@unionftech.com
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired // 设置用户登录认证相关配置
    private JwtAuthenticationSecurityConfig jwtAuthenticationSecurityConfig;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable() // 禁用csrf
                .formLogin().disable() // 禁用表单登录
                .apply(jwtAuthenticationSecurityConfig) // 应用 JwtAuthenticationSecurityConfig 配置
                .and()
                .authorizeHttpRequests()
                .mvcMatchers("/admin/**").authenticated()  // 认证所有以 /admin 为前缀的 URL 资源
                .anyRequest().permitAll() // 其他都需要放行，无需认证
                .and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS); // 禁用Session：前后端分离，无需创建会话

    }

}
