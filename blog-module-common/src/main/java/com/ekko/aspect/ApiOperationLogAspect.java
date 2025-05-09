package com.ekko.aspect;

import com.ekko.utils.JsonUtil;
import com.ekko.utils.Resp;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.MDC;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * ApiOperationLogAspect
 *
 * @author Ekko
 * @date 2025-04-25
 * @email ekko.zhang@unionftech.com
 */
@Aspect
@Component
@Slf4j
public class ApiOperationLogAspect {
    /**
     * 以自定义 @ApiOperationLog 注解为切点，凡是添加 @ApiOperationLog 的方法，都会执行环绕中的代码
     */
    @Pointcut("@annotation(com.ekko.aspect.ApiOperationLog)")
    public void apiOperationLog() {
    }

    /**
     * 环绕
     *
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("apiOperationLog()")
    public Object doAround(ProceedingJoinPoint joinPoint) throws Throwable {
        try {
            // 请求开始时间
            long startTime = System.currentTimeMillis();

            // traceId 表示跟踪 ID， 值这里直接用的 UUID
            // String traceId = UUID.randomUUID().toString();
            // MDC.put("traceId", traceId);

            // 获取被请求的类和方法
            String className = joinPoint.getTarget().getClass().getSimpleName();
            String methodName = joinPoint.getSignature().getName();

            // 请求入参
            Object[] args = joinPoint.getArgs();

            // 先过滤掉 BindingResult，再安全地序列化
            List<Object> filteredArgs = Arrays.stream(args).filter(arg -> !(arg instanceof BindingResult)).collect(Collectors.toList());

            String argsJsonStr;
            try {
                argsJsonStr = filteredArgs.stream().map(toJsonStr()).collect(Collectors.joining(", "));
            } catch (Exception e) {
                log.warn("序列化入参出错，已忽略无法序列化的对象：{}", e.getMessage());
                argsJsonStr = filteredArgs.toString();
            }

            // 功能描述信息
            String description = getApiOperationLogDescription(joinPoint);

            // 打印请求相关参数
            log.info("====== 请求开始: [{}], 入参: {}, 请求类: {}, 请求方法: {}", description, argsJsonStr, className, methodName);

            // TODO 执行切点方法
            Object result = joinPoint.proceed();

            // 执行耗时
            long executionTime = System.currentTimeMillis() - startTime;

            String traceId = MDC.get("traceId");
            if (result instanceof Resp) {
                ((Resp<?>) result).setTraceId(traceId);
            }

            // 安全序列化出参
            String resultJson;
            try {
                resultJson = JsonUtil.toJsonString(result);
            } catch (Exception e) {
                log.warn("序列化出参出错：{}", e.getMessage());
                resultJson = result != null ? result.toString() : "null";
            }

            // 打印出参等相关信息
            log.info("====== 请求结束: [{}], 出参: {}, 耗时: {}ms", description, resultJson, executionTime);
            return result;

        } finally {
            // MDC.clear();
        }
    }

    /**
     * 获取注解的描述信息
     *
     * @param joinPoint
     * @return
     */
    private String getApiOperationLogDescription(ProceedingJoinPoint joinPoint) {
        // 1. 从 ProceedingJoinPoint 获取 MethodSignature
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();

        // 2. 使用 MethodSignature 获取当前被注解的 Method
        Method method = signature.getMethod();

        // 3. 从 Method 中提取 LogExecution 注解
        ApiOperationLog apiOperationLog = method.getAnnotation(ApiOperationLog.class);

        // 4. 从 LogExecution 注解中获取 description 属性
        return apiOperationLog.description();
    }

    /**
     * 转 JSON 字符串
     *
     * @return
     */
    private Function<Object, String> toJsonStr() {

        return arg -> {
            if (arg == null) {
                return "null";
            }
            // 跳过 BindingResult，避免 Jackson 序列化错误
            if (arg instanceof BindingResult) {
                return "\"[BindingResult skipped]\"";
            }
            try {
                return JsonUtil.toJsonString(arg);
            } catch (Exception e) {
                // 序列化失败时，返回简单的 toString
                return "\"" + arg.toString() + "\"";
            }
        };
    }
}
