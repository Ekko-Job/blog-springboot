package com.ekko.exception;

import lombok.Data;

/**
 * BusinessException
 *
 * @author Ekko
 * @date 2025-05-09
 * @email ekko.zhang@unionftech.com
 */
@Data
public class BusinessException extends RuntimeException {

    // 异常码
    private String errorCode;
    // 错误信息
    private String errorMessage;

    public BusinessException(BaseExceptionInterface baseExceptionInterface) {
        this.errorCode = baseExceptionInterface.getErrorCode();
        this.errorMessage = baseExceptionInterface.getErrorMessage();
    }

    public static void ex(BaseExceptionInterface baseExceptionInterface) {
        throw new BusinessException(baseExceptionInterface);
    }


}
