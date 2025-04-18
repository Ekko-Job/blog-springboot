-- --------------------------------------------------
-- center # center
-- --------------------------------------------------
ALTER TABLE test_center.sys_user MODIFY COLUMN `user_name` varchar(128)   NOT NULL COMMENT '用户账号', MODIFY COLUMN `nick_name` varchar(128)   NOT NULL COMMENT '用户昵称', MODIFY COLUMN `update_by` varchar(128)   DEFAULT '' COMMENT '更新者', MODIFY COLUMN `create_by` varchar(128)   DEFAULT '' COMMENT '创建者';
