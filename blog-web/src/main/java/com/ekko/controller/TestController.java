package com.ekko.controller;

import com.ekko.aspect.ApiOperationLog;
import com.ekko.model.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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
    @ApiOperationLog(description = "Test Aspect Log")
    public User test(@RequestBody User user) {
        return user;
    }

}
