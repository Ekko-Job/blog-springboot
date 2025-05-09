package com.ekko.exception;

import com.ekko.enums.ResponseCodeEnum;
import com.ekko.utils.Resp;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

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
        log.error("接口：{} request error, ", request.getRequestURI(), e);
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
        log.warn("接口：{} request fail, errorCode: {}, errorMessage: {}", request.getRequestURI(), e.getErrorCode(), e.getErrorMessage());
        return Resp.fail(e, MDC.get("traceId"));
    }


}
