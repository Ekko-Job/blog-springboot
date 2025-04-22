-- UAE LD
-- --------------------------------------------------
-- cloud # user
-- --------------------------------------------------
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 6, 0, 1, 1, NOW(), NOW());
-- --------------------------------------------------
-- cloud # payment
-- --------------------------------------------------
INSERT INTO country_pay_config (country_code, min_deposit, max_balance, min_withdrawal, create_time, create_user_id, update_time, update_user_id, del, currency) VALUES('UAE', 0.00, 0.00, 0.00, NOW(), 1, NOW(), 1, 0, 'USD');
INSERT INTO payment_channel_main (id, channel_name, channel_type, pay_type, using_child, open_time_begin, open_time_end, process_time, process_time_unit, status, icon_url, update_time, update_user_id, sort, del, fee_rule, default_fee, less_amount, fee_setted, business_type, mobile, pay_channel_type, pay_channel_sort, immediately, recommend) VALUES(1043, 'UAE LD', 54, 1, 22, '00:00', '24:00', 1, 1, 2, 'null', NOW(), 1, 0, 0, 2, 0.00, 0.00, 1, 11, NULL, 2, 22, 0, 0);
INSERT INTO payment_channel_main (id, channel_name, channel_type, pay_type, using_child, open_time_begin, open_time_end, process_time, process_time_unit, status, icon_url, update_time, update_user_id, sort, del, fee_rule, default_fee, less_amount, fee_setted, business_type, mobile, pay_channel_type, pay_channel_sort, immediately, recommend) VALUES(1044, 'UAE LD', 54, 2, 22, '00:00', '24:00', 1, 1, 2, 'null', NOW(), 1, 0, 0, 2, 0.00, 0.00, 1, 11, NULL, 2, 22, 0, 0);
INSERT INTO payment_channel_child (id, channel_name, currency, min_deposit_money, max_deposit_money, service_name, withdraw_service_name, short_name, sort, del, max_withdrawal_money, min_withdrawal_money, rate_type, channel_rate_service, real_currency, token_standard) VALUES(22, 'UAE LD', 'USD', 0.00, 0.00, 'UAELDDeposit', '', '100022', 22, 0, 0.00, 0.00, 1, 'defaultChannelRateService', 'USD', NULL);
INSERT INTO payment_channel_relation (parent_channel, child_channel, sort, del) VALUES(1043, 22, 1, 0);
INSERT INTO payment_channel_relation (parent_channel, child_channel, sort, del) VALUES(1044, 22, 1, 0);
INSERT INTO payment_channel_config (child_channel_id, channel_config, callback_service, withdraw_callback_service, online, del) VALUES(22, '', NULL, NULL, 1, 0);
INSERT INTO deposit_withdraw_relation (deposit_channel_id, withdraw_channel_id, del) VALUES(1043, 1044, 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1043, 'USD', 0);
INSERT INTO channel_currency (channel_id, currency, del) VALUES(1044, 'USD', 0);
INSERT INTO payment_child_deposit_withdraw_relation (deposit_channel_id, withdraw_channel_id, del) VALUES(22, 22, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(22, 1, 'USD', 'USD', 0.00, 0.00, NOW(), NULL, NULL, NULL, 0);
INSERT INTO payment_channel_limit (child_channel_id, pay_type, currency, limit_currency, min_money, max_money, create_time, create_user_id, update_time, update_user_id, del) VALUES(22, 2, 'USD', 'USD', 0.00, 0.00, NOW(), NULL, NULL, NULL, 0);













