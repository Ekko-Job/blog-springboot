-- --------------------------------------------------
--   Cloud  &  User
-- --------------------------------------------------

UPDATE  country SET is_risk = 1 WHERE code IN ('BLR', 'RUS', 'CUB', 'ZIM', 'LIB', 'MYA', 'NCA', 'SUD', 'VEN', 'UKR', 'SYR', 'CAF', 'COD', 'CGO', 'PRK', 'SSD');



-- --------------------------------------------------
--   Cloud  &  Payment
-- --------------------------------------------------
INSERT INTO country_pay_config (country_code, min_deposit, max_balance, min_withdrawal, create_time, create_user_id, update_time, update_user_id, del, currency)
                    VALUES('HRSK', 0.00, 0.00, 0.00, now(), 1, now(), 1, 0, 'USD');


