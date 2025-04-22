-- --------------------------------------------------
-- cloud # user
-- --------------------------------------------------
ALTER TABLE test3_db_user.swaps_free_account_gold MODIFY COLUMN `name` VARCHAR(128) DEFAULT NULL COMMENT '姓名';
ALTER TABLE test3_db_user.account_mark MODIFY COLUMN `update_user_name` VARCHAR(128)   DEFAULT NULL,MODIFY COLUMN `create_user_name` VARCHAR(128)   DEFAULT NULL;
ALTER TABLE test3_db_user.activity_gift MODIFY COLUMN `update_user` VARCHAR(128)    DEFAULT NULL COMMENT '更新人';
ALTER TABLE test3_db_user.cellxpert MODIFY COLUMN `first_name` VARCHAR(128)   NOT NULL COMMENT '用户姓名', MODIFY COLUMN `last_name` VARCHAR(128)   NOT NULL COMMENT '用户姓名', MODIFY COLUMN `user_name` VARCHAR(128)   NOT NULL COMMENT '用户在cellxpert注册后登录用户名';
ALTER TABLE test3_db_user.hr_sales MODIFY COLUMN `real_name` VARCHAR(128)    DEFAULT NULL COMMENT '真实姓名', MODIFY COLUMN `crm_name` VARCHAR(128)    DEFAULT NULL COMMENT 'CRM姓名';
ALTER TABLE test3_db_user.mam_performance MODIFY COLUMN `create_user` VARCHAR(128)   DEFAULT NULL;
ALTER TABLE test3_db_user.mam_performance_record MODIFY COLUMN `create_user` VARCHAR(128)   NOT NULL DEFAULT '' COMMENT '存名字就可以';
ALTER TABLE test3_db_user.message_group_member MODIFY COLUMN `member_name` VARCHAR(128)   NOT NULL COMMENT '成员名';
ALTER TABLE test3_db_user.swaps_free_account MODIFY COLUMN `name` VARCHAR(128)    DEFAULT NULL COMMENT '姓名', MODIFY COLUMN `create_name` VARCHAR(128)    DEFAULT NULL COMMENT '創建人員姓名', MODIFY COLUMN `update_name` VARCHAR(128)    DEFAULT NULL COMMENT '更新人員姓名';
ALTER TABLE test3_db_user.system_user_operate MODIFY COLUMN `name` VARCHAR(128)   DEFAULT NULL COMMENT '姓名';
ALTER TABLE test3_db_user.tb_user_marketo MODIFY COLUMN `name` VARCHAR(128)   DEFAULT NULL COMMENT '用户名', MODIFY COLUMN `first_name` VARCHAR(128)   DEFAULT NULL COMMENT '名', MODIFY COLUMN `last_name` VARCHAR(128)   DEFAULT NULL COMMENT '姓';
ALTER TABLE test3_db_user.user_abnormal MODIFY COLUMN `name` VARCHAR(128)   DEFAULT NULL COMMENT '姓名';
ALTER TABLE test3_db_user.user_inner MODIFY COLUMN `name` VARCHAR(128)   NOT NULL COMMENT '内部用户名';
ALTER TABLE test3_db_user.user_leads MODIFY COLUMN `name` VARCHAR(128)   NOT NULL;
ALTER TABLE test3_db_user.user_leads_channel_source_account MODIFY COLUMN `username` VARCHAR(128)    DEFAULT NULL COMMENT '账户';
ALTER TABLE test3_db_user.user_leads_dashboard MODIFY COLUMN `name` VARCHAR(128)   NOT NULL COMMENT 'leads名称';
ALTER TABLE test3_db_user.user_trader_info MODIFY COLUMN `nickname` VARCHAR(255)   DEFAULT NULL COMMENT '昵称';
