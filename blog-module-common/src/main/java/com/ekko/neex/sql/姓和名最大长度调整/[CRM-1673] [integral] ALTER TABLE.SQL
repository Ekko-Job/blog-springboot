-- --------------------------------------------------
-- MWS # integral
-- --------------------------------------------------
ALTER TABLE test_integral.order_sign_info MODIFY COLUMN `sign_name` varchar(128)   DEFAULT NULL COMMENT '签收人姓名';
ALTER TABLE test_integral.user_integral MODIFY COLUMN `username` varchar(128)   DEFAULT NULL COMMENT '客户姓名';
