package com.ekko.controller;

import com.ekko.aspect.ApiOperationLog;
import com.ekko.model.User;
import com.ekko.utils.Resp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.stream.Collectors;

/**
 * TestController
 *
 * @author Ekko
 * @date 2025-04-25
 * @email ekko.zhang@unionftech.com
 */
@RestController
@Slf4j
public class TestController {

    @PostMapping("/test")
    @ApiOperationLog(description = "测试接口")
    public Resp test(@RequestBody @Validated User user, BindingResult bindingResult) {
        // 是否存在校验错误
        if (bindingResult.hasErrors()) {
            // 获取校验不通过字段的提示信息
            String errorMsg = bindingResult.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));

            return Resp.createFailerResp(errorMsg);
        }

        // 返参
        return Resp.createSuccessCodeResp(user);
    }

}
