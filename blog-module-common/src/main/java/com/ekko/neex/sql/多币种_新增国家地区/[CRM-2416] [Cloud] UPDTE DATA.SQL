-- --------------------------------------------------
--   Cloud  &  User
-- --------------------------------------------------
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 61,  0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 201, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 176, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 46,  0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 24,  0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 165, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 112, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 78,  0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 192, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 195, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 196, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 148, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 226, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 123, 0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 89,  0, 1, 1, now(), now());
INSERT INTO currency_country (currency_id, country_id, eu, create_user_id, update_user_id, create_time, update_time) VALUES(',1,', 168, 0, 1, 1, now(), now());


UPDATE  country SET is_risk = 1 WHERE code IN ('BLR', 'RUS', 'CUB', 'ZIM', 'LIB', 'MYA', 'NCA', 'SUD', 'VEN', 'UKR', 'SYR', 'CAF', 'COD', 'CGO', 'PRK', 'SSD');



-- --------------------------------------------------
--   Cloud  &  Payment
-- --------------------------------------------------
INSERT INTO country_pay_config (country_code, min_deposit, max_balance, min_withdrawal, create_time, create_user_id, update_time, update_user_id, del, currency)
                    VALUES('HRSK', 0.00, 0.00, 0.00, now(), 1, now(), 1, 0, 'USD');


