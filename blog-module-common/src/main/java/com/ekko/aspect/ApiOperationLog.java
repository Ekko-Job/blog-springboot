package com.ekko.aspect;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * ApiOperationLog
 *
 * @author Ekko
 * @date 2025-04-25
 * @email ekko.zhang@unionftech.com
 */
// @Retention():指定注解的保留策略，即注解在何时生效。
// RetentionPolicy:运行时保留，这意味着它可以通过反射在运行时被访问和解析。
@Retention(RetentionPolicy.RUNTIME)
// @Target():指定注解的作用目标，即注解可以应用的位置。
// ElementType:方法，字段，构造器，类，接口，枚举，参数，包等。
@Target({ElementType.METHOD})
// @Documented():指定该注解是否被 javadoc 工具记录。
@Documented
public @interface ApiOperationLog {
    /**
     * API 功能描述
     *
     * @return
     */
    String description() default "";

}
