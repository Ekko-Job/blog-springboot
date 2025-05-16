package com.ekko.exception;


import org.springframework.security.core.AuthenticationException;

/**
 * UsernameOrPasswordNullException
 *
 * @author Ekko
 * @date 2025-05-16
 * @email ekko.zhang@unionftech.com
 */
public class UsernameOrPasswordNullException extends AuthenticationException {

    public UsernameOrPasswordNullException(String msg, Throwable cause) {
        super(msg, cause);
    }

    public UsernameOrPasswordNullException(String msg) {
        super(msg);
    }

}
