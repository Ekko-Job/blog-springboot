package com.ekko.exception;

import com.ekko.enums.ResponseCodeEnum;
import com.ekko.utils.Resp;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Optional;

/**
 * GlobalExceptionHandler
 *
 * @author Ekko
 * @date 2025-05-09
 * @email ekko.zhang@unionftech.com
 */
@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 捕获未知错误异常
     *
     * @param request
     * @param e
     * @return
     */
    @ExceptionHandler({Exception.class})
    @ResponseBody
    public Resp<Object> handleOtherException(HttpServletRequest request, Exception e) {
        log.error("捕获未知错误异常(接口): {}, 错误日志: ", request.getRequestURI(), e);
        return Resp.fail(ResponseCodeEnum.SYSTEM_ERROR, MDC.get("traceId"));
    }

    /**
     * 捕获自定义业务异常
     *
     * @return
     */
    @ExceptionHandler({BusinessException.class})
    @ResponseBody
    public Resp<Object> handleBusinessException(HttpServletRequest request, BusinessException e) {
        log.warn("捕获自定义业务异常(接口): {}, 错误Code: {}, 错误日志: {}", request.getRequestURI(), e.getErrorCode(), e.getErrorMessage());
        return Resp.fail(e, MDC.get("traceId"));
    }

    /**
     * 捕获参数校验异常
     *
     * @return
     */
    @ExceptionHandler({MethodArgumentNotValidException.class})
    @ResponseBody
    public Resp<Object> handleMethodArgumentNotValidException(HttpServletRequest request, MethodArgumentNotValidException e) {

        // 获取 BindingResult
        BindingResult bindingResult = e.getBindingResult();

        StringBuilder sb = new StringBuilder();

        // 获取校验不通过的字段，并组合错误信息，格式为:  email 邮箱格式不正确, 当前值: '123124qq.com';
        Optional.ofNullable(bindingResult.getFieldErrors()).ifPresent(errors -> {
            errors.forEach(error ->
                    sb.append(error.getField())
                            .append(" ")
                            .append(error.getDefaultMessage())
                            .append(", 当前值: '")
                            .append(error.getRejectedValue())
                            .append("'; ")

            );
        });

        // 错误信息
        String errorMessage = sb.toString();

        log.warn("接口: {} request error, errorMessage: {}", request.getRequestURI(), errorMessage);

        return Resp.fail("优雅的参数校验: @Validated", errorMessage, MDC.get("traceId"));
    }

}
