package com.ekko.utils;

import lombok.Data;

import java.io.Serializable;

/**
 * Resp
 *
 * @author Ekko
 * @date 2025-04-29
 * @email ekko.zhang@unionftech.com
 */
@Data
public class Resp<T> implements Serializable {

    // 状态码
    private String code;

    // 状态码描述
    private String msg;

    // 响应数据对象
    private T data;

    // 跟踪ID
    private String traceId;

    // =================================== 成功响应 ===================================

    public static <T> Resp<T> createSuccessCodeResp(T data) {
        Resp<T> response = new Resp<>();
        response.setCode("MSCS0000");
        response.setMsg("成功");
        response.setData(data);
        return response;
    }

    // =================================== 失败响应 ===================================

    public static <T> Resp<T> createFailerResp(T datae) {
        Resp<T> response = new Resp<>();
        response.setCode("MSCE9999");
        response.setMsg("失败");
        response.setData(datae);
        return response;
    }

}
