-- --------------------------------------------------
-- cloud # payment
-- --------------------------------------------------
ALTER TABLE test3_db_payment.binding_bank_card_record MODIFY COLUMN `user_name` varchar(128) NOT NULL COMMENT '用户姓名';
ALTER TABLE test3_db_payment.pay_withdrawal_order MODIFY COLUMN `card_hold_name` VARCHAR(128) DEFAULT NULL COMMENT '银行卡所属人姓名';
ALTER TABLE test3_db_payment.wire_transfer_card MODIFY COLUMN `user_name` VARCHAR(128) NOT NULL COMMENT '持卡人姓名';
ALTER TABLE test3_db_payment.credit_card_balance MODIFY COLUMN `card_holder` VARCHAR(128) NOT NULL COMMENT '信用卡所属人姓名';

