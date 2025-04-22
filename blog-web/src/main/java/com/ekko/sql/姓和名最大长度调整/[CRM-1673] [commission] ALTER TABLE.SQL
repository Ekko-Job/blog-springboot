-- --------------------------------------------------
-- cloud # commission
-- --------------------------------------------------
ALTER TABLE test3_db_commission.restart_commission_record MODIFY COLUMN `create_user` VARCHAR(128)   NOT NULL DEFAULT '' COMMENT '存名字就可以';
