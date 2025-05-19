package com.ekko.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpStatus;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * ResultUtil
 *
 * @author Ekko
 * @date 2025-05-16
 * @email ekko.zhang@unionftech.com
 */
public class ResultUtil {

    /**
     * 成功响参
     *
     * @param response
     * @param result
     * @throws IOException
     */
    public static void ok(HttpServletResponse response, Resp<?> result) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpStatus.OK.value());
        response.setContentType("application/json");
        PrintWriter writer = response.getWriter();

        ObjectMapper mapper = new ObjectMapper();
        writer.write(mapper.writeValueAsString(result));
        writer.flush();
        writer.close();
    }

    /**
     * 失败响参
     *
     * @param response
     * @param result
     * @throws IOException
     */
    public static void fail(HttpServletResponse response, Resp<?> result) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpStatus.OK.value());
        response.setContentType("application/json");
        PrintWriter writer = response.getWriter();

        ObjectMapper mapper = new ObjectMapper();
        writer.write(mapper.writeValueAsString(result));
        writer.flush();
        writer.close();
    }

    /**
     * 失败响参
     *
     * @param response
     * @param status   可指定响应码，如 401 等
     * @param result
     * @throws IOException
     */
    public static void fail(HttpServletResponse response, String status, Resp<?> result) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setStatus(Integer.parseInt(status));
        response.setContentType("application/json");
        PrintWriter writer = response.getWriter();

        ObjectMapper mapper = new ObjectMapper();
        writer.write(mapper.writeValueAsString(result));
        writer.flush();
        writer.close();
    }
}
