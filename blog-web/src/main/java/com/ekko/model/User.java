package com.ekko.model;


import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * User
 *
 * @author Ekko
 * @date 2025-04-25
 * @email ekko.zhang@unionftech.com
 */
@Data
public class User {

    // 用户名
    @NotBlank(message = "用户名不能为空")
    private String username;

    // 性别
    @NotNull(message = "性别不能为空")
    private Integer sex;

    // 年龄
    @NotNull(message = "年龄不能为空")
    @Min(value = 18, message = "年龄必须大于或等于 18")
    @Max(value = 100, message = "年龄必须小于或等于 100")
    private Integer age;

    // 邮箱
    @NotBlank(message = "邮箱不能为空")
    @Email(message = "邮箱格式不正确")
    private String email;

}
