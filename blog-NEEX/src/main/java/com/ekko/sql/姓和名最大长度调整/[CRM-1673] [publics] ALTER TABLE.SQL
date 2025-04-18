-- --------------------------------------------------
-- cloud # publics
-- --------------------------------------------------
ALTER TABLE test3_db_publics.msg_send_log MODIFY COLUMN `full_name_local` varchar(128)   DEFAULT NULL COMMENT '中文名', MODIFY COLUMN `full_name_en` varchar(128)   DEFAULT NULL COMMENT '英文名', MODIFY COLUMN `operator_name` varchar(128)   DEFAULT NULL COMMENT '操作人姓名';
