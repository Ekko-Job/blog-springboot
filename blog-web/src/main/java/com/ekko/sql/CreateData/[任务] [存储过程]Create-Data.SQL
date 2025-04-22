-- ------------------------------------------------------
-- 删除存储过程
-- DROP PROCEDURE IF EXISTS InsertTestData;
-- ------------------------------------------------------


-- ------------------------------------------------------
-- Ø  统计分析→佣金报表→品种组佣金报表→下载报表
-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE InsertTestData()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE sort_value BIGINT DEFAULT 80000000;
    WHILE i < 60000 DO -- 数据条数
    INSERT INTO tb_variety_group (
        group_name, server, sort, foreign_group, create_time, create_user_id, update_time, update_user_id, del, display_settle
    )
    VALUES (
               CONCAT('Group ', i + 1),
               CONCAT('Server', i + 1),
               sort_value,
               i % 2,
               NOW(),
               100 + (i % 10),
               NOW(),
               200 + (i % 10),
               0,
               IF(i % 3 = 0, 'USD', 'EUR')
           );

    SET i = i + 1;
    SET sort_value = sort_value + 1;
        END WHILE;
END$$
DELIMITER ;
CALL InsertTestData();
-- 删除该存储过程插入的数据
DELETE FROM tb_variety_group
WHERE group_name LIKE 'Group %'
  AND server LIKE 'Server%';


-- ------------------------------------------------------
-- Ø  统计分析→佣金报表→代理佣金报表→下载报表
-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE InsertRebateAccountData()
BEGIN
    DECLARE i INT DEFAULT 80000000;
    DECLARE max_rows INT DEFAULT 60000; -- 数据条数
    WHILE i < 80000000 + max_rows DO
            INSERT INTO rebate_account (
                user_id, account, acc_rela_id, status, apply_type, balance, currency, audit_date, comments, create_time, update_time, audit_user_id, create_user_id, update_user_id, has_commission_rule, rebate_level, del, mark_time, bonus, merchant_id, gen_status, request_source
            )
            VALUES (
                       42582,
                       i, -- account
                       239,
                       1, 2, 0.00000000, 'EUR', NOW(), NULL, NOW(), NOW(),
                       1, 1, 1, 1, 1, 0, NULL, 0, NULL, 0, 1
                   );

            SET i = i + 1;
        END WHILE;
END$$
DELIMITER ;
CALL InsertRebateAccountData();
-- 查询数据
SELECT * FROM rebate_account
WHERE account BETWEEN 80000000 AND 80059999;
-- 删除该存储过程插入的数据
delete from rebate_account
where account between 80000000 and 80059999;


DELIMITER $$
CREATE PROCEDURE InsertCommissionData()
BEGIN
    DECLARE i INT DEFAULT 80000000;
    DECLARE max_rows INT DEFAULT 60000; -- 插入记录数
    WHILE i < 80000000 + max_rows DO
            INSERT INTO commission_base_ib_202412 (
                id, commission_ticket, user_id, account, ib_id, rebate_account, relation_type, parent_id, parent_account, commission, volume, close_time, ticket, cmd, symbol, close_price, profit, server, coefficient, rule_id, rate, commission_type, trade_group_id, `group`, system_group_id, rebate_currency, status, create_time, update_time, del, stock_volume, commission_usd, usd_rate
            )
            VALUES (
                       i, -- id
                       CONCAT(i),
                       42584,
                       10010158,
                       42582,
                       i, -- rebate_account 外键关联 rebate_account.account
                       1, 42582, 4500050, 0.10000000, 10, NOW(), 222113, 1, 'USDJPY', 154.816000, -4.8400,
                       6, 1.00, 25, 1.000000, 2, 3, 'M_OTE_0000_USD', 1, 'USD', 3, NOW(), NOW(), 0, 0.00000000, 0.10000000, 1.000000
                   );

            SET i = i + 1;
        END WHILE;
END$$
DELIMITER ;
CALL InsertCommissionData();
-- 查询数据
SELECT * FROM commission_base_ib_202412
WHERE id BETWEEN 80000000 AND 80059999;
-- 删除该存储过程插入的数据
DELETE FROM commission_base_ib_202412
WHERE id BETWEEN 80000000 AND 80059999;




-- ------------------------------------------------------
-- Ø  统计分析→佣金报表→佣金流水账单→下载报表
-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE InsertRebateBalanceChangeDetail()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE rand_detail_type INT;
    WHILE i <= 60000 DO -- 数据条数
    SET rand_detail_type = FLOOR(RAND() * 6) + 1;
    INSERT INTO rebate_balance_change_detail (
        user_id,
        rebate_account,
        detail_type,
        change_amount,
        surplus_amount,
        remarks,
        re_commission_id,
        create_time,
        update_time,
        commission_date,
        order_number
    )
    VALUES (
               42393,
               4500045,
               rand_detail_type,
               1.11110000,
               1.11110000,
               '巴拉巴拉巴拉巴拉',
               NULL,
               NOW(),
               NULL,
               NOW(),
               NULL
           );

    SET i = i + 1; -- 每次循环计数器加1
        END WHILE;
END$$
DELIMITER ;
CALL InsertRebateBalanceChangeDetail();
-- 查询数据
select * from rebate_balance_change_detail where remarks ="巴拉巴拉巴拉巴拉" and user_id=42393 and rebate_account=4500045;
-- 删除该存储过程插入的数据
delete   from rebate_balance_change_detail where remarks ="巴拉巴拉巴拉巴拉" and user_id=42393 and rebate_account=4500045;


-- ------------------------------------------------------
-- Ø  统计分析→销售提成报表→销售提成汇总表→下载报表
-- Ø  统计分析→销售提成报表→提成详情报表→下载报表
-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE InsertCommissionBaseSale()
BEGIN
    DECLARE i INT DEFAULT 80000000;
    DECLARE j INT DEFAULT 1;
    WHILE j <= 60000 DO -- 数据条数
    INSERT INTO commission_base_sale_202412 (
        id,
        commission_ticket,
        user_id,
        account,
        sale_id,
        parent_account,
        relation_type,
        commission,
        volume,
        close_time,
        ticket,
        cmd,
        symbol,
        close_price,
        profit,
        server,
        coefficient,
        sale_royalty_id,
        rate,
        commission_type,
        trade_group_id,
        `group`,
        system_group_id,
        status,
        create_time,
        update_time,
        del,
        stock_volume,
        temp_group
    )
    VALUES (
               i, -- id
               i, -- commission_ticket
               42508,
               10010139,
               i, -- sale_id
               4500045,
               1,
               0.10000000,
               10000,
               NOW(),
               '219581',
               1,
               'EURAUD+',
               1.654490,
               -131.3500,
               6,
               0.10,
               13,
               1.000000,
               1,
               3,
               'M_OTE_0000_USD',
               1,
               3,
               NOW(),
               NOW(),
               0,
               0.00000000,
               NULL
           );

    SET i = i + 1;
    SET j = j + 1;
        END WHILE;
END$$
DELIMITER ;
CALL InsertCommissionBaseSale();
-- 查询数据
select * from commission_base_sale_202412 where id >= 80000000 and id <= 80059999;
-- 删除该存储过程插入的数据
delete from commission_base_sale_202412 where id >= 80000000 and id <= 80059999;

DELIMITER $$
CREATE PROCEDURE InsertUserInnerData()
BEGIN
    DECLARE i INT DEFAULT 80000000; -- 起始 user_id
    DECLARE j INT DEFAULT 1;
    WHILE j <= 60000 DO -- 数据条数
    INSERT INTO user_inner (
        user_id, name, email, password, phone, del, create_time, create_user_id,
        update_time, update_user_id, royalty_confed, salt, invite_link_id,
        gen_user_id, auth_random_str, auth_status, last_login_time, cellxpert_signup_link, area_code
    )
    VALUES (
               i, 'GG', 'GG@dev.com', 'password', '15678909876', 0, NOW(), 1,
               NOW(), 1, 0, 'password', 6, NULL, NULL, 1, NULL, NULL, '+86'
           );

    SET i = i + 1; -- 每次插入后递增
    SET j = j + 1; -- 计数器递增
        END WHILE;
END$$
DELIMITER ;
CALL InsertUserInnerData();
-- 查询数据
select * from user_inner where user_id >= 80000000 and user_id <= 80059999;
-- 删除该存储过程插入的数据
delete from user_inner where user_id >= 80000000 and user_id <= 80059999;

DELIMITER $$
CREATE PROCEDURE InsertUserRelationData()
BEGIN
    DECLARE i INT DEFAULT 80000000; -- 起始 user_id
    DECLARE j INT DEFAULT 1;
    WHILE j <= 60000 DO -- 数据条数
    INSERT INTO user_relation (
        user_id, user_p_ids, user_inner_id, del, org_id, user_p_id
    )
    VALUES (
               i, ',0,', 40, 0, 1, 0
           );

    SET i = i + 1; -- 每次插入后递增
    SET j = j + 1; -- 计数器递增
        END WHILE;
END$$
DELIMITER ;
CALL InsertUserRelationData();
-- 查询数据
select * from user_relation where user_id >= 80000000 and user_id <= 80059999;
-- 删除该存储过程插入的数据
delete from user_relation where user_id >= 80000000 and user_id <= 80059999;


DELIMITER $$
CREATE PROCEDURE InsertUserRoleData()
BEGIN
    DECLARE i INT DEFAULT 80000000; -- 起始 user_id
    DECLARE j INT DEFAULT 1;
    WHILE j <= 60000 DO
            INSERT INTO user_role (
                user_id, role_id, del
            )
            VALUES (
                       i, 6, 0
                   );
            SET i = i + 1;
            SET j = j + 1;
        END WHILE;
END$$
DELIMITER ;
CALL InsertUserRoleData();
-- 查询数据
select * from user_role where user_id >= 80000000 and user_id <= 80059999;
-- 删除该存储过程插入的数据
delete from user_role where user_id >= 80000000 and user_id <= 80059999;




-- ------------------------------------------------------
-- Ø  账户管理→交易账户→【下载报表】 42615
-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE InsertTradeAccountBatch()
BEGIN
    DECLARE i BIGINT DEFAULT 80000000;
    DECLARE j INT DEFAULT 1;
    WHILE j <= 60000 DO -- 数据条数
    INSERT INTO trade_account (
        user_id, account, acc_rela_id, apply_type, mt4_password, status, server, `group`, platform, leverage, archived, archived_date,
        currency, audit_date, account_type, mam, create_time, update_time, audit_user_id, create_user_id, update_user_id, del,
        remark, invitation_code, mark_time, apply_date, binding, remote_ip, first_trade_time, auto_open_audited,
        read_only, is_change, first_deposit, trade_type, request_source, invite_code_real_time, same_remark
    )
    VALUES (
               42615,
               i, -- 每次递增的 account 值
               267,
               1,
               'ZcOR6vGa5h5-OeWTaYdF',
               1,
               7,
               'FSCA\\M_MNS_0000_EUR',
               2,
               500,
               0,
               NULL,
               'EUR',
               NOW(),
               2,
               0,
               NOW(),
               NOW(),
               1,
               80000000,
               1,
               0,
               '1',
               NULL,
               NULL,
               NOW(),
               0,
               '222.128.15.25',
               NULL,
               2,
               1,
               0,
               0,
               1,
               1,
               '',
               NULL
           );
    SET i = i + 1; -- 每次插入后递增 account
    SET j = j + 1; -- 循环计数器递增
        END WHILE;
END$$
DELIMITER ;
CALL InsertTradeAccountBatch();
-- 查询数据
select * from trade_account where account >= 80000000 and account <= 80059999;
-- 删除该存储过程插入的数据
delete from trade_account where account >= 80000000 and account <= 80059999;




-- ------------------------------------------------------
-- Ø  任务→账户审核→交易账户审核→人工审核、自动审核有数据
-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE InsertTradeAccountData()
BEGIN
    DECLARE i BIGINT DEFAULT 9000000;
    DECLARE j INT DEFAULT 1;
    WHILE j <= 60000 DO -- 数据条数
    INSERT INTO trade_account (
        user_id, account, acc_rela_id, apply_type, mt4_password, status, server, `group`, platform, leverage, archived, archived_date,
        currency, audit_date, account_type, mam, create_time, update_time, audit_user_id, create_user_id, update_user_id, del,
        remark, invitation_code, mark_time, apply_date, binding, remote_ip, first_trade_time, auto_open_audited,
        read_only, is_change, first_deposit, trade_type, request_source, invite_code_real_time, same_remark
    )
    VALUES (
               42540,
               i,
               293,
               2,
               '5dIWzGOq9HwaWb89hjn09A**',
               1,
               7,
               'FSCA\\M_MNS_0000_USD',
               2,
               500,
               0,
               NULL,
               'USD',
               NOW(),
               2,
               0,
               NOW(),
               NOW(),
               1,
               42540,
               1,
               0,
               '',
               '',
               NOW(),
               NOW(),
               0,
               '222.128.15.25',
               NULL,
               0,
               0,
               0,
               0,
               1,
               1,
               '',
               NULL
           );
    SET i = i + 1;
    SET j = j + 1;
        END WHILE;
END$$
DELIMITER ;
CALL InsertTradeAccountData();
-- 查询数据
select * from trade_account where account >= 9000000 and account <= 9059999;
-- 删除该存储过程插入的数据
delete   from trade_account where account >= 9000000 and account <= 9059999;


-- ------------------------------------------------------
-- Ø  统计分析→交易历史报表→交易历史详情→下载报表--已有数据
-- Ø  统计分析→佣金报表→订单详情报表→下载报表--已有数据
-- ------------------------------------------------------



-- Ø  统计分析→佣金报表→品种组佣金报表→下载报表
-- Ø  统计分析→佣金报表→代理佣金报表→下载报表
-- Ø  统计分析→佣金报表→佣金流水账单→下载报表
-- Ø  统计分析→销售提成报表→销售提成汇总表→下载报表
-- Ø  统计分析→销售提成报表→提成详情报表→下载报表
-- Ø  账户管理→交易账户→【下载报表】 42615
-- Ø  任务→账户审核→交易账户审核→人工审核、自动审核有数据
-- Ø  统计分析→交易历史报表→交易历史详情→下载报表--已有数据
-- Ø  统计分析→佣金报表→订单详情报表→下载报表--已有数据




