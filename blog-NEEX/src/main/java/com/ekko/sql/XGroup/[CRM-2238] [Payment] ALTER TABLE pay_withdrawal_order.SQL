-- --------------------------------------------------
--   Cloud  &  payment
-- --------------------------------------------------

ALTER TABLE `pay_withdrawal_order` ADD COLUMN `channel_order_number` VARCHAR(64) DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号';
