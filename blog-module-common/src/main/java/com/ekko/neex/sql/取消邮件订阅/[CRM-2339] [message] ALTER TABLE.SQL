-- --------------------------------------------------
--   Base  &  message
-- --------------------------------------------------
ALTER TABLE msg_template ADD COLUMN message_type INT COMMENT '消息类型:1-通知,2-营销' AFTER template_type;

UPDATE msg_template SET message_type = 1 WHERE message_type IS NULL;

CREATE TABLE `msg_template_footer` (
        `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
        `merchant_code` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
        `language` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '语言',
        `content` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '上下文模版',
        PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='模板页脚信息表';


INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('1', 'en_US', '<p>If you would like to unsubscribe from our mailing list,follow the <a href="${unsubscribeLink}">link</a></p>');
INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('1', 'zh_CN', '<p>如果您想退出我们的邮件订阅列表，请点击该<a href="${unsubscribeLink}">链接</a></p>');
INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('1', 'zh_TW', '<p>如果您想退出我們的郵件訂閱列表，請點擊該<a href="${unsubscribeLink}">鏈接</a></p>');

INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('11', 'en_US', '<p>If you would like to unsubscribe from our mailing list,follow the <a href="${unsubscribeLink}">link</a></p>');
INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('11', 'zh_CN', '<p>如果您想退出我们的邮件订阅列表，请点击该<a href="${unsubscribeLink}">链接</a></p>');
INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('11', 'zh_TW', '<p>如果您想退出我們的郵件訂閱列表，請點擊該<a href="${unsubscribeLink}">鏈接</a></p>');

INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('12', 'en_US', '<p>If you would like to unsubscribe from our mailing list,follow the <a href="${unsubscribeLink}">link</a></p>');
INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('12', 'zh_CN', '<p>如果您想退出我们的邮件订阅列表，请点击该<a href="${unsubscribeLink}">链接</a></p>');
INSERT INTO msg_template_footer (merchant_code, `language`, content) VALUES('12', 'zh_TW', '<p>如果您想退出我們的郵件訂閱列表，請點擊該<a href="${unsubscribeLink}">鏈接</a></p>');







