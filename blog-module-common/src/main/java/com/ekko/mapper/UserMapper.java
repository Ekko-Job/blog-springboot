package com.ekko.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ekko.domain.entity.UserDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * UserMapper
 *
 * @author Ekko
 * @date 2025-05-16
 * @email ekko.zhang@unionftech.com
 */
public interface UserMapper extends BaseMapper<UserDO> {
    default UserDO findByUsername(String username) {
        LambdaQueryWrapper<UserDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDO::getUsername, username);
        return selectOne(wrapper);
    }
}
