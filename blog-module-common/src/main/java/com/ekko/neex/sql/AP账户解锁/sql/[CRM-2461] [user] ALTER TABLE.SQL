ALTER TABLE user_trader
    ADD COLUMN is_locked BIT(1) NOT NULL DEFAULT b'0' COMMENT '是否锁定：0=解锁，1=锁定',
    ADD COLUMN locked_time DATETIME DEFAULT NULL COMMENT '用户被锁定时间，用于判断是否自动解锁';
