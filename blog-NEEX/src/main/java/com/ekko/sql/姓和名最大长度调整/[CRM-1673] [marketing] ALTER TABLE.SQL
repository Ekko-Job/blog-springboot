-- --------------------------------------------------
-- MWS # marketing
-- --------------------------------------------------
ALTER TABLE test_marketing.activity_account MODIFY COLUMN `user_name` varchar(128)   NOT NULL COMMENT '用户英文姓名', MODIFY COLUMN `user_cn_name` varchar(128)   DEFAULT NULL COMMENT '用户中文姓名';
ALTER TABLE test_marketing.activity_user MODIFY COLUMN `name` varchar(128)   NOT NULL COMMENT '用户英文姓名', MODIFY COLUMN `cn_name` varchar(128)   DEFAULT NULL COMMENT '用户中文姓名';
ALTER TABLE test_marketing.subsidies_account MODIFY COLUMN `user_name` varchar(128)   NOT NULL COMMENT '用户名';
ALTER TABLE test_marketing.user MODIFY COLUMN `user_name` varchar(128)   NOT NULL COMMENT '用户名', MODIFY COLUMN `login_name` varchar(128)   NOT NULL COMMENT '登陆名';
