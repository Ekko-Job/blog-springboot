-- --------------------------------------------------
-- MWS & marketing      活动勾选详情表
-- --------------------------------------------------
CREATE TABLE activity_tick_details
(
    id              BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    activity_id     VARCHAR(255) NOT NULL COMMENT '活动序号',
    activity_title  VARCHAR(255) NOT NULL COMMENT '活动标题',
    user_id         VARCHAR(255) NOT NULL COMMENT '用户ID',
    ip_address      VARCHAR(255) NOT NULL COMMENT 'IP地址',
    operation_time  DATETIME     NOT NULL COMMENT '操作时间',
    browser_name    VARCHAR(255) NOT NULL COMMENT '浏览器名称',
    browser_version VARCHAR(255) NOT NULL COMMENT '浏览器版本',
    os              VARCHAR(255) NOT NULL COMMENT '操作系统',
    merchants_id    int          NOT NULL COMMENT '商户号'
) COMMENT '活动勾选详情表';

-- --------------------------------------------------
-- MWS & marketing      活动勾选详情关联交易账号表
-- --------------------------------------------------
CREATE TABLE activity_tick_details_account
(
    id                 BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    activity_detail_id BIGINT       NOT NULL COMMENT '活动勾选详情表ID',
    trade_account      VARCHAR(255) NOT NULL COMMENT '交易账号'
) COMMENT '活动勾选详情关联交易账号表';