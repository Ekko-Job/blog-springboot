-- --------------------------------------------------
--   Cloud  &  payment
-- --------------------------------------------------

INSERT INTO payment_channel_main (id, channel_name, channel_type, pay_type, using_child, open_time_begin, open_time_end, process_time, process_time_unit, status, icon_url, update_time, update_user_id, sort, del, fee_rule, default_fee, less_amount, fee_setted, business_type, mobile, pay_channel_type, pay_channel_sort, immediately, recommend) VALUES(1081, 'XP INR', 62, 1, 41, '00:00', '24:00', 1, 1, 1, 'null', NOW(), 1, 1, 0, 2, 0.00, 0.00, 1, 9, NULL, 1, 0, 0, 0);
INSERT INTO payment_channel_main (id, channel_name, channel_type, pay_type, using_child, open_time_begin, open_time_end, process_time, process_time_unit, status, icon_url, update_time, update_user_id, sort, del, fee_rule, default_fee, less_amount, fee_setted, business_type, mobile, pay_channel_type, pay_channel_sort, immediately, recommend) VALUES(1082, 'XP INR', 62, 2, 41, '00:00', '24:00', 1, 1, 1, 'null', NOW(), 1, 1, 0, 2, 0.00, 0.00, 1, 9, NULL, 1, 0, 0, 0);

INSERT INTO payment_channel_child (id, channel_name, currency, min_deposit_money, max_deposit_money, service_name, withdraw_service_name, short_name, sort, del, max_withdrawal_money, min_withdrawal_money, rate_type, channel_rate_service, real_currency, token_standard) VALUES(41, 'XP INR', 'INR', 0.00, 0.00, 'xGroupPayINRDeposit', 'xGroupPayINRWithdrawService', '100040', 41, 0, 0.00, 0.00, 1, 'defaultChannelRateService', 'INR', NULL);

INSERT INTO payment_channel_relation (parent_channel, child_channel, sort, del) VALUES(1081, 41, 1, 0);
INSERT INTO payment_channel_relation (parent_channel, child_channel, sort, del) VALUES(1082, 41, 1, 0);

INSERT INTO payment_channel_config (child_channel_id, channel_config, callback_service, withdraw_callback_service, online, del) VALUES(41, '{
  "payUrl":"https://test.xgroup.cy/api_merchant/transaction_create",
  "checkPaymentUrl":"https://test.xgroup.cy/api_merchant/transaction",
  "merchantId":"872c7cd5-ea4d-80cf-f4df-2983236e5564",
  "login":"UserN1",
  "secret":"K7@wH!c84@",
  "depositDirectionId":"e53e8972-04ab-843b-1e84-cee862e8f177",
  "withdrawDirectionId":"ceed8369-116f-2c14-2d84-75fd8d11697f"
}', 'xGroupPayINRDepositCallbackService', 'xGroupPayINRWithdrawCallbackService', 1, 0);

INSERT INTO deposit_withdraw_relation (deposit_channel_id, withdraw_channel_id, del) VALUES(1081, 1082, 0);

INSERT INTO channel_currency (channel_id, currency, del) VALUES(1081, 'USD', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1081, 'USC', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1081, 'EUR', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1081, 'GBP', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1082, 'USD', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1082, 'USC', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1082, 'EUR', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1082, 'GBP', 0);

INSERT INTO payment_child_deposit_withdraw_relation (deposit_channel_id, withdraw_channel_id, del) VALUES(41, 41, 0);

INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 1, 'INR', 'USD', 5.00, 9500.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 2, 'INR', 'USD', 5.00, 9500.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 1, 'INR', 'USC', 5000.00, 950000.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 2, 'INR', 'USC', 5000.00, 950000.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 1, 'INR', 'EUR', 40.00, 8850.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 2, 'INR', 'EUR', 40.00, 8850.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 1, 'INR', 'GBP', 40.00, 7100.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 2, 'INR', 'GBP', 40.00, 7100.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 1, 'INR', 'INR', 3500.00, 800000.00, NOW(), 1, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(41, 2, 'INR', 'INR', 3500.00, 800000.00, NOW(), 1, NULL, NULL, 0);

INSERT INTO payment_channel_bank_config (child_channel_id, bank_list_service, del) VALUES(41, 'defaultChannelBankService', 0);