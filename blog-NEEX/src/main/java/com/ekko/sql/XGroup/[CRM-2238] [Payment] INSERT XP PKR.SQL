-- --------------------------------------------------
--   Cloud  &  payment
-- --------------------------------------------------

INSERT INTO payment_channel_main (id, channel_name, channel_type, pay_type, using_child, open_time_begin, open_time_end, process_time, process_time_unit, status, icon_url, update_time, update_user_id, sort, del, fee_rule, default_fee, less_amount, fee_setted, business_type, mobile, pay_channel_type, pay_channel_sort, immediately, recommend) VALUES(1083, 'XP PKR', 63, 1, 42, '00:00', '24:00', 1, 1, 1, 'null', NOW(), 1, 1, 0, 2, 0.00, 0.00, 1, 9, NULL, 1, 0, 0, 0);
INSERT INTO payment_channel_main (id, channel_name, channel_type, pay_type, using_child, open_time_begin, open_time_end, process_time, process_time_unit, status, icon_url, update_time, update_user_id, sort, del, fee_rule, default_fee, less_amount, fee_setted, business_type, mobile, pay_channel_type, pay_channel_sort, immediately, recommend) VALUES(1084, 'XP PKR', 63, 2, 42, '00:00', '24:00', 1, 1, 1, 'null', NOW(), 1, 1, 0, 2, 0.00, 0.00, 1, 9, NULL, 1, 0, 0, 0);

INSERT INTO payment_channel_child (id, channel_name, currency, min_deposit_money, max_deposit_money, service_name, withdraw_service_name, short_name, sort, del, max_withdrawal_money, min_withdrawal_money, rate_type, channel_rate_service, real_currency, token_standard) VALUES(42, 'XP PKR', 'PKR', 0.00, 0.00, 'xGroupPayPKRDeposit', 'xGroupPayPKRWithdrawService', '100042', 42, 0, 0.00, 0.00, 1, 'defaultChannelRateService', 'PKP', NULL);

INSERT INTO payment_channel_relation (parent_channel, child_channel, sort, del) VALUES(1083, 42, 1, 0);
INSERT INTO payment_channel_relation (parent_channel, child_channel, sort, del) VALUES(1084, 42, 1, 0);

INSERT INTO payment_channel_config (child_channel_id, channel_config, callback_service, withdraw_callback_service, online, del) VALUES(42, '{
  "payUrl":"https://test.xgroup.cy/api_merchant/transaction_create",
  "checkPaymentUrl":"https://test.xgroup.cy/api_merchant/transaction",
  "merchantId":"872c7cd5-ea4d-80cf-f4df-2983236e5564",
  "login":"UserN1",
  "secret":"K7@wH!c84@",
  "depositDirectionId":"6a165e7c-d962-d19a-d9f9-21d59e32effe",
  "withdrawDirectionId":"13e7f250-4e66-3aaa-6019-f6efffbbaaa1"
}', 'xGroupPayPKRDepositCallbackService', 'xGroupPayPKRWithdrawCallbackService', 1, 0);

INSERT INTO deposit_withdraw_relation (deposit_channel_id, withdraw_channel_id, del) VALUES(1083, 1084, 0);

INSERT INTO channel_currency (channel_id, currency, del) VALUES(1083, 'USD', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1083, 'USC', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1083, 'EUR', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1083, 'GBP', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1084, 'USD', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1084, 'USC', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1084, 'EUR', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1084, 'GBP', 0);

INSERT INTO payment_child_deposit_withdraw_relation (deposit_channel_id, withdraw_channel_id, del) VALUES(42, 42, 0);

INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 1, 'PKR', 'USD', 6.00, 1750.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 2, 'PKR', 'USD', 6.00, 1750.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 1, 'PKR', 'USC', 6000.00, 175000.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 2, 'PKR', 'USC', 6000.00, 175000.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 1, 'PKR', 'EUR', 60.00, 1650.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 2, 'PKR', 'EUR', 60.00, 1650.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 1, 'PKR', 'GBP', 50.00, 1400.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 2, 'PKR', 'GBP', 50.00, 1400.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 1, 'PKR', 'PKR', 15000.00, 500000.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(42, 2, 'PKR', 'PKR', 15000.00, 500000.00, NOW(), 1, NULL, NULL, 0);

INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('USD', 'PKR', 1, 279.9600, 0.0000, 279.9600, NOW(), 1, NOW(), 109, 0, 279.9600, 1, 1, 1, 0.0000, 1);
INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('USD', 'PKR', 2, 279.9600, 0.0000, 279.9600, NOW(), 1, NOW(), 109, 0, 279.9600, 1, 1, 1, 0.0000, 1);
INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('USC', 'PKR', 1, 2.7996, 0.0000, 2.7996, NOW(), 1, NOW(), 110, 0, 2.7996, 1, 1, 1, 0.0000, 1);
INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('USC', 'PKR', 2, 2.7996, 0.0000, 2.7996, NOW(), 1, NOW(), 110, 0, 2.7996, 1, 1, 1, 0.0000, 1);
INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('GBP', 'PKR', 1, 362.8775, 0.0000, 362.8775, NOW(), 1, NOW(), 111, 0, 362.2671, 1, 1, 1, 0.0000, 1);
INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('GBP', 'PKR', 2, 362.8775, 0.0000, 362.8775, NOW(), 1, NOW(), 111, 0, 362.2671, 1, 1, 1, 0.0000, 1);
INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('EUR', 'PKR', 1, 303.2167, 0.0000, 303.2167, NOW(), 1, NOW(), 112, 0, 303.2167, 1, 1, 1, 0.0000, 1);
INSERT INTO payment_rate (src_currency, target_currency, pay_type, base_rate, premium_rate, using_rate, update_time, update_user_id, auto_update_time, sort, del, monitor_rate, automatic_status, src_currency_type, target_currency_type, premium_value, premium_type) VALUES('EUR', 'PKR', 2, 303.2167, 0.0000, 303.2167, NOW(), 1, NOW(), 112, 0, 303.2167, 1, 1, 1, 0.0000, 1);

INSERT INTO payment_channel_bank_config (child_channel_id, bank_list_service, del) VALUES(42, 'defaultChannelBankService', 0);



