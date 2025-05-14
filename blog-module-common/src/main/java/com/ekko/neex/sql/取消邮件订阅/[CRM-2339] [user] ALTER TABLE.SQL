-- --------------------------------------------------
--   Cloud  &  user
-- --------------------------------------------------
ALTER TABLE user_black_list ADD COLUMN operation_type INT COMMENT '操作类型:1-客户操作,2-后台操作' AFTER type,
                            ADD COLUMN email_type     INT COMMENT '邮件类型:1-All,2-系统,3-通知,4-营销' AFTER type;

UPDATE user_black_list SET email_type = 1, operation_type = 2 WHERE  email_type IS NULL;





