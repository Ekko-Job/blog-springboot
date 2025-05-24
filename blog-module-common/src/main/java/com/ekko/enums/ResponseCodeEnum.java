package com.ekko.enums;

import com.ekko.exception.BaseExceptionInterface;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 响应异常码
 *
 * @author Ekko
 * @date 2025-05-09
 * @email ekko.zhang@unionftech.com
 */
@Getter
@AllArgsConstructor
public enum ResponseCodeEnum implements BaseExceptionInterface {

    // ----------- 未知错误异常 -----------
    SYSTEM_ERROR("ERROR9999", "出错啦，联系后台小哥修复..."),

    // ----------- 自定义业务异常 -----------
    MSCE0001("MSCE0001", "业务异常状态码（测试使用）"),
    MSCE9999("MSCE9999", "失败"),
    MSCE0002("MSCE0002", "登录失败"),
    MSCE0003("MSCE0003", "用户名或密码错误"),
    MSCE0004("MSCE0004", "测试账号仅支持查询操作！"),


    // ----------- SUCCESS -----------
    MSCS0000("MSCS0000", "成功"),

    // ----------- 全局系统异常 -----------
    SYS0001("401", "无访问权限，请先登录！"),

    ;

    // 异常码
    private String errorCode;
    // 错误信息
    private String errorMessage;

}
