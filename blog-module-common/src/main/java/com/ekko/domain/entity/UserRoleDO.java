package com.ekko.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * UserRoleDO
 *
 * @author Ekko
 * @date 2025-05-24
 * @email ekko.zhang@unionftech.com
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName("t_user_role")
public class UserRoleDO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String username;

    private String role;

    private Date createTime;
}
