package com.ekko.handler;

import com.ekko.enums.ResponseCodeEnum;
import com.ekko.utils.Resp;
import com.ekko.utils.ResultUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * RestAuthenticationEntryPoint
 *
 * @author Ekko
 * @date 2025-05-19
 * @email ekko.zhang@unionftech.com
 */
@Slf4j
@Component
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException, IOException {
        log.warn("用户未登录访问受保护的资源: ", authException);
        if (authException instanceof InsufficientAuthenticationException) {
            ResultUtil.fail(response, ResponseCodeEnum.SYS0001.getErrorCode(), Resp.fail(ResponseCodeEnum.SYS0001));
            return;
        }

        ResultUtil.fail(response, ResponseCodeEnum.SYS0001.getErrorCode(), Resp.fail("401", authException.getMessage(), null));
    }
}
