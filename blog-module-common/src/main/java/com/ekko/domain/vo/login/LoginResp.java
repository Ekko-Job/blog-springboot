package com.ekko.domain.vo.login;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * LoginResp
 *
 * @author Ekko
 * @date 2025-05-16
 * @email ekko.zhang@unionftech.com
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LoginResp {
    private String token;
}
