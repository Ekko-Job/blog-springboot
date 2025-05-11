package com.ekko.controller;

import com.ekko.aspect.ApiOperationLog;
import com.ekko.model.User;
import com.ekko.utils.JsonUtil;
import com.ekko.utils.Resp;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.stream.Collectors;

import static com.ekko.enums.ResponseCodeEnum.MSCE0001;
import static com.ekko.enums.ResponseCodeEnum.MSCE9999;
import static com.ekko.exception.BusinessException.ex;

/**
 * TestController
 *
 * @author Ekko
 * @date 2025-04-25
 * @email ekko.zhang@unionftech.com
 */
@RestController
@Slf4j
@Api(tags = "测试模块")
public class TestController {

    @PostMapping("/test")
    @ApiOperation("测试接口")
    @ApiOperationLog(description = "测试接口")
    public Resp test(@RequestBody @Validated User user) {
        // 是否存在校验错误
        // if (bindingResult.hasErrors()) {
        //     // 获取校验不通过字段的提示信息
        //     String errorMsg = bindingResult.getFieldErrors()
        //             .stream()
        //             .map(FieldError::getDefaultMessage)
        //             .collect(Collectors.joining(", "));
        //
        //     return Resp.createFailerResp(errorMsg);
        // }
        // ex(MSCE9999);
        // int i = 1/0;

        log.info(JsonUtil.toJsonString(user));

        user.setCreateTime(LocalDateTime.now());
        user.setUpdateDate(LocalDate.now());
        user.setTime(LocalTime.now());

        return Resp.createSuccessCodeResp(user);
    }

}
