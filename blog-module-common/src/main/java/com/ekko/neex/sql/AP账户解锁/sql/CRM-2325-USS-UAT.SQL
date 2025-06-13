-- uss sql
CREATE TABLE `merchants` (
                             `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `merchants_id` INT(10) UNSIGNED NOT NULL COMMENT '商户id',
                             `merchants_name` VARCHAR(255) NOT NULL COMMENT '商户名称',
                             `private_key` VARCHAR(2000) DEFAULT NULL COMMENT '私钥',
                             `public_key` VARCHAR(2000)  DEFAULT NULL COMMENT '公钥',
                             `is_del` TINYINT(3) DEFAULT '0' COMMENT '是否已删除',
                             `create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `update_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                             PRIMARY KEY (`id`)
) COMMENT='商户表';

INSERT INTO `merchants` (`id`, `merchants_id`, `merchants_name`, `private_key`, `public_key`, `is_del`, `create_time`, `update_time`)
VALUES (1, 20240001, 'Neex-pre',
        'MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAM/H8khyUgTnE7Bqr14ATSrHnaWsPyfqhtfHYzgT0lzp/mawBu4x5lYIwVbXVCVuRw8YZ6Xtrk17TWVq1hcxF10kgvPgTfJdJQRIBBiihOVqYYyNqAwVlyEGN/Fi7c1QMCMKnHZVHREl7cvjY5siAY4yj5yfGX3+3NqG+VUobXYnAgMBAAECgYAllk6Kc3/J2kFyDwKVVymefQjUMRIltuPYwf19ZfyOiVfXnK1MRqOb2a6b9o0Gzmm1Xd1WI2Z+JrmMCKUdAejvQZG4zkiAt6j0WznxS9QS66P4CkBou5fvi0nTtk8HVZgBbbbRHH3NeY8xf55AGwKEK/3sz1YM6fMMYGIo6ue3EQJBAO29c62K2ZiPq8X5BgUbzKFpXNcdS7pg9E8Ni1hm5+G7+TtfJsJttfjfLUruD7Dv7Od470NC4cMIjoSNzw8t7dECQQDfvW10hJsGuxy2Su8/+pknI/aHcq+ZjEk2wLL5rc3p5UeU/zZNVvxwKmXqxIR+aTKuYi7AU3UpGQ3M6/Rf3cp3AkEAoMcL0SRizcLz1vn3MUNAmzRnHe9pBE2HS2MMhqdpUAbQoW9TBhAuDXXY6qCeqflIDK6DmMhFZ6GEyG4ixtA30QJAcToeAE9zXO6oUyCM/2XEx+gNRPKnJx+1lX3jlTN995ZOqXqWcoFI80KhnTOikY6PVWzel/okWo4RS9lFLJbDdQJBALSTXm+fvc6oFknYebPvHml7f/xs2zIc30mphfU6CoJBZcCVs4zOM9EcOrJhx7jg2LRHnZUMwcmXLRGgvQ/Hc6U=',
        'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPx/JIclIE5xOwaq9eAE0qx52lrD8n6obXx2M4E9Jc6f5msAbuMeZWCMFW11QlbkcPGGel7a5Ne01latYXMRddJILz4E3yXSUESAQYooTlamGMjagMFZchBjfxYu3NUDAjCpx2VR0RJe3L42ObIgGOMo+cnxl9/tzahvlVKG12JwIDAQAB', 0, now(), now());


CREATE TABLE `user_base_info` (
                                  `id` int unsigned NOT NULL AUTO_INCREMENT,
                                  `merchant_id` varchar(32) DEFAULT NULL COMMENT '商户号',
                                  `user_id` int NOT NULL COMMENT '用户id',
                                  `first_name_local` varchar(64)   DEFAULT NULL COMMENT '名，基于国籍的写法',
                                  `last_name_local` varchar(64)   DEFAULT NULL COMMENT '姓，基于国籍的写法',
                                  `full_name_local` varchar(128)   DEFAULT '' COMMENT '完整姓名，基于国籍',
                                  `first_name_en` varchar(64)   DEFAULT '' COMMENT '名，国际通用英文写法',
                                  `last_name_en` varchar(64)   DEFAULT '' COMMENT '姓，国际通用英文写法',
                                  `full_name_en` varchar(128)   DEFAULT '' COMMENT '完整姓名，英文',
                                  `country` varchar(32) DEFAULT NULL COMMENT '所属国籍',
                                  `type` tinyint DEFAULT NULL COMMENT '用户类型，如ib，个人用户，见enum 6-员工用户，2-个人用户，8-意向客户，5-IB',
                                  `status` smallint NOT NULL COMMENT '用户申请状态，见enum （UserApplyStatus：1-myaccount注册完毕，2-账号设置完毕，3-交易评估完毕，4实名认证完毕，完善身份信息完毕，5-审核成功，6-审核失败，100-公司資訊，200-公司授權人資訊，300-公司負責人資訊）',
                                  `first_deposit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否进行过首次入金，0-否，1-是',
                                  `first_deposit_time` datetime DEFAULT NULL COMMENT '首次入金时间',
                                  `del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，1-是，0-否',
                                  `request_source` int NOT NULL DEFAULT '99' COMMENT 'request_source 类型见枚举RequestSourceEnum',
                                  `account_holder_type` varchar(20) DEFAULT NULL COMMENT '账户类别',
                                  `birthday` varchar(10)   DEFAULT NULL COMMENT '出生日期',
                                  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
                                  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                  `day` datetime DEFAULT NULL COMMENT '推送时间',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  KEY `idx_del` (`del`) USING BTREE COMMENT '索引删除标识'
) COMMENT='用户基础数据表';


CREATE TABLE `country` (
                           `id` int unsigned NOT NULL AUTO_INCREMENT,
                           `name_en` varchar(128)   NOT NULL COMMENT '国家名称-英文',
                           `name_cn` varchar(128)   NOT NULL COMMENT '国家名称-中文',
                           `code` varchar(50)   DEFAULT NULL,
                           `area_code` varchar(10)   DEFAULT NULL COMMENT '手机区号',
                           `code2` varchar(10)   DEFAULT NULL COMMENT '依照 ISO 3166-1 alpha-2 對應的國家簡碼',
                           `risk` tinyint DEFAULT NULL COMMENT '國家風險 1:低 2:中 3:高 4:Banned',
                           `risk_score` tinyint DEFAULT NULL COMMENT '風險係數',
                           `scb_risk` tinyint DEFAULT NULL COMMENT 'scb國家風險',
                           `risk_temp` tinyint DEFAULT NULL COMMENT '切換品牌用',
                           `is_risk` tinyint DEFAULT '0' COMMENT '高風險國家 1:是0:否',
                           `iso_alpha3` varchar(10)   DEFAULT NULL COMMENT '依照 ISO 3166-1 alpha-3 對應的國家簡碼',
                           `auto_issue` tinyint(1) DEFAULT NULL COMMENT '自動出金開關',
                           `max_amount` decimal(20,8) DEFAULT NULL COMMENT '自動出金限額',
                           PRIMARY KEY (`id`) USING BTREE,
                           KEY `country_code` (`code`) USING BTREE
) COMMENT='国家基础数据表';

INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (1, 'China', '中国', 'CHN', '+86', 'CN', 2, 2, 3, 2, 0, 'CHN', 0, 400.00000000);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (2, 'Albania', '阿尔巴尼亚', 'ALB', '+355', 'AL', 3, 10, 3, 3, 1, 'ALB', 1, 500.00000000);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (3, 'Algeria', '阿尔及利亚', 'ALG', '+213', 'DZ', 2, 2, 2, 3, 0, 'DZA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (4, 'Afghanistan', '阿富汗', 'AFG', '+93', 'AF', 3, 10, 4, 4, 0, 'AFG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (5, 'Argentina', '阿根廷', 'ARG', '+54', 'AR', 2, 2, 2, 3, 0, 'ARG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (6, 'United Arab Emirates', '阿拉伯联合酋长国', 'UAE', '+971', 'AE', 3, 10, 2, 3, 0, 'ARE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (7, 'Oman', '阿曼', 'OMN', '+968', 'OM', 1, 1, 1, 2, 0, 'OMN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (8, 'Azerbaijan', '阿塞拜疆', 'AZE', '+994', 'AZ', 2, 2, 3, 3, 0, 'AZE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (9, 'Egypt', '埃及', 'EGY', '+20', 'EG', 1, 1, 3, 3, 0, 'EGY', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (10, 'Ethiopia', '埃塞俄比亚', 'ETH', '+251', 'ET', 2, 2, 1, 3, 0, 'ETH', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (11, 'Ireland', '爱尔兰', 'IRL', '+353', 'IE', 1, 1, 1, 1, 0, 'IRL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (12, 'Estonia', '爱沙尼亚', 'EST', '+372', 'EE', 1, 1, 1, 1, 0, 'EST', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (13, 'Andorra', '安道尔', 'AND', '+376', 'AD', 1, 1, 1, 2, 0, 'AND', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (14, 'Angola', '安哥拉', 'ANG', '+244', 'AO', 2, 2, 2, 2, 0, 'AGO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (15, 'Australia', '澳大利亚', 'AUS', '+61', 'AU', 1, 1, 1, 4, 0, 'AUS', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (16, 'Austria', '奥地利', 'AUT', '+43', 'AT', 1, 1, 1, 1, 0, 'AUT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (17, 'Papua New Guinea', '巴布亚新几内亚', 'PNG', '+675', 'PG', 1, 1, 1, 2, 0, 'PNG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (18, 'Bahamas', '巴哈马', 'BAH', '+1242', 'BS', 3, 10, 3, 3, 0, 'BHS', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (19, 'Pakistan', '巴基斯坦', 'PAK', '+92', 'PK', 3, 10, 3, 3, 1, 'PAK', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (20, 'Paraguay', '巴拉圭', 'PAR', '+595', 'PY', 2, 2, 2, 3, 0, 'PRY', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (21, 'Bahrain', '巴林', 'BHR', '+973', 'BH', 1, 1, 1, 2, 0, 'BHR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (22, 'Panama', '巴拿马', 'PAN', '+507', 'PA', 3, 10, 3, 3, 1, 'PAN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (23, 'Brazil', '巴西', 'BRA', '+55', 'BR', 2, 2, 3, 3, 0, 'BRA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (24, 'Belarus', '白俄罗斯', 'BLR', '+375', 'BY', 2, 2, 3, 4, 1, 'BLR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (25, 'Bermuda', '百慕大', 'BMU', '+1441', 'BM', 1, 1, 1, 2, 0, 'BMU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (26, 'Bulgarian', '保加利亚', 'BUL', '+359', 'BG', 1, 1, 3, 3, 0, 'BGR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (27, 'Northern Mariana Islands', '北马里亚纳群岛', 'NMI', '+1670', 'MP', 1, 1, 3, 3, 0, 'MNP', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (28, 'Benin', '贝宁', 'BEN', '+229', 'BJ', 2, 2, 2, 3, 0, 'BEN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (29, 'Belgium', '比利时', 'BEL', '+32', 'BE', 2, 2, 3, 4, 0, 'BEL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (30, 'Iceland', '冰岛', 'ISL', '+354', 'IS', 1, 1, 2, 2, 0, 'ISL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (31, 'Puerto Rico', '波多黎各', 'PRO', '+1787', 'PR', 1, 1, 2, 3, 0, 'PRI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (32, 'Poland', '波兰', 'POL', '+48', 'PL', 1, 1, 1, 2, 0, 'POL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (33, 'Bolivia', '玻利维亚', 'BOL', '+591', 'BO', 2, 2, 3, 3, 0, 'BOL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (34, 'Bosnia and Herzegovina', '波斯尼亚和黑塞哥维那', 'BIH', '+387', 'BA', 2, 2, 3, 3, 0, 'BIH', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (35, 'Botswana', '博茨瓦纳', 'BOT', '+267', 'BW', 2, 2, 2, 3, 0, 'BWA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (36, 'Belize', '伯利兹', 'BIZ', '+501', 'BZ', 2, 2, 2, 3, 0, 'BLZ', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (37, 'Bhutan', '不丹', 'BHU', '+975', 'BT', 1, 1, 1, 2, 0, 'BTN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (38, 'Burkina Faso', '布基纳法索', 'BUR', '+226', 'BF', 3, 10, 1, 2, 0, 'BFA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (39, 'Burundi', '布隆迪', 'BDI', '+257', 'BI', 2, 2, 3, 4, 1, 'BDI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (40, 'Denmark', '丹麦', 'DEN', '+45', 'DK', 1, 1, 1, 1, 0, 'DNK', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (41, 'Deutschland', '德国', 'GER', '+49', 'DE', 1, 1, 3, 3, 0, 'DEU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (42, 'East Timor', '东帝汶', 'TLS', '+670', 'TL', 1, 1, 3, 3, 0, 'TLS', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (43, 'Togo', '多哥', 'TOG', '+228', 'TG', 1, 1, 1, 2, 0, 'TGO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (44, 'Dominica', '多米尼加', 'DMA', '+1767', 'DM', 2, 2, 2, 2, 0, 'DMA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (45, 'Dominican Republic', '多米尼加共和国', 'DOM', '+1890', 'DO', 2, 2, 2, 2, 0, 'DOM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (46, 'Russia', '俄罗斯', 'RUS', '+7', 'RU', 2, 2, 3, 3, 0, 'RUS', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (47, 'Ecuador', '厄瓜多尔', 'ECU', '+593', 'EC', 2, 2, 3, 3, 0, 'ECU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (48, 'Eritrea', '厄立特里亚', 'ERI', '+291', 'ER', 2, 2, 3, 3, 0, 'ERI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (49, 'France', '法国', 'FRA', '+33', 'FR', 1, 1, 1, 1, 0, 'FRA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (50, 'Faroe Islands', '法罗群岛', 'FIS', '+298', 'FO', 1, 1, 2, 2, 0, 'FRO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (51, 'French Polynesia', '法属波利尼西亚', 'FRE', '+689', 'PF', 1, 1, 1, 2, 0, 'PYF', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (52, 'Philippines', '菲律宾', 'PHI', '+63', 'PH', 3, 10, 3, 2, 1, 'PHL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (53, 'Fiji', '斐济', 'FIJ', '+679', 'FJ', 2, 2, 1, 2, 0, 'FJI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (54, 'Finland', '芬兰', 'FIN', '+358', 'FI', 1, 1, 1, 1, 0, 'FIN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (55, 'Cape Verde', '佛得角', 'CPV', '+238', 'CV', 2, 2, 2, 3, 0, 'CPV', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (56, 'Gambia', '冈比亚', 'GAM', '+220', 'GM', 2, 2, 2, 2, 0, 'GMB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (57, 'Colombia', '哥伦比亚', 'COL', '+57', 'CO', 2, 2, 2, 3, 0, 'COL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (58, 'Costa Rica', '哥斯达黎加', 'CRC', '+506', 'CR', 2, 2, 2, 3, 0, 'CRI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (59, 'Grenada', '格林纳达', 'GRN', '+1809', 'GD', 1, 1, 2, 2, 0, 'GRD', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (60, 'Greenland', '格陵兰', 'GRL', '+299', 'GL', 1, 1, 2, 2, 0, 'GRL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (61, 'Cuba', '古巴', 'CUB', '+53', 'CU', 4, 100, 3, 3, 1, 'CUB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (62, 'Guam', '关岛', 'GUM', '+671', 'GU', 2, 2, 2, 2, 0, 'GUM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (63, 'Guyana', '圭亚那', 'GUY', '+592', 'GY', 2, 2, 2, 3, 0, 'GUY', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (64, 'Kazakhstan', '哈萨克斯坦', 'KAZ', '+7', 'KZ', 2, 2, 2, 3, 0, 'KAZ', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (65, 'Haiti', '海地', 'HAI', '+509', 'HT', 3, 10, 3, 4, 1, 'HTI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (66, 'Netherlands', '荷兰', 'NED', '+31', 'NL', 2, 2, 1, 2, 0, 'NLD', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (67, 'Honduras', '洪都拉斯', 'HON', '+504', 'HN', 2, 2, 2, 2, 0, 'HND', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (68, 'Kiribati', '基里巴斯', 'KIR', '+686', 'KI', 1, 1, 2, 2, 0, 'KIR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (69, 'Djibouti', '吉布提', 'DJI', '+253', 'DJ', 2, 2, 2, 2, 0, 'DJI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (70, 'Kyrgyzstan', '吉尔吉斯斯坦', 'KGZ', '+996', 'KG', 2, 2, 2, 3, 0, 'KGZ', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (71, 'Guinea', '几内亚', 'GUI', '+224', 'GN', 2, 2, 2, 4, 0, 'GIN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (72, 'Guinea-Bissau', '几内亚比绍', 'GNB', '+245', 'GW', 3, 10, 4, 4, 1, 'GNB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (73, 'Canada', '加拿大', 'CAN', '+1', 'CA', 2, 2, 3, 4, 0, 'CAN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (74, 'Ghana', '加纳', 'GHA', '+233', 'GH', 3, 10, 3, 3, 0, 'GHA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (75, 'Gabon', '加蓬', 'GAB', '+241', 'GA', 2, 2, 1, 2, 0, 'GAB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (76, 'Cambodia', '柬埔寨', 'CAM', '+855', 'KH', 3, 10, 3, 3, 1, 'KHM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (77, 'Czech Republic', '捷克共和国', 'CZE', '+420', 'CZ', 1, 1, 1, 1, 0, 'CZE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (78, 'Zimbabwe', '津巴布韦', 'ZIM', '+263', 'ZW', 3, 10, 3, 4, 1, 'ZWE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (79, 'Cameroon', '喀麦隆', 'CMR', '+237', 'CM', 2, 2, 1, 2, 0, 'CMR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (80, 'Qatar', '卡塔尔', 'QAT', '+974', 'QA', 1, 1, 1, 2, 0, 'QAT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (81, 'Cayman Islands', '开曼群岛', 'CYM', '+1345', 'KY', 3, 10, 2, 2, 0, 'CYM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (82, 'Comoros', '科摩罗', 'COM', '+269', 'KM', 2, 2, 2, 2, 0, 'COM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (83, 'Kuwait', '科威特', 'KUW', '+965', 'KW', 1, 1, 1, 2, 0, 'KWT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (84, 'Kenya', '肯尼亚', 'KEN', '+254', 'KE', 2, 2, 2, 3, 0, 'KEN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (85, 'Cook Islands', '库克群岛', 'COK', '+682', 'CK', 1, 1, 1, 2, 0, 'COK', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (86, 'Latvia', '拉脱维亚', 'LAT', '+371', 'LV', 1, 1, 1, 2, 0, 'LVA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (87, 'Lesotho', '莱索托', 'LES', '+266', 'LS', 1, 1, 1, 2, 0, 'LSO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (88, 'Laos', '老挝', 'LAO', '+856', 'LA', 2, 2, 3, 3, 0, 'LAO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (89, 'Lebanon', '黎巴嫩', 'LIB', '+961', 'LB', 2, 2, 3, 3, 1, 'LBN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (90, 'Liberia', '利比里亚', 'LBR', '+231', 'LR', 2, 2, 3, 3, 0, 'LBR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (91, 'Libya', '利比亚', 'LBA', '+218', 'LY', 3, 10, 3, 3, 1, 'LBY', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (92, 'Lithuania', '立陶宛', 'LTU', '+370', 'LT', 1, 1, 1, 2, 0, 'LTU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (93, 'Liechtenstein', '列支敦士登', 'LIE', '+41 75', 'LI', 1, 1, 1, 2, 0, 'LIE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (94, 'Luxembourg', '卢森堡', 'LUX', '+352', 'LU', 1, 1, 1, 1, 0, 'LUX', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (95, 'Rwanda', '卢旺达', 'RWA', '+250', 'RW', 1, 1, 1, 2, 0, 'RWA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (96, 'Romania', '罗马尼亚', 'ROM', '+40', 'RO', 1, 1, 1, 2, 0, 'ROU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (97, 'Madagascar', '马达加斯加', 'MAD', '+261', 'MG', 3, 10, 1, 2, 0, 'MDG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (98, 'Maldives', '马尔代夫', 'MDV', '+960', 'MV', 1, 1, 2, 2, 0, 'MDV', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (99, 'Malta', '马耳他', 'MLT', '+356', 'MT', 3, 10, 1, 2, 0, 'MLT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (100, 'Malawi', '马拉维', 'MAW', '+265', 'MW', 2, 2, 1, 2, 0, 'MWI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (101, 'Malaysia', '马来西亚', 'MYS', '+60', 'MY', 2, 2, 2, 2, 0, 'MYS', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (102, 'Mali', '马里', 'MLI', '+223', 'ML', 3, 10, 3, 4, 1, 'MLI', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (103, 'Macedonia', '马其顿', 'MKD', '+389', 'MK', 1, 1, 1, 2, 0, 'MKD', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (104, 'Marshall Islands', '马绍尔群岛', 'RMI', '+692', 'MH', 1, 1, 1, 2, 0, 'MHL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (105, 'Mauritius', '毛里求斯', 'MRI', '+230', 'MU', 2, 2, 2, 3, 0, 'MUS', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (106, 'Mauritania', '毛里塔尼亚', 'MTN', '+222', 'MR', 2, 2, 1, 2, 0, 'MRT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (107, 'United States', '美国', 'USA', '+1', 'US', 2, 2, 3, 4, 0, 'USA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (109, 'Mongolia', '蒙古', 'MGL', '+976', 'MN', 2, 2, 2, 3, 0, 'MNG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (110, 'Micronesia', '密克罗尼西亚', 'MIA', '+691', 'FM', 1, 1, 1, 3, 0, 'FSM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (111, 'Peru', '秘鲁', 'PER', '+51', 'PE', 2, 2, 2, 2, 0, 'PER', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (112, 'Myanmar', '缅甸', 'MYA', '+95', 'MM', 4, 100, 3, 4, 1, 'MMR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (113, 'Moldova', '摩尔多瓦', 'MDA', '+373', 'MD', 1, 1, 2, 3, 0, 'MDA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (114, 'Morocco', '摩洛哥', 'MAR', '+212', 'MA', 3, 10, 3, 2, 1, 'MAR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (115, 'Monaco', '摩纳哥', 'MON', '+377', 'MC', 1, 1, 1, 2, 0, 'MCO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (116, 'Mozambique', '莫桑比克', 'MOZ', '+258', 'MZ', 3, 10, 2, 3, 0, 'MOZ', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (117, 'Mexico', '墨西哥', 'MEX', '+52', 'MX', 2, 2, 2, 2, 0, 'MEX', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (118, 'Namibia', '纳米比亚', 'NAM', '+264', 'NA', 1, 1, 1, 2, 0, 'NAM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (119, 'South Africa', '南非', 'RSA', '+27', 'ZA', 1, 1, 2, 2, 0, 'ZAF', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (120, 'Antarctica', '南极洲', 'NJZ', '+672', 'AQ', 1, 1, 3, 3, 0, 'ATA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (121, 'Nauru', '瑙鲁', 'NRU', '+674', 'NR', 1, 1, 1, 2, 0, 'NRU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (122, 'Nepal', '尼泊尔', 'NEP', '+977', 'NP', 1, 1, 1, 3, 0, 'NPL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (123, 'Nicaragua', '尼加拉瓜', 'NCA', '+505', 'NI', 3, 10, 3, 3, 1, 'NIC', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (124, 'Niger', '尼日尔', 'NIG', '+227', 'NE', 1, 1, 1, 2, 0, 'NER', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (125, 'Nigeria', '尼日利亚', 'NGA', '+234', 'NG', 2, 2, 3, 3, 0, 'NGA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (126, 'Norway', '挪威', 'NOR', '+47', 'NO', 1, 1, 1, 1, 0, 'NOR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (127, 'Palau', '帕劳群岛', 'PAU', '+680', 'PW', 2, 2, 2, 2, 0, 'PLW', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (128, 'Portugal', '葡萄牙', 'POR', '+351', 'PT', 1, 1, 3, 1, 0, 'PRT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (129, 'Georgia', '乔治亚', 'GEO', '+995', 'GE', 1, 1, 1, 2, 0, 'GEO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (130, 'Japan', '日本', 'JPN', '+81', 'JP', 1, 1, 3, 4, 0, 'JPN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (131, 'Sweden', '瑞典', 'SWE', '+46', 'SE', 1, 1, 1, 2, 0, 'SWE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (132, 'Switzerland', '瑞士', 'SUI', '+41', 'CH', 1, 1, 1, 1, 0, 'CHE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (133, 'El Salvador', '萨尔瓦多', 'ESA', '+503', 'SV', 2, 2, 2, 2, 0, 'SLV', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (134, 'Serbia', '塞尔维亚,黑山', 'SCG', '+381', 'RS', 1, 1, 3, 3, 0, 'SRB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (135, 'Sierra Leone', '塞拉利昂', 'SLE', '+232', 'SL', 1, 1, 2, 3, 0, 'SLE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (136, 'Senegal', '塞内加尔', 'SEN', '+221', 'SN', 3, 10, 2, 3, 0, 'SEN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (137, 'Cyprus', '塞浦路斯', 'CYP', '+357', 'CY', 2, 2, 2, 4, 0, 'CYP', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (138, 'Seychelles', '塞舌尔', 'SEY', '+248', 'SC', 1, 1, 2, 3, 0, 'SYC', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (139, 'Saudi Arabia', '沙特阿拉伯', 'KSA', '+966', 'SA', 1, 1, 2, 2, 0, 'SAU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (140, 'Sao Tome and Principe', '圣多美和普林西比', 'STP', '+239', 'ST', 1, 1, 2, 2, 0, 'STP', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (141, 'Saint Lucia', '圣卢西亚', 'SLA', '+1758', 'LC', 2, 2, 2, 2, 0, 'LCA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (142, 'San Marino', '圣马力诺', 'SMR', '+378', 'SM', 1, 1, 1, 2, 0, 'SMR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (143, 'Saint Vincent and the Grenadines', '圣文森特和格林纳丁斯', 'VIN', '+1784', 'VC', 2, 2, 2, 2, 0, 'VCT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (144, 'Sri Lanka', '斯里兰卡', 'SRI', '+94', 'LK', 2, 2, 1, 3, 0, 'LKA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (145, 'Slovakia', '斯洛伐克', 'SVK', '+421', 'SK', 1, 1, 1, 2, 0, 'SVK', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (146, 'Slovenia', '斯洛文尼亚', 'SLO', '+386', 'SI', 1, 1, 1, 2, 0, 'SVN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (147, 'Swaziland', '斯威士兰', 'SWZ', '+268', 'SZ', 1, 1, 1, 2, 0, 'SWZ', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (148, 'Sudan', '苏丹', 'SUD', '+249', 'SD', 3, 10, 3, 4, 1, 'SDN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (149, 'Surinam', '苏里南', 'SUR', '+597', 'SR', 2, 2, 3, 3, 0, 'SUR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (150, 'Solomon Islands', '所罗门群岛', 'SOL', '+677', 'SB', 2, 2, 1, 2, 0, 'SLB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (151, 'Somalia', '索马里', 'SOM', '+252', 'SO', 3, 10, 3, 4, 1, 'SOM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (152, 'Tajikistan', '塔吉克斯坦', 'TJK', '+992', 'TJ', 2, 2, 2, 3, 0, 'TJK', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (153, 'Thailand', '泰国', 'THA', '+66', 'TH', 2, 2, 2, 3, 0, 'THA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (154, 'Tanzania', '坦桑尼亚', 'TAN', '+255', 'TZ', 2, 2, 2, 3, 0, 'TZA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (155, 'Tonga', '汤加', 'TGA', '+676', 'TO', 1, 1, 1, 2, 0, 'TON', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (156, 'Trinidad and Tobago', '特立尼达和多巴哥', 'TRI', '+1809', 'TT', 3, 10, 3, 3, 0, 'TTO', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (157, 'Tunisia', '突尼斯', 'TUN', '+216', 'TN', 1, 1, 3, 3, 0, 'TUN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (158, 'Tuvalu', '图瓦卢', 'TUV', '+688', 'TV', 1, 1, 2, 2, 0, 'TUV', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (159, 'Turkey', '土耳其', 'TUR', '+90', 'TR', 3, 10, 2, 3, 1, 'TUR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (160, 'Turkmenistan', '土库曼斯坦', 'TKM', '+993', 'TM', 2, 2, 2, 3, 0, 'TKM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (161, 'Vanuatu', '瓦努阿图', 'VAN', '+678', 'VU', 3, 10, 3, 3, 0, 'VUT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (162, 'Guatemala', '危地马拉', 'GUA', '+502', 'GT', 2, 2, 2, 2, 0, 'GTM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (163, 'Virgin Islands, US', '维尔京群岛，美属', 'VIU', '+1340', 'VI', 2, 2, 3, 3, 0, 'VIR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (164, 'Virgin Islands, British', '维尔京群岛，英属', 'VIB', '+1809', 'VG', 2, 2, 3, 3, 0, 'VGB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (165, 'Venezuela', '委内瑞拉', 'VEN', '+58', 'VE', 3, 10, 3, 3, 1, 'VEN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (166, 'Brunei', '文莱', 'BRU', '+673', 'BN', 1, 1, 3, 3, 0, 'BRN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (167, 'Uganda', '乌干达', 'UGA', '+256', 'UG', 3, 10, 3, 4, 0, 'UGA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (168, 'Ukraine', '乌克兰', 'UKR', '+380', 'UA', 2, 2, 3, 3, 0, 'UKR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (169, 'Uruguay', '乌拉圭', 'URU', '+598', 'UY', 1, 1, 2, 2, 0, 'URY', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (170, 'Uzbekistan', '乌兹别克斯坦', 'UZB', '+998', 'UZ', 2, 2, 2, 3, 0, 'UZB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (171, 'Spain', '西班牙', 'ESP', '+34', 'ES', 2, 2, 1, 4, 0, 'ESP', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (172, 'Greece', '希腊', 'GRE', '+30', 'GR', 1, 1, 1, 2, 0, 'GRC', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (173, 'Singapore', '新加坡', 'SIN', '+65', 'SG', 1, 1, 1, 2, 0, 'SGP', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (174, 'New Zealand', '新西兰', 'NZL', '+64', 'NZ', 1, 1, 1, 1, 0, 'NZL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (175, 'Hungary', '匈牙利', 'HUN', '+36', 'HU', 1, 1, 1, 2, 0, 'HUN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (176, 'Syria', '叙利亚', 'SYR', '+963', 'SY', 3, 10, 3, 3, 1, 'SYR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (177, 'Jamaica', '牙买加', 'JAM', '+1876', 'JM', 3, 10, 3, 3, 1, 'JAM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (178, 'Armenia', '亚美尼亚', 'ARM', '+374', 'AM', 2, 2, 2, 3, 0, 'ARM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (179, 'Yemen', '也门', 'YEM', '+967', 'YE', 4, 100, 3, 4, 1, 'YEM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (180, 'Iraq', '伊拉克', 'IRQ', '+964', 'IQ', 3, 10, 3, 4, 1, 'IRQ', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (181, 'Iran', '伊朗', 'IRI', '+98', 'IR', 4, 100, 3, 3, 0, 'IRN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (182, 'Israel', '以色列', 'ISR', '+972', 'IL', 1, 1, 3, 4, 0, 'ISR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (183, 'Italy', '意大利', 'ITA', '+39', 'IT', 2, 2, 3, 4, 0, 'ITA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (184, 'India', '印度', 'IND', '+91', 'IN', 2, 2, 3, 2, 0, 'IND', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (185, 'Indonesia', '印度尼西亚', 'INA', '+62', 'ID', 2, 2, 2, 2, 0, 'IDN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (186, 'United Kingdom', '英国', 'GBR', '+44', 'GB', 2, 2, 3, 1, 0, 'GBR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (187, 'Jordan', '约旦', 'JOR', '+962', 'JO', 3, 10, 2, 2, 1, 'JOR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (188, 'Vietnam', '越南', 'VNM', '+84', 'VN', 2, 2, 2, 3, 0, 'VNM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (189, 'Zambia', '赞比亚', 'ZAM', '+260', 'ZM', 2, 2, 1, 2, 0, 'ZMB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (190, 'Chad', '乍得', 'CHA', '+235', 'TD', 2, 2, 1, 2, 0, 'TCD', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (191, 'Chile', '智利', 'CHI', '+56', 'CL', 1, 1, 1, 1, 0, 'CHL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (192, 'Central African Republic', '中非共和国', 'CAF', '+236', 'CF', 3, 10, 4, 4, 0, 'CAF', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (193, 'American Samoa', '美国萨摩亚', 'ASA', '+1684', 'AS', 2, 2, 1, 2, 0, 'ASM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (194, 'Bangladesh', '孟加拉国', 'BAN', '+880', 'BD', 2, 2, 2, 2, 0, 'BGD', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (195, 'Congo, Democratic Republic of the', '\n刚果民主共和国', 'COD', '+243', 'CD', 3, 10, 3, 3, 0, 'COD', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (196, 'Congo, Republic of the', '刚果共和国', 'CGO', '+242', 'CG', 2, 2, 3, 3, 1, 'COG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (197, 'Equatorial Guinea', '赤道几内亚', 'GNQ', '+240', 'GQ', 2, 2, 2, 3, 0, 'GNQ', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (198, 'Hong Kong', '香港', 'HKG', '+852', 'HK', 2, 2, 3, 4, 0, 'HKG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (199, 'Kosovo', '科索沃', 'KSO', '+383', NULL, 1, 1, 2, 3, 0, NULL, 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (200, 'Montenegro', '黑山', 'MGO', '+382', 'ME', 1, 1, 2, 2, 0, 'MNE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (201, 'North Korea', '朝鲜', 'PRK', '+850', 'KP', 4, 100, 3, 3, 0, 'PRK', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (202, 'Palestine', '巴勒斯坦', 'PLE', '+970', 'PS', 1, 1, 3, 3, 0, 'PSE', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (203, 'Saint Kitts and Nevis', '尼维斯', 'SKN', '+1869', 'KN', 2, 2, 2, 2, 0, 'KNA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (204, 'Sint Maarten', '荷属圣马丁', 'SMN', '+1721', 'SX', 2, 2, 2, 2, 1, 'SXM', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (205, 'South Korea', '韩国', 'KOR', '+82', 'KR', 1, 1, 1, 3, 0, 'KOR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (207, 'Taiwan', '台湾', 'TWN', '+886', 'TW', 1, 1, 1, 2, 0, 'TWN', 1, 300.00000000);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (208, 'Vatican City', '梵蒂冈城', 'VAT', '+379', 'VA', 1, 1, 3, 3, 0, 'VAT', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (209, 'Côte d\'Ivoire', '象牙海岸', 'CDE', '+225', 'CI', 1, 1, 3, 3, 0, 'CIV', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (210, 'Barbados', '巴巴多斯', 'BAR', '+1246', 'BB', 3, 10, 3, 3, 1, 'BRB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (211, 'Antigua and Barbuda', '安提瓜和巴布达岛', 'ANT', '+1268', 'AG', 2, 2, 3, 3, 0, 'ATG', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (212, 'Macao', '澳门', 'MAC', '+853', 'MO', 2, 2, 2, 2, 0, 'MAC', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (213, 'Other', '其他', 'OTHER', '', NULL, 1, 1, 3, 3, 0, NULL, 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (214, 'The Republic of Croatia', '克罗地亚', 'HRV', '+385', 'HR', 1, 1, 3, 3, 0, 'HRV', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (215, 'Anguilla', '安圭拉', 'AIA', '+1264', 'AI', 1, 1, 1, 2, 0, 'AIA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (216, 'Aruba', '阿鲁巴', 'ABW', '+297', 'AW', 2, 2, 2, 3, 0, 'ABW', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (217, 'Curacao', '库拉索', 'CUW', '+5999', 'CW', 2, 2, 2, 3, 0, 'CUW', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (218, 'Gaza Strip', '加萨走廊', 'PS', '+970', NULL, 1, 1, 3, 3, 1, NULL, 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (219, 'Gibraltar', '直布罗陀', 'GIB', '+350', 'GI', 1, 1, 1, 2, 0, 'GIB', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (220, 'Guernsey', '根西', 'GGY', '+44', 'GG', 1, 1, 1, 2, 0, 'GGY', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (221, 'Isle of Man', '马恩岛', 'IMN', '+44', 'IM', 1, 1, 1, 2, 0, 'IMN', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (222, 'Jersey', '泽西', 'JEY', '+44', 'JE', 1, 1, 1, 2, 0, 'JEY', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (223, 'Montserrat', '蒙塞拉特', 'MSR', '+1664', 'MS', 1, 1, 1, 2, 0, 'MSR', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (224, 'Niue', '紐埃', 'NIU', '+683', 'NU', 1, 1, 1, 2, 0, 'NIU', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (226, 'South Sudan', '南苏丹', 'SSD', '', 'SS', 3, 10, 3, 4, 1, 'SSD', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (228, 'Turks & Caicos', '特克斯和凯科斯群岛', 'TCA', '+1649', 'TC', 1, 1, 1, 3, 0, 'TCA', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (229, 'West Bank(Palestinian Territory, Occupation)', '约旦河西岸', 'WB', '', NULL, 1, 1, 3, 3, 1, NULL, 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (231, 'High Risk', '高风险', 'HRSK', '', 'HRSK', 3, NULL, 3, 2, 1, NULL, 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (232, 'NEW CALEDONIA', '法属新喀里多尼亚', 'NCL', '+687', 'NC', 2, 2, NULL, NULL, 0, 'NCL', 0, NULL);
INSERT INTO `country` (`id`, `name_en`, `name_cn`, `code`, `area_code`, `code2`, `risk`, `risk_score`, `scb_risk`, `risk_temp`, `is_risk`, `iso_alpha3`, `auto_issue`, `max_amount`) VALUES (233, 'Martinique', '马提尼克岛', 'MTQ', '+596', 'MQ', 2, 2, NULL, NULL, 0, 'MTQ', 0, NULL);


CREATE TABLE `account_group` (
                                 `id` int unsigned NOT NULL AUTO_INCREMENT,
                                 `merchant_id` varchar(32) DEFAULT NULL,
                                 `user_id` int DEFAULT NULL,
                                 `account` int DEFAULT NULL,
                                 `symbol` varchar(64) DEFAULT NULL,
                                 `group_id` int DEFAULT NULL,
                                 `day` datetime DEFAULT NULL,
                                 PRIMARY KEY (`id`)
) COMMENT='账户产品组';


CREATE TABLE `account_base_info` (
                                     `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                     `merchant_id` varchar(32) DEFAULT NULL COMMENT '商户号',
                                     `user_id` int NOT NULL COMMENT '用户id',
                                     `account` int DEFAULT NULL COMMENT '账号',
                                     `server` int DEFAULT NULL COMMENT 'server',
                                     `p_user_id` int DEFAULT '0' COMMENT '上级user_id',
                                     `p_rebate` int DEFAULT '0' COMMENT '返佣账号',
                                     `sales` int DEFAULT '0' COMMENT '末级销售',
                                     `org_id` int DEFAULT '0' COMMENT '所属组织id',
                                     `p_rebates` varchar(256) DEFAULT '' COMMENT '上级返佣账号链',
                                     `type` tinyint DEFAULT NULL COMMENT '账号类型，3-返佣和1-交易',
                                     `apply_type` tinyint DEFAULT '0' COMMENT '1:同名  2:主账号',
                                     `rebate_group_id` varchar(256) DEFAULT NULL COMMENT '返佣组id',
                                     `client_type` tinyint DEFAULT NULL COMMENT '客户类型 1-RC  2-IB  3-IBC',
                                     `first_deposit_time` datetime DEFAULT NULL COMMENT '首次入金时间',
                                     `first_trade_time` datetime DEFAULT NULL COMMENT '首次交易时间',
                                     `kyc_success_time` datetime DEFAULT NULL COMMENT 'kyc成功的时间',
                                     `is_commssion` tinyint DEFAULT NULL COMMENT '收否有收到佣金',
                                     `create_time` datetime DEFAULT NULL COMMENT '账户创建时间',
                                     `update_time` datetime DEFAULT NULL COMMENT '账户更新时间',
                                     `change_json` varchar(255) DEFAULT NULL COMMENT '账户上级变化的最新一次记录',
                                     `cloud_id` bigint DEFAULT NULL COMMENT '对应cloud的id',
                                     `ib_invitation_codes` varchar(128) DEFAULT NULL COMMENT 'IB邀请码，逗号分割',
                                     `sys_groups` varchar(128) DEFAULT NULL COMMENT '系统组名称，逗号分割',
                                     `group` varchar(32) DEFAULT NULL COMMENT '交易组',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     KEY `INDEX_USER_ID` (`user_id`) USING BTREE,
                                     KEY `INDEX_SALES` (`sales`) USING BTREE
) COMMENT='账号基础信息';


CREATE TABLE `account_base_mix` (
                                    `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                    `merchant_id` varchar(32) NOT NULL COMMENT '商户号',
                                    `user_id` int NOT NULL COMMENT '用户id',
                                    `account` int NOT NULL COMMENT '账号',
                                    `type` tinyint NOT NULL COMMENT '账号类型：3-返佣和1-交易',
                                    `first_deposit` decimal(20,2) DEFAULT NULL COMMENT '首次入金金额',
                                    `first_deposit_time` datetime DEFAULT NULL COMMENT '首次入金时间',
                                    `first_deposit_channel_id` int DEFAULT NULL COMMENT '首次入金渠道ID',
                                    `first_deposit_channel_name` varchar(32) DEFAULT NULL COMMENT '首次入金渠道名称',
                                    `first_trade_symbol` varchar(16) DEFAULT NULL COMMENT '首次交易产品',
                                    `first_trade_time` datetime DEFAULT NULL COMMENT '首次交易时间',
                                    `recent_deposit` decimal(20,2) DEFAULT NULL COMMENT '最近入金金额',
                                    `recent_deposit_time` datetime DEFAULT NULL COMMENT '最近入金时间',
                                    `recent_deposit_channel_id` int DEFAULT NULL COMMENT '最近入金渠道',
                                    `recent_deposit_channel_name` varchar(32) DEFAULT NULL COMMENT '最近入金渠道',
                                    `recent_trade_symbol` varchar(16) DEFAULT NULL COMMENT '最近交易产品',
                                    `recent_trade_time` datetime DEFAULT NULL COMMENT '最近交易时间',
                                    `cumulative_trade_num` int DEFAULT NULL COMMENT '累计交易次数',
                                    `cumulative_trade_volume` int DEFAULT NULL COMMENT '累计交易量',
                                    `total_deposit_num` int DEFAULT NULL COMMENT '总入金次数',
                                    `cumulative_deposit` decimal(20,2) DEFAULT NULL COMMENT '累计入金金额',
                                    `close_pnl` decimal(20,2) DEFAULT NULL COMMENT 'close pnl',
                                    `total_withdraw_num` int DEFAULT NULL COMMENT '总出金次数',
                                    `cumulative_withdraw` decimal(20,2) DEFAULT NULL COMMENT '累计出金金额',
                                    `first_commission` decimal(38,8) DEFAULT NULL COMMENT '首次返佣金额',
                                    `first_commission_time` datetime DEFAULT NULL COMMENT '首次返佣时间',
                                    `recent_commission` decimal(38,8) DEFAULT NULL COMMENT '最近返佣金额',
                                    `recent_commission_time` datetime DEFAULT NULL COMMENT '最近返佣时间',
                                    `cumulative_commission_num` int DEFAULT NULL COMMENT '累计返佣次数',
                                    `cumulative_commission` decimal(38,8) DEFAULT NULL COMMENT '累计返佣金额',
                                    `waiting_audit_commission` decimal(38,8) DEFAULT NULL COMMENT '待审核佣金',
                                    `create_time` datetime NOT NULL COMMENT '创建时间',
                                    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE KEY `INDEX_ACCOUNT` (`account`) USING BTREE,
                                    KEY `INDEX_USER_ID` (`user_id`) USING BTREE,
                                    KEY `INDEX_MERCHANT_ID` (`merchant_id`) USING BTREE
) COMMENT='账号MIX信息';


CREATE TABLE `account_balance` (
                                   `id` int unsigned NOT NULL AUTO_INCREMENT,
                                   `merchant_id` int DEFAULT NULL,
                                   `user_id` int DEFAULT NULL,
                                   `account` int DEFAULT NULL COMMENT '账号',
                                   `account_balance` decimal(20,2) DEFAULT '0.00' COMMENT '交易账户余额合计',
                                   `account_equity` decimal(20,2) DEFAULT '0.00' COMMENT '交易账户净值合计',
                                   `account_credit` decimal(20,2) DEFAULT '0.00' COMMENT '交易账户赠金合计',
                                   `rebate_account_balance` decimal(38,8) DEFAULT '0.00000000' COMMENT '返佣账户佣金余额合计',
                                   `day` date DEFAULT NULL,
                                   PRIMARY KEY (`id`) USING BTREE,
                                   KEY `IDX_ACCOUNT` (`account`)
) COMMENT='账户余额信息表';


CREATE TABLE `account_amount_trade` (
                                        `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
                                        `merchant_id` varchar(32) NOT NULL COMMENT '商户号',
                                        `sale_id` bigint NOT NULL COMMENT '销售ID',
                                        `org_id` bigint NOT NULL COMMENT '组织id',
                                        `server_id` int NOT NULL COMMENT 'server',
                                        `user_id` int NOT NULL COMMENT '用户id',
                                        `account` bigint NOT NULL COMMENT '账号',
                                        `rebate_account` bigint DEFAULT NULL COMMENT '返佣账号',
                                        `account_type` int DEFAULT NULL COMMENT '1交易账户 3返佣账户',
                                        `client_type` tinyint DEFAULT '1' COMMENT '1RC  2IB  3IBC',
                                        `total_deposit_amount` decimal(20,2) DEFAULT '0.00' COMMENT '入金金额（成功订单）',
                                        `total_withdrawal_amount` decimal(20,2) DEFAULT '0.00' COMMENT '出金金额（成功订单）',
                                        `total_net_deposit_amount` decimal(20,2) DEFAULT '0.00' COMMENT '净入金金额（入金-出金）',
                                        `total_volume` bigint DEFAULT '0' COMMENT '交易量/交易手数（平仓）',
                                        `total_pnl` decimal(38,6) DEFAULT '0.000000' COMMENT '平仓PNL',
                                        `total_swap` decimal(38,8) DEFAULT NULL COMMENT 'swap',
                                        `is_commssion` tinyint DEFAULT NULL COMMENT '是否收到佣金',
                                        `account_kyc_time` datetime DEFAULT NULL COMMENT '账户创建时间',
                                        `day` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '统计日期',
                                        `total_commission` decimal(38,8) DEFAULT '0.00000000' COMMENT '总佣金',
                                        PRIMARY KEY (`id`),
                                        KEY `IDX_USER_ID` (`user_id`)
) COMMENT='账户每日金额交易统计表';


CREATE TABLE `user_trader_server`  (
                                       `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
                                       `server` int NOT NULL  COMMENT '服务器',
                                       `name` varchar(32) NOT NULL COMMENT '服务器名称',
                                       `platform` int NULL DEFAULT NULL COMMENT '平台',
                                       `sort` int NULL DEFAULT NULL COMMENT '排序',
                                       `del` TINYINT(3) DEFAULT '0' COMMENT '是否已删除',
                                       `merchant_id` VARCHAR(4) NULL DEFAULT NULL COMMENT 'merchant_id',
                                       PRIMARY KEY (`id`) USING BTREE
) COMMENT = 'crm服务器表';

INSERT INTO `user_trader_server` (`id`, `server`, `name`, `platform`, `sort`, `del`, `merchant_id`) VALUES (1, 6, 'UAT-MT4-Live1', 1, 1, 0,'20240001');
INSERT INTO `user_trader_server` (`id`, `server`, `name`, `platform`, `sort`, `del`, `merchant_id`) VALUES (2, 7, 'UAT-MT5-Live1', 2, 2, 0,'20240001');


CREATE TABLE `pay_deposit_order`  (
                                      `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
                                      `order_number` varchar(64)NOT NULL COMMENT '入金订单号，用于本系统',
                                      `server` int NOT NULL COMMENT '交易账号所属服务器id',
                                      `ticket` varchar(64) NULL DEFAULT NULL COMMENT 'mt4订单号',
                                      `channel_order_number` varchar(64) NOT NULL COMMENT '渠道专用订单号，入金时向渠道传输的订单号',
                                      `user_id` int NOT NULL COMMENT '入金用户id',
                                      `account` int NOT NULL COMMENT '入金账号',
                                      `deposit_type` tinyint NOT NULL COMMENT '入金类型，见enum',
                                      `deposit_status` int NOT NULL COMMENT '入金状态，见ENUM',
                                      `channel_type` tinyint NULL DEFAULT NULL COMMENT '渠道类型，见enum',
                                      `main_channel_id` int NOT NULL COMMENT '主渠道id',
                                      `child_channel_id` int NOT NULL COMMENT '子渠道id',
                                      `apply_amount` decimal(20, 2) NOT NULL COMMENT '申请金额，使用的币种是 apply_currency',
                                      `apply_currency` varchar(8) NOT NULL COMMENT '申请金额使用的币种，代表账号币种',
                                      `fee` decimal(20, 2) NOT NULL COMMENT '手续费，使用的币种是apply_currency。计算公式: fee_amount * fee_rate = fee',
                                      `actual_amount` decimal(20, 2) NOT NULL COMMENT '去除手续费后的入金金额，币种是 apply_currency，计算公式 actual_amount = apply_amount + fee',
                                      `rate` decimal(20, 4) NOT NULL COMMENT '入金采用的汇率',
                                      `random_amount` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '入金随机金额，某些渠道需要',
                                      `pay_amount` decimal(20, 2) NOT NULL COMMENT '实际支付金额，币种是 pay_currency，计算公式 pay_amount = actual_amount * rate + random_amount',
                                      `pay_currency` varchar(8) NOT NULL COMMENT '实际支付采用的币种',
                                      `risk_level_id` int NOT NULL DEFAULT 0 COMMENT '风险等级id',
                                      `create_time` datetime NOT NULL COMMENT '创建时间',
                                      `create_user_id` int NOT NULL COMMENT '创建用户id',
                                      `execute_time` datetime NULL DEFAULT NULL COMMENT '执行时间',
                                      `del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除，0-否，1-是',
                                      `remark` varchar(512)  NULL DEFAULT NULL,
                                      `update_time` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
                                      `audit_times` tinyint NULL DEFAULT 0 COMMENT '修改状态的审核次数 1-初次修改状态 2-第一次审核 3-第二次审核',
                                      `spare` varchar(2048) NULL DEFAULT NULL COMMENT '备用字段, 每个渠道不一样, json格式',
                                      `fee_rule` tinyint NULL DEFAULT NULL COMMENT '手续费规则，见enum',
                                      `fee_currency` varchar(8) NOT NULL COMMENT '设置手续费时采用的系统币种',
                                      `fee_amount` decimal(20, 2) NOT NULL COMMENT '设置手续费的金额',
                                      `fee_rate` decimal(20, 4) NOT NULL COMMENT '生成订单时手续费设置的币种与账号币种的汇率',
                                      `fee_less_amount` decimal(20, 2) NOT NULL COMMENT '用于条件固定手续费，金额小于该值时才收取手续费',
                                      `channel_business_type` tinyint NULL COMMENT '渠道业务类型，见enum',
                                      `operating_ip` varchar(30) NULL DEFAULT NULL,
                                      `apply_amount_usd` decimal(20, 2) NULL DEFAULT 0.00 COMMENT 'apply_amount的美元金额，根据apply_amount * payment.show_rate计算得出',
                                      `can_refund_amount` decimal(30, 2) NULL DEFAULT NULL COMMENT '信用卡入金訂單可退款金額',
                                      `credit_card_num` varchar(64) NULL DEFAULT NULL COMMENT '信用卡入金订单',
                                      `request_source` int NOT NULL DEFAULT 99 COMMENT 'request_source 类型见枚举RequestSourceEnum',
                                      `pay_success_time` datetime NULL DEFAULT NULL COMMENT '支付成功时间',
                                      `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
                                      `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
                                      `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
                                      `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
                                      `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `org_id` int NULL DEFAULT NULL COMMENT '组织id',
                                      `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
                                      `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                      `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
                                      `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
                                      `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
                                      `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
                                      `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
                                      `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `idx_user_id`(`user_id`) USING BTREE,
                                      INDEX `idx_account`(`account`) USING BTREE,
                                      INDEX `idx_create_time`(`create_time`) USING BTREE
) COMMENT = '入金订单表';

CREATE TABLE `pay_transfer_order`  (
                                       `id` INT unsigned NOT NULL AUTO_INCREMENT,
                                       `order_number` varchar(64)  NULL DEFAULT NULL COMMENT '转账订单号',
                                       `ticket_out` varchar(64)  NULL DEFAULT NULL COMMENT '转出订单号',
                                       `ticket_in` varchar(64)  NULL DEFAULT NULL COMMENT '转入订单号',
                                       `server` int NULL DEFAULT NULL COMMENT '转账账号所属服务器id',
                                       `user_id` int NULL DEFAULT NULL COMMENT '用户id',
                                       `from_account` int NULL DEFAULT NULL COMMENT '转出账号',
                                       `is_mam` tinyint(1) NULL DEFAULT 0 COMMENT '转出账号是否是MAM账号',
                                       `to_account` int NULL DEFAULT NULL COMMENT '转入账号',
                                       `transfer_status` int NULL DEFAULT NULL COMMENT '转账状态',
                                       `transfer_out_amount` decimal(20, 2) NULL DEFAULT NULL COMMENT '转出金额',
                                       `transfer_out_currency` varchar(8) NULL DEFAULT NULL COMMENT '转出账号币种',
                                       `fee` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '手续费',
                                       `auto_transfer` tinyint(1) NULL DEFAULT 0 COMMENT '是否自动转账 0-手动 1-自动',
                                       `rate` decimal(20, 4) NULL DEFAULT NULL COMMENT '转账汇率',
                                       `transfer_in_amount` decimal(20, 2) NULL DEFAULT NULL COMMENT '转入金额',
                                       `transfer_in_currency` varchar(8)  NULL DEFAULT NULL COMMENT '转入账号币种',
                                       `message` varchar(255)  NULL DEFAULT NULL COMMENT '客户留言',
                                       `remark` varchar(255)  NULL DEFAULT NULL COMMENT '审核备注',
                                       `del` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0-否 1-是',
                                       `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                       `create_user_id` int NULL DEFAULT NULL COMMENT '创建用户id',
                                       `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                       `update_user_id` int NULL DEFAULT NULL COMMENT '更新用户id',
                                       `operator` int NULL DEFAULT NULL COMMENT '审核人id',
                                       `request_source` int NOT NULL DEFAULT 99 COMMENT 'request_source 类型见枚举RequestSourceEnum',
                                       `transfer_type` int NULL DEFAULT NULL COMMENT '轉帳類型; 1-帳戶內轉, 2-佣金內轉 詳見ENUM TransferType',
                                       `account` int NULL DEFAULT NULL COMMENT '账号',
                                       `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
                                       `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
                                       `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `org_id` int NULL DEFAULT NULL COMMENT '组织id',
                                       `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
                                       `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                       `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
                                       `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
                                       `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
                                       `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
                                       `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
                                       `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id',
                                       PRIMARY KEY (`id`) USING BTREE
) COMMENT = '转账订单表';


CREATE TABLE `pay_withdrawal_order`  (
                                         `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
                                         `order_number` varchar(64) NOT NULL COMMENT '出金订单号，用于本系统',
                                         `server` int NOT NULL DEFAULT 0 COMMENT '交易账号所属服务器id,返佣账号该值为0',
                                         `ticket` varchar(64) NULL DEFAULT NULL COMMENT 'mt4订单号',
                                         `withdrawal_type` tinyint NOT NULL COMMENT '出金类型，见enum',
                                         `withdrawal_status` int NOT NULL COMMENT '出金状态，见enum',
                                         `suspend` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否挂起  0：否  1：是',
                                         `receipt` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否下发回执，0-否，1-是',
                                         `user_id` int NOT NULL COMMENT '出金用户id',
                                         `account` int NOT NULL COMMENT '出金账号',
                                         `account_type` tinyint NOT NULL COMMENT '出金账号类型，见enum',
                                         `mam` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是MAM账号，0-否，1-是',
                                         `channel_type` tinyint NULL COMMENT '渠道类型，见ENUM',
                                         `main_channel_id` int NOT NULL COMMENT '出金主渠道id',
                                         `child_channel_id` int NOT NULL COMMENT '实际出金子渠道',
                                         `apply_amount` decimal(20, 2) NOT NULL COMMENT '出金申请金额，币种是 apply_currency',
                                         `apply_currency` varchar(8) NOT NULL COMMENT '出金申请采用的币种，代表账号币种',
                                         `fee` decimal(20, 2) NOT NULL COMMENT '手续费，使用的币种是apply_currency。计算公式: fee_amount * fee_rate = fee',
                                         `actual_amount` decimal(20, 2) NOT NULL COMMENT '扣除手续费后的出金金额，币种是 apply_currency，计算公式 actual_amount = apply_amount - fee',
                                         `rate` decimal(20, 4) NOT NULL COMMENT '出金采用的汇率',
                                         `pay_amount` decimal(20, 2) NOT NULL COMMENT '出金实际支付金额，币种是 pay_currency，计算公式 pay_amount = actual_amount * rate',
                                         `pay_currency` varchar(8) NOT NULL COMMENT '实际支付币种',
                                         `risk_level_id` int NOT NULL DEFAULT 0 COMMENT '风险等级id',
                                         `identity_id` varchar(64) NULL DEFAULT NULL COMMENT '身份证ID',
                                         `card_number` varchar(64) NULL DEFAULT NULL COMMENT '收款银行卡号',
                                         `bank_name` varchar(128) NULL DEFAULT NULL COMMENT '收款银行名称',
                                         `branch_bank_name` varchar(128) NULL DEFAULT NULL COMMENT '收款银行支行名称',
                                         `card_hold_name` varchar(128) NULL DEFAULT NULL COMMENT '银行卡所属人姓名',
                                         `phone_num` varchar(64) NULL DEFAULT NULL COMMENT '银行卡预留手机号',
                                         `card_binded` tinyint(1) NOT NULL DEFAULT 0 COMMENT '银行卡是否是绑定状态，0-否，1-是',
                                         `iban_num` varchar(64) NULL DEFAULT NULL COMMENT 'IBAN/账户号',
                                         `sort_code` varchar(64) NULL DEFAULT NULL COMMENT 'Sort code/SWIFT/BIC',
                                         `bank_address` varchar(128) NULL DEFAULT NULL COMMENT '银行地址',
                                         `email` varchar(64) NULL DEFAULT NULL COMMENT '邮箱',
                                         `create_user_id` int NOT NULL COMMENT '创建人id',
                                         `create_time` datetime NOT NULL COMMENT '创建时间',
                                         `update_user_id` int NULL DEFAULT NULL COMMENT '最后更新人id',
                                         `update_time` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
                                         `audit_user_id` int NULL DEFAULT NULL COMMENT '审核人id',
                                         `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
                                         `payer_user_id` int NULL DEFAULT NULL COMMENT '下发人id',
                                         `payer_time` datetime NULL DEFAULT NULL COMMENT '下发时间',
                                         `remark` varchar(512) NULL DEFAULT NULL,
                                         `del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除，0-否，1-是',
                                         `spare` varchar(2048) NULL DEFAULT NULL COMMENT '备用字段, 每个渠道不一样, json格式',
                                         `marks` varchar(255) NOT NULL DEFAULT '' COMMENT '标签id集合 例：,1,',
                                         `fee_rule` tinyint NOT NULL COMMENT '手续费规则，见enum',
                                         `fee_currency` varchar(8) NOT NULL COMMENT '设置手续费时采用的系统币种',
                                         `fee_amount` decimal(20, 2) NOT NULL COMMENT '设置手续费的金额',
                                         `fee_rate` decimal(20, 4) NOT NULL COMMENT '生成订单时手续费设置的币种与账号币种的汇率',
                                         `fee_less_amount` decimal(20, 2) NOT NULL COMMENT '用于条件固定手续费，金额小于该值时才收取手续费',
                                         `channel_business_type` tinyint NULL COMMENT '渠道业务类型，见enum',
                                         `ifsc_code` varchar(64) NULL DEFAULT NULL,
                                         `risk_confirm_user_id` int NULL DEFAULT NULL COMMENT '风险确认用户id',
                                         `risk_confirm_user_name` varchar(255) NULL DEFAULT NULL COMMENT '风险确认用户姓名',
                                         `settle_audit_id` int NULL DEFAULT NULL COMMENT '结算审核id',
                                         `settle_audit_name` varchar(255) NULL DEFAULT NULL COMMENT '结算审核人名',
                                         `risk_confirm_time` datetime NULL DEFAULT NULL COMMENT '风险确认时间',
                                         `settle_audit_time` datetime NULL DEFAULT NULL COMMENT '结算审核时间',
                                         `remark2` varchar(1024) NULL DEFAULT NULL,
                                         `financial_institution_number` varchar(128) NULL DEFAULT NULL COMMENT '金融機構編號',
                                         `branch_transit_number` varchar(128) NULL DEFAULT NULL COMMENT '分行代碼',
                                         `refund_deposit_order` varchar(64) NULL DEFAULT NULL COMMENT '信用卡退款使用的入金訂單',
                                         `request_source` int NOT NULL DEFAULT 99 COMMENT 'request_source 类型见枚举RequestSourceEnum',
                                         `withdrawal_risk_type` tinyint NULL DEFAULT 0 COMMENT '出金風險類型 請參閱ENUM',
                                         `withdrawal_risk_confirm_user_id` int NULL DEFAULT NULL COMMENT '風險出金審核確認用戶id',
                                         `withdrawal_risk_confirm_time` datetime NULL DEFAULT NULL COMMENT '風險出金審核確認時間',
                                         `total_deposit_amount` decimal(20, 2) NULL DEFAULT NULL COMMENT '總入金',
                                         `total_withdrawal_amount` decimal(20, 2) NULL DEFAULT NULL COMMENT '總出金',
                                         `history_net_withdrawal_amount` decimal(20, 2) NULL DEFAULT NULL COMMENT '歷史淨出金',
                                         `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
                                         `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
                                         `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
                                         `operating_ip` varchar(50) NULL DEFAULT '' COMMENT 'IP',
                                         `channel_order_number` varchar(64) NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
                                         `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
                                         `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
                                         `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
                                         `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `org_id` int NULL DEFAULT NULL COMMENT '组织id',
                                         `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
                                         `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
                                         `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
                                         `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
                                         `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
                                         `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
                                         `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
                                         `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id',
                                         PRIMARY KEY (`id`) USING BTREE
) COMMENT = '出金订单表';

CREATE TABLE `acc_trade`  (
                              `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
                              `ticket` int NULL DEFAULT NULL COMMENT '订单',
                              `login` int NULL DEFAULT NULL COMMENT '账号',
                              `symbol` varchar(64) NULL DEFAULT NULL COMMENT '货币对',
                              `digits` decimal(38, 6) NULL DEFAULT NULL COMMENT 'digits',
                              `cmd` int NULL DEFAULT NULL COMMENT 'cmd',
                              `volume` int NULL DEFAULT NULL COMMENT '手数',
                              `open_time` datetime NULL DEFAULT NULL COMMENT '开仓时间',
                              `close_time` datetime NULL DEFAULT NULL COMMENT '关仓时间',
                              `open_price` decimal(38, 6) NULL DEFAULT NULL COMMENT '开仓价格',
                              `close_price` decimal(38, 6) NULL DEFAULT NULL COMMENT '关仓价格',
                              `sl` decimal(38, 6) NULL DEFAULT NULL COMMENT 'sl',
                              `tp` decimal(38, 6) NULL DEFAULT NULL COMMENT 'tp',
                              `server` int NULL DEFAULT NULL COMMENT '服务器',
                              `reason` varchar(64) NULL DEFAULT NULL COMMENT '原因',
                              `commission` decimal(38, 6) NULL DEFAULT NULL,
                              `swaps` decimal(38, 6) NULL DEFAULT NULL COMMENT '手续费',
                              `profit` decimal(38, 6) NULL DEFAULT NULL COMMENT '利润',
                              `taxes` decimal(38, 6) NULL DEFAULT NULL COMMENT '税',
                              `comment` varchar(64) NULL DEFAULT NULL COMMENT '备注',
                              `deal` int NULL DEFAULT NULL COMMENT '交易',
                              `position_id` int NULL DEFAULT NULL COMMENT 'positionId',
                              `record_type` int NULL DEFAULT NULL COMMENT '记录类型',
                              `create_time` datetime NULL DEFAULT NULL,
                              `update_time` datetime NULL DEFAULT NULL,
                              `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
                              `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id',
                              PRIMARY KEY (`id`) USING BTREE
) COMMENT = '平仓类交易';


-- commission_base_ib
DROP TABLE IF EXISTS `commission_base_ib_202401`;
CREATE TABLE `commission_base_ib_202401`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202402`;
CREATE TABLE `commission_base_ib_202402`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202403`;
CREATE TABLE `commission_base_ib_202403`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202404`;
CREATE TABLE `commission_base_ib_202404`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202405`;
CREATE TABLE `commission_base_ib_202405`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202406`;
CREATE TABLE `commission_base_ib_202406`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4)  NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202407`;
CREATE TABLE `commission_base_ib_202407`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202408`;
CREATE TABLE `commission_base_ib_202408`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202409`;
CREATE TABLE `commission_base_ib_202409`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表'

DROP TABLE IF EXISTS `commission_base_ib_202410`;
CREATE TABLE `commission_base_ib_202410`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202411`;
CREATE TABLE `commission_base_ib_202411`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202412`;
CREATE TABLE `commission_base_ib_202412`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202501`;
CREATE TABLE `commission_base_ib_202501`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202502`;
CREATE TABLE `commission_base_ib_202502`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202503`;
CREATE TABLE `commission_base_ib_202503`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202504`;
CREATE TABLE `commission_base_ib_202504`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202505`;
CREATE TABLE `commission_base_ib_202505`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202506`;
CREATE TABLE `commission_base_ib_202506`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202507`;
CREATE TABLE `commission_base_ib_202507`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202508`;
CREATE TABLE `commission_base_ib_202508`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202509`;
CREATE TABLE `commission_base_ib_202509`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202510`;
CREATE TABLE `commission_base_ib_202510`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202511`;
CREATE TABLE `commission_base_ib_202511`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202512`;
CREATE TABLE `commission_base_ib_202512`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202601`;
CREATE TABLE `commission_base_ib_202601`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202602`;
CREATE TABLE `commission_base_ib_202602`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202603`;
CREATE TABLE `commission_base_ib_202603`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202604`;
CREATE TABLE `commission_base_ib_202604`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202605`;
CREATE TABLE `commission_base_ib_202605`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202606`;
CREATE TABLE `commission_base_ib_202606`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202607`;
CREATE TABLE `commission_base_ib_202607`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202608`;
CREATE TABLE `commission_base_ib_202608`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202609`;
CREATE TABLE `commission_base_ib_202609`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202610`;
CREATE TABLE `commission_base_ib_202610`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202611`;
CREATE TABLE `commission_base_ib_202611`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

DROP TABLE IF EXISTS `commission_base_ib_202612`;
CREATE TABLE `commission_base_ib_202612`  (
                                              `id` int(11) unsigned NOT NULL COMMENT 'id',
                                              `commission_ticket` varchar(32) NOT NULL COMMENT '佣金订单id',
                                              `user_id` int(11) NOT NULL COMMENT '交易账号用户id',
                                              `account` int(11) NOT NULL COMMENT '交易账号',
                                              `ib_id` int(11) NOT NULL COMMENT '返佣账号userId',
                                              `rebate_account` int(11) NOT NULL COMMENT '返佣账号',
                                              `relation_type` int(2) NOT NULL COMMENT '归属关系(直属/子代)',
                                              `parent_id` int(11) NOT NULL COMMENT '直属交易账号上级ib 用户id',
                                              `parent_account` int(11) NOT NULL COMMENT '直属交易账号上级ib返佣账号',
                                              `commission` decimal(38, 8) NOT NULL DEFAULT 0.00000000 COMMENT '佣金',
                                              `volume` int(8) NOT NULL COMMENT '交易手数',
                                              `close_time` datetime NOT NULL COMMENT '关单时间',
                                              `ticket` varchar(30) NOT NULL COMMENT '交易订单号',
                                              `cmd` int(2) NOT NULL COMMENT '交易类型',
                                              `symbol` varchar(32) NOT NULL COMMENT '交易品种',
                                              `close_price` decimal(32, 6) NOT NULL COMMENT '关单价格',
                                              `profit` decimal(64, 4) NOT NULL COMMENT '利润',
                                              `server` int(4) NOT NULL COMMENT '服务器',
                                              `coefficient` decimal(8, 2) NOT NULL COMMENT '佣金规则设置的值',
                                              `rule_id` int(11) NOT NULL COMMENT '佣金规则id',
                                              `rate` decimal(16, 6) NOT NULL COMMENT '汇率(交易账号转为USD的汇率)',
                                              `commission_type` int(4) NOT NULL COMMENT '佣金结算类型',
                                              `trade_group_id` int(16) NOT NULL COMMENT '交易品种组id',
                                              `group` varchar(32) NOT NULL COMMENT '交易组',
                                              `system_group_id` int(16) NOT NULL COMMENT '系统组id',
                                              `rebate_currency` varchar(4) NOT NULL COMMENT '返佣账号币种',
                                              `status` int(4) NOT NULL COMMENT '佣金订单状态',
                                              `create_time` datetime NOT NULL COMMENT '佣金订单创建时间',
                                              `update_time` datetime NULL DEFAULT NULL COMMENT '佣金订单更新时间',
                                              `del` tinyint(1) NOT NULL COMMENT '佣金订单删除状态',
                                              `stock_volume` decimal(15, 8) NULL DEFAULT NULL COMMENT '股票交易量',
                                              `commission_usd` decimal(38, 8) NULL DEFAULT NULL COMMENT 'commission轉USD',
                                              `usd_rate` decimal(16, 6) NULL DEFAULT NULL,
                                              INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id',
                                              INDEX `index_account`(`account`) USING BTREE COMMENT '交易账号',
                                              INDEX `index_ib_id`(`ib_id`) USING BTREE COMMENT '返佣账号用户id',
                                              INDEX `index_ib_account`(`rebate_account`) USING BTREE COMMENT '返佣账号',
                                              INDEX `index_ticket`(`ticket`) USING BTREE COMMENT '交易订单号',
                                              INDEX `index_close_time`(`close_time`) USING BTREE COMMENT '交易订单关单时间',
                                              INDEX `index_id`(`id`) USING BTREE COMMENT 'id'
) COMMENT = 'IB佣金计算基础表';

alter table commission_base_ib_202601 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202602 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202603 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202604 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202605 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202606 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202607 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202608 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202609 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202610 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202611 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202612 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202501 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202502 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202503 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202504 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202505 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202506 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202507 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202508 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202509 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202510 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202511 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202512 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202401 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202402 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202403 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202404 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202405 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202406 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202407 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202408 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202409 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202410 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202411 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );

alter table commission_base_ib_202412 add column(
    `order_number` varchar(64) NULL DEFAULT NULL COMMENT '订单号',
    `sales` int NULL DEFAULT NULL COMMENT '关联末级销售id(预留配置字段)',
    `trade_group` varchar(128) NULL DEFAULT '' COMMENT '交易组别记录',
    `current_apply_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '現已申請金額',
    `operating_ip` varchar(50)  NULL DEFAULT '' COMMENT 'IP',
    `channel_order_number` varchar(64)  NULL DEFAULT NULL COMMENT '渠道专用订单号，出金时向渠道传输的订单号',
    `has_trade_after_deposit` tinyint(1) NULL DEFAULT NULL COMMENT '入金後是否有交易',
    `main_channel_name` varchar(128) NULL DEFAULT NULL COMMENT '主渠道名称',
    `server_name` varchar(128) NULL DEFAULT NULL COMMENT '服务器名称',
    `ib_invitation` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `org_id` int NULL DEFAULT NULL COMMENT '组织id',
    `org_name` varchar(128) NULL DEFAULT NULL COMMENT '组织名称',
    `first_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `first_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `last_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_local` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sys_group_name` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `ib_full_name_en` varchar(128) NULL DEFAULT NULL COMMENT 'ib邀请码',
    `sale_name` varchar(128) NULL DEFAULT NULL COMMENT '销售姓名',
    `p_rebate` int NULL DEFAULT NULL COMMENT '上级ib账号',
    `country` varchar(128) NULL DEFAULT NULL COMMENT '国家',
    `ib_user_id` int NULL DEFAULT NULL COMMENT 'ib_user_id',
    `day` varchar(12) NULL DEFAULT NULL COMMENT 'day',
    `merchant_id` varchar(12) NULL DEFAULT NULL COMMENT 'merchant_id'
    );










CREATE TABLE `hr_sales`
(
    `id`                int unsigned NOT NULL AUTO_INCREMENT,
    `user_id`           int           DEFAULT NULL,
    `mail`              varchar(64)   DEFAULT NULL,
    `real_name`         varchar(128)  DEFAULT NULL COMMENT '真实姓名',
    `crm_name`          varchar(128)  DEFAULT NULL COMMENT 'CRM姓名',
    `phone`             varchar(20)   DEFAULT NULL,
    `employ_status`     tinyint       DEFAULT NULL,
    `title`             varchar(64)   DEFAULT NULL,
    `upper`             varchar(64)   DEFAULT NULL,
    `area`              varchar(64)   DEFAULT NULL,
    `team`              varchar(200)  DEFAULT NULL,
    `team_leader`       varchar(64)   DEFAULT NULL,
    `board_time`        varchar(10)   DEFAULT NULL,
    `resign_time`       varchar(10)   DEFAULT NULL,
    `create_user`       varchar(64)   DEFAULT NULL,
    `create_time`       datetime      DEFAULT NULL,
    `update_user`       varchar(64)   DEFAULT NULL,
    `update_time`       datetime      DEFAULT NULL,
    `comment`           varchar(1024) DEFAULT NULL,
    `del`               tinyint(1)    DEFAULT '0',
    `currency`          varchar(5)    DEFAULT NULL COMMENT '薪資幣種',
    `language_code_str` text COMMENT '语言列表',
    `sales_org_id`      int           DEFAULT NULL COMMENT '销售组织id',
    `user_pName`        varchar(128)  DEFAULT NULL COMMENT '上级',
    `role_name`         varchar(64)   DEFAULT NULL COMMENT '角色',
    `invitation_code`   varchar(64)   DEFAULT NULL COMMENT '邀请码',
    `area_code`         varchar(10)   DEFAULT NULL COMMENT '手机区号',
    `merchant_id`       varchar(32)   DEFAULT NULL COMMENT '商户号',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `user_id` (`user_id`) USING BTREE COMMENT '用户id索引'
);



CREATE TABLE `commission_level`
(
    `name`            varchar(128) NOT NULL,
    `royalty_type`    tinyint               DEFAULT NULL COMMENT '提成类型，ECN或者STP，见enum',
    `level_conf_type` tinyint               DEFAULT NULL COMMENT '设置类型，如直属直客和直属IB的直客，见ENUM',
    `sort`            int          NOT NULL COMMENT '排序字段，从小到大排序',
    `del`             tinyint(1)   NOT NULL DEFAULT '0',
    `merchant_id`     varchar(32)           DEFAULT NULL COMMENT '商户号',
    PRIMARY KEY (`name`) USING BTREE
) COMMENT ='返佣级别';

INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Premium Affiliate', 1, 1, 7, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Premium Client', 1, 2, 6, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Premium(0.7)', 1, 1, 5, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Premium(0.8)', 1, 1, 4, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Premium(0.9)', 1, 1, 3, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Premium(1)', 1, 1, 2, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Premium(Special)', 1, 1, 1, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard Affiliate', 2, 1, 16, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard Client', 2, 2, 15, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard(1.4)', 2, 1, 14, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard(1.7)', 2, 1, 13, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard(2.1)', 2, 1, 12, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard(2.3)', 2, 1, 11, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard(2.5)', 2, 1, 10, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard(2.7)', 2, 1, 9, 0, '20240001');
INSERT INTO commission_level (name, royalty_type, level_conf_type, sort, del, merchant_id) VALUES('Standard(Special)', 2, 1, 8, 0, '20240001');



CREATE TABLE `tb_variety_group`
(
    `id`             int unsigned NOT NULL AUTO_INCREMENT,
    `group_name`     varchar(32)  NOT NULL COMMENT '品种名称',
    `server`         varchar(255)          DEFAULT NULL,
    `sort`           int          NOT NULL DEFAULT '1' COMMENT '排序标识',
    `foreign_group`  tinyint(1)   NOT NULL DEFAULT '1' COMMENT '是否是外汇组，1-是，0-不是',
    `create_time`    datetime     NOT NULL COMMENT '创建时间',
    `create_user_id` int          NOT NULL COMMENT '创建人id',
    `update_time`    datetime              DEFAULT NULL COMMENT '最近更新时间',
    `update_user_id` int                   DEFAULT '0' COMMENT '最近更新人id',
    `del`            tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除，0-否，1-是',
    `display_settle` varchar(100)          DEFAULT NULL,
    `merchant_id`    varchar(32)           DEFAULT NULL COMMENT '商户号',
    `cloud_group_id` bigint                DEFAULT NULL COMMENT '对应cloud的group_id',
    PRIMARY KEY (`id`) USING BTREE
) COMMENT ='交易品种组表';



CREATE TABLE `sale_royalty_conf`
(
    `id`               int unsigned NOT NULL AUTO_INCREMENT,
    `sale_user_id`     int            DEFAULT NULL COMMENT '销售用户id',
    `commi_level`      varchar(32)    DEFAULT NULL COMMENT '返佣等级，是表 commission_level 主键',
    `child_royalty`    decimal(30, 5) DEFAULT NULL COMMENT '从下级代理或直客上得到的提成',
    `manager_royalty`  decimal(30, 5) DEFAULT NULL COMMENT '地区经理提成',
    `variety_group_id` int            DEFAULT NULL COMMENT '品种组id',
    `create_time`      datetime       DEFAULT NULL,
    `create_user_id`   int            DEFAULT NULL,
    `update_time`      datetime       DEFAULT NULL,
    `update_user_id`   int            DEFAULT NULL,
    `del`              tinyint        DEFAULT '0',
    `settle_mode`      tinyint        DEFAULT NULL COMMENT '提成计算方式 1:反傭 2:反點 3:美股',
    `merchant_id`      varchar(32)    DEFAULT NULL COMMENT '商户号',
    PRIMARY KEY (`id`) USING BTREE
) COMMENT ='销售提成设置表';



CREATE TABLE `language_code`
(
    `name_en`       varchar(50)  NOT NULL,
    `name_zh`       varchar(50)  NOT NULL,
    `language_code` char(10)     NOT NULL,
    `code_2`        char(2)               DEFAULT NULL,
    `code_3`        char(3)               DEFAULT NULL,
    `is_enable`     tinyint      NOT NULL DEFAULT '0',
    `merchant_id`   varchar(128) NOT NULL COMMENT '商户ID',
    PRIMARY KEY (`language_code`) USING BTREE,
    UNIQUE KEY `language_code_language_code_uindex` (`language_code`) USING BTREE
) COMMENT ='语言代码';

INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Afar', '阿法尔语', 'aa', 'aa', 'aar', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Abkhazian', '阿布哈兹语', 'ab', 'ab', 'abk', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Avestan', '阿维斯陀语', 'ae', 'ae', 'ave', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Afrikaans', '南非语', 'af', 'af', 'afr', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Afrikaans', '南非语', 'af-ZA', 'af', 'afr', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Akan', '阿坎语', 'ak', 'ak', 'aka', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Amharic', '阿姆哈拉语', 'am', 'am', 'amh', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Aragonese', '阿拉贡语', 'an', 'an', 'arg', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语', 'ar', 'ar', 'ara', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(阿联酋)', 'ar-AE', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(巴林)', 'ar-BH', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(阿尔及利亚)', 'ar-DZ', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(埃及)', 'ar-EG', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(科威特)', 'ar-KW', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(黎巴嫩)', 'ar-LB', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(利比亚)', 'ar-LY', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(摩洛哥)', 'ar-MA', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(阿曼)', 'ar-OM', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(卡塔尔)', 'ar-QA', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(沙特阿拉伯)', 'ar-SA', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(叙利亚)', 'ar-SY', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(突尼斯)', 'ar-TN', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Arabic', '阿拉伯语(也门)', 'ar-YE', 'ar', 'ara', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Assamese', '阿萨姆语', 'as', 'as', 'asm', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Avaric', '阿瓦尔语', 'av', 'av', 'ava', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Aymara', '艾马拉语', 'ay', 'ay', 'aym', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Azeri (Latin)', '阿塞拜疆语', 'az', 'az', 'aze', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bashkir', '巴什基尔语', 'ba', 'ba', 'bak', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Belarusian', '比利时语', 'be', 'be', 'bel', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bulgarian', '保加利亚语', 'bg', 'bg', 'bul', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bulgarian', '保加利亚语', 'bg-BG', 'bg', 'bul', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bihari languages', '比哈尔语', 'bh', 'bh', 'bih', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bislama', '比斯拉马语', 'bi', 'bi', 'bis', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bambara', '班巴拉语', 'bm', 'bm', 'bam', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bengali', '孟加拉语', 'bn', 'bn', 'ben', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tibetan', '藏语', 'bo', 'bo', 'tib', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Breton', '布列塔尼语', 'br', 'br', 'bre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bosnian', '波斯尼亚语', 'bs', 'bs', 'bos', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Bosnian', '波斯尼亚语(拉丁文，波斯尼亚和黑塞哥维那)', 'bs-BA', 'bs', 'bos', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Catalan', '加泰隆语', 'ca', 'ca', 'cat', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Chechen', '车臣语', 'ce', 'ce', 'che', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Chamorro', '查莫罗语', 'ch', 'ch', 'cha', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Corsican', '柯西嘉语', 'co', 'co', 'cos', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Cree', '克里语', 'cr', 'cr', 'cre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Czech', '捷克语', 'cs', 'cs', 'cze', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Czech', '捷克语', 'cs-CZ', 'cs', 'cze', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Church Slavic; Slavonic; Old Bulgarian', '教会斯拉夫语;斯拉夫语;老保加利亚', 'cu', 'cu', 'chu', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Chuvash', '楚瓦什语', 'cv', 'cv', 'chv', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Welsh', '威尔士语', 'cy', 'cy', 'wel', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Welsh', '威尔士语', 'cy-GB', 'cy', 'wel', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Danish', '丹麦语', 'da', 'da', 'dan', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Danish', '丹麦语', 'da-DK', 'da', 'dan', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('German', '德语', 'de', 'de', 'ger', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('German', '德语(奥地利)', 'de-AT', 'de', 'ger', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('German', '德语(瑞士)', 'de-CH', 'de', 'ger', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('German', '德语(德国)', 'de-DE', 'de', 'ger', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Divehi', '第维埃语', 'dv', 'dv', 'div', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Divehi', '第维埃语', 'dv-MV', 'dv', 'div', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Dzongkha', '宗卡语', 'dz', 'dz', 'dzo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Ewe', '埃维语', 'ee', 'ee', 'ewe', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Greek', '希腊语', 'el', 'el', 'gre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Greek', '希腊语', 'el-GR', 'el', 'gre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语', 'en', 'en', 'eng', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(澳大利亚)', 'en-AU', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(伯利兹)', 'en-BZ', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(爱尔兰)', 'en-IE', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(牙买加)', 'en-JM', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(新西兰)', 'en-NZ', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(菲律宾)', 'en-PH', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(美国)', 'en-US', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(南非)', 'en-ZA', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('English', '英语(津巴布韦)', 'en-ZW', 'en', 'eng', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Esperanto', '世界语', 'eo', 'eo', 'epo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语', 'es', 'es', 'spa', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(阿根廷)', 'es-AR', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(玻利维亚)', 'es-BO', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(智利)', 'es-CL', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(哥伦比亚)', 'es-CO', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(哥斯达黎加)', 'es-CR', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(洪都拉斯)', 'es-HN', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(墨西哥)', 'es-MX', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(尼加拉瓜)', 'es-NI', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(巴拿马)', 'es-PA', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(秘鲁)', 'es-PE', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(波多黎各(美))', 'es-PR', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(巴拉圭)', 'es-PY', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Spanish', '西班牙语(萨尔瓦多)', 'es-SV', 'es', 'spa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Estonian', '爱沙尼亚语', 'et', 'et', 'est', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Basque', '巴士克语', 'eu', 'eu', 'baq', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Basque', '巴士克语', 'eu-ES', 'eu', 'baq', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Farsi', '法斯语', 'fa', 'fa', 'per', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Farsi', '法斯语', 'fa-IR', 'fa', 'per', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Fulah', '富拉语', 'ff', 'ff', 'ful', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Finnish', '芬兰语', 'fi', 'fi', 'fin', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Fijian', '斐济语', 'fj', 'fj', 'fij', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Faroese', '法罗语', 'fo', 'fo', 'fao', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Faroese', '法罗语', 'fo-FO', 'fo', 'fao', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('French', '法语', 'fr', 'fr', 'fre', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('French', '法语(比利时)', 'fr-BE', 'fr', 'fre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('French', '法语(加拿大)', 'fr-CA', 'fr', 'fre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('French', '法语(瑞士)', 'fr-CH', 'fr', 'fre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('French', '法语(法国)', 'fr-FR', 'fr', 'fre', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Western Frisian', '西方的弗里斯兰语', 'fy', 'fy', 'fry', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Irish', '爱尔兰语', 'ga', 'ga', 'gle', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Gaelic; Scottish Gaelic', '盖尔语;苏格兰盖尔语', 'gd', 'gd', 'gla', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Galician', '加里西亚语', 'gl', 'gl', 'glg', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Galician', '加里西亚语', 'gl-ES', 'gl', 'glg', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Guarani', '瓜拉尼语', 'gn', 'gn', 'grn', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Gujarati', '古吉拉特语', 'gu', 'gu', 'guj', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Gujarati', '古吉拉特语', 'gu-IN', 'gu', 'guj', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Manx', '马恩岛语', 'gv', 'gv', 'glv', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hausa', '豪萨语', 'ha', 'ha', 'hau', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hebrew', '希伯来语', 'he', 'he', 'heb', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hebrew', '希伯来语', 'he-IL', 'he', 'heb', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hindi', '印地语', 'hi', 'hi', 'hin', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hindi', '印地语', 'hi-IN', 'hi', 'hin', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hiri Motu', '莫土语', 'ho', 'ho', 'hmo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Croatian', '克罗地亚语', 'hr', 'hr', 'hrv', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Croatian', '克罗地亚语(波斯尼亚和黑塞哥维那)', 'hr-BA', 'hr', 'hrv', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Croatian', '克罗地亚语', 'hr-HR', 'hr', 'hrv', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Haitian; Haitian Creole', '海地;海地克里奥尔语', 'ht', 'ht', 'hat', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hungarian', '匈牙利语', 'hu', 'hu', 'hun', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Hungarian', '匈牙利语', 'hu-HU', 'hu', 'hun', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Armenian', '亚美尼亚语', 'hy', 'hy', 'arm', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Armenian', '亚美尼亚语', 'hy-AM', 'hy', 'arm', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Herero', '赫雷罗语', 'hz', 'hz', 'her', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Interlingua', '国际语', 'ia', 'ia', 'ina', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Indonesian', '印度尼西亚语', 'id', 'id', 'ind', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Indonesian', '印度尼西亚语', 'id-ID', 'id', 'ind', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Interlingue; Occidental', '西式国际语', 'ie', 'ie', 'ile', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Igbo', '伊博语', 'ig', 'ig', 'ibo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sichuan Yi; Nuosu', '彝族语', 'ii', 'ii', 'iii', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Inupiaq', '伊努皮克语', 'ik', 'ik', 'ipk', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Ido', '伊多语', 'io', 'io', 'ido', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Icelandic', '冰岛语', 'is', 'is', 'ice', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Icelandic', '冰岛语', 'is-IS', 'is', 'ice', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Italian', '意大利语', 'it', 'it', 'ita', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Italian', '意大利语(意大利)', 'it-IT', 'it', 'ita', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Inuktitut', '因纽特语', 'iu', 'iu', 'iku', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Japanese', '日语', 'ja', 'ja', 'jpn', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Japanese', '日语', 'ja-JP', 'ja', 'jpn', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Javanese', '爪哇语', 'jv', 'jv', 'jav', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Georgian', '格鲁吉亚语', 'ka', 'ka', 'geo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Georgian', '格鲁吉亚语', 'ka-GE', 'ka', 'geo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kongo', '刚果语', 'kg', 'kg', 'kon', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kikuyu; Gikuyu', '基库尤语', 'ki', 'ki', 'kik', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kuanyama; Kwanyama', '宽亚玛语', 'kj', 'kj', 'kua', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kazakh', '哈萨克语', 'kk', 'kk', 'kaz', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kazakh', '哈萨克语', 'kk-KZ', 'kk', 'kaz', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kalaallisut; Greenlandic', '格陵兰语', 'kl', 'kl', 'kal', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Central Khmer', '高棉语', 'km', 'km', 'khm', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kannada', '卡纳拉语', 'kn', 'kn', 'kan', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Korean', '朝鲜语', 'ko', 'ko', 'kor', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Korean', '朝鲜语', 'ko-KR', 'ko', 'kor', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Konkani', '孔卡尼语', 'kok', NULL, 'kok', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kanuri', '卡努里语', 'kr', 'kr', 'kau', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kashmiri', '喀什米尔语', 'ks', 'ks', 'kas', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kurdish', '库德语', 'ku', 'ku', 'kur', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Komi', '科米语', 'kv', 'kv', 'kom', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Cornish', '康沃尔语', 'kw', 'kw', 'cor', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kyrgyz', '吉尔吉斯语', 'ky', 'ky', 'kir', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kyrgyz', '吉尔吉斯语(西里尔文)', 'ky-KG', 'ky', 'kir', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Latin', '拉丁语', 'la', 'la', 'lat', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Luxembourgish; Letzeburgesch', '卢森堡语; Letzeburgesch', 'lb', 'lb', 'ltz', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Ganda', '干达语', 'lg', 'lg', 'lug', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Limburgan; Limburger; Limburgish', '林堡语', 'li', 'li', 'lim', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Lingala', '林格拉语', 'ln', 'ln', 'lin', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Lao', '寮语', 'lo', 'lo', 'lao', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Lithuanian', '立陶宛语', 'lt', 'lt', 'lit', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Luba-Katanga', '鲁巴—加丹加语', 'lu', 'lu', 'lub', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Latvian', '拉脱维亚语', 'lv', 'lv', 'lav', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Latvian', '拉脱维亚语', 'lv-LV', 'lv', 'lav', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Melayu', '馬來語', 'ma', 'ma', 'mal', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Malagasy', '马达加斯加语', 'mg', 'mg', 'mlg', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Marshallese', '马绍尔语', 'mh', 'mh', 'mah', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Maori', '毛利语', 'mi', 'mi', 'mao', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('FYRO Macedonian', '马其顿语', 'mk', 'mk', 'mac', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('FYRO Macedonian', '马其顿语(FYROM)', 'mk-MK', 'mk', 'mac', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Malayalam', '马拉雅拉姆语', 'ml', 'ml', 'mal', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Mongolian', '蒙古语', 'mn', 'mn', 'mon', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Mongolian', '蒙古语(西里尔文)', 'mn-MN', 'mn', 'mon', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Marathi', '马拉地语', 'mr', 'mr', 'mar', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Marathi', '马拉地语', 'mr-IN', 'mr', 'mar', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Malay', '马来语', 'ms', 'ms', 'may', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Malay', '马来语(马来西亚)', 'ms-MY', 'ms', 'may', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Norwegian (Bokm?l)', '挪威语(伯克梅尔)(挪威)', 'nb-NO', 'nb', 'nob', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Nigeria', '奈及利亞語', 'ni', 'ni', 'nii', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Dutch', '荷兰语(比利时)', 'nl-BE', 'nl', 'dut', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Dutch', '荷兰语(荷兰)', 'nl-NL', 'nl', 'dut', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Norwegian Nynorsk', '挪威语(尼诺斯克)(挪威)', 'nn-NO', 'nn', 'nno', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Northern Sotho', '北梭托语', 'ns-ZA', 'ns', NULL, 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Punjabi', '旁遮普语', 'pa-IN', 'pa', 'pan', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Filipino', '菲律賓語', 'PH', 'ph', 'phi', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Polish', '波兰语', 'pl-PL', 'pl', 'pol', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Pashto', '普什图语', 'ps', 'ps', 'pus', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Pashto (Afghanistan)', '普什图语(阿富汗)', 'ps-AR', 'ps', 'pus', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Portuguese', '葡萄牙语', 'pt', 'pt', 'por', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Portuguese', '葡萄牙语(巴西)', 'pt-BR', 'pt', 'por', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Portuguese', '葡萄牙语(葡萄牙)', 'pt-PT', 'pt', 'por', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Quechua', '克丘亚语', 'qu', 'qu', 'que', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Quechua', '克丘亚语(玻利维亚)', 'qu-BO', 'qu', 'que', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Quechua', '克丘亚语(厄瓜多尔)', 'qu-EC', 'qu', 'que', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Quechua', '克丘亚语(秘鲁)', 'qu-PE', 'qu', 'que', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Romansh', '罗曼什语', 'rm', 'rm', 'roh', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Rundi', '布隆迪语', 'rn', 'rn', 'run', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Romanian', '罗马尼亚语', 'ro', 'ro', 'rum', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Russian', '俄语', 'ru', 'ru', 'rus', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Russian', '俄语', 'ru-RU', 'ru', 'rus', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Kinyarwanda', '卢旺达语', 'rw', 'rw', 'kin', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sanskrit', '梵文', 'sa', 'sa', 'san', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sanskrit', '梵文', 'sa-IN', 'sa', 'san', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sardinian', '撒丁语', 'sc', 'sc', 'srd', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sindhi', '信德语', 'sd', 'sd', 'snd', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sami (Northern)', '北萨摩斯语', 'se', 'se', 'sme', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sami (Northern)', '伊那里萨摩斯语(芬兰)', 'se-FI', 'se', 'sme', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sami (Northern)', '南萨摩斯语(挪威)', 'se-NO', 'se', 'sme', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sami (Northern)', '南萨摩斯语(瑞典)', 'se-SE', 'se', 'sme', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sango', '桑戈语', 'sg', 'sg', 'sag', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sinhala; Sinhalese', '僧伽罗语', 'si', 'si', 'sin', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Slovak', '斯洛伐克语', 'sk', 'sk', 'slo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Slovak', '斯洛伐克语', 'sk-SK', 'sk', 'slo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Slovenian', '斯洛文尼亚语', 'sl', 'sl', 'slv', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Slovenian', '斯洛文尼亚语', 'sl-SI', 'sl', 'slv', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Samoan', '萨摩亚语', 'sm', 'sm', 'smo', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Shona', '修纳语', 'sn', 'sn', 'sna', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Somali', '索马里语', 'so', 'so', 'som', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Albanian', '阿尔巴尼亚语', 'sq', 'sq', 'alb', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Albanian', '阿尔巴尼亚语', 'sq-AL', 'sq', 'alb', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Serbian', '塞尔维亚语', 'sr', 'sr', 'srp', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Serbian', '塞尔维亚语(西里尔文，波斯尼亚和黑塞哥维那)', 'sr-BA', 'sr', 'srp', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Serbian', '塞尔维亚(西里尔文)', 'sr-SP', 'sr', 'srp', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Swati', '斯瓦特语', 'ss', 'ss', 'ssw', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sotho, Southern', '梭托语,南部', 'st', 'st', 'sot', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Sundanese', '巽他语', 'su', 'su', 'sun', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Swedish', '瑞典语', 'sv', 'sv', 'swe', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Swedish', '瑞典语(芬兰)', 'sv-FI', 'sv', 'swe', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Swedish', '瑞典语', 'sv-SE', 'sv', 'swe', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Swahili', '斯瓦希里语', 'sw', 'sw', 'swa', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Syriac', '叙利亚语', 'syr', NULL, 'syr', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Syriac', '叙利亚语', 'syr-SY', NULL, 'syr', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tamil', '泰米尔语', 'ta', 'ta', 'tam', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tamil', '泰米尔语', 'ta-IN', 'ta', 'tam', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Telugu', '泰卢固语', 'te', 'te', 'tel', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Telugu', '泰卢固语', 'te-IN', 'te', 'tel', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tajik', '塔吉克语', 'tg', 'tg', 'tgk', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Thai', '泰语', 'th', 'th', 'tha', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Thai', '泰语', 'th-TH', 'th', 'tha', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tigrinya', '提格里尼亚语（埃塞俄比亚提格雷省通用的语言）', 'ti', 'ti', 'tir', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Turkmen', '土库曼语', 'tk', 'tk', 'tuk', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tagalog', '塔加路语', 'tl', 'tl', 'tgl', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tswana', '茨瓦纳语', 'tn', 'tn', 'tsn', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tonga (Tonga Islands)', '汤加(汤加群岛)', 'to', 'to', 'ton', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Turkish', '土耳其语', 'tr', 'tr', 'tur', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Turkish', '土耳其语', 'tr-TR', 'tr', 'tur', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tsonga', '宗加语', 'ts', 'ts', 'tso', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tatar', '鞑靼语', 'tt', 'tt', 'tat', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tatar', '鞑靼语', 'tt-RU', 'tt', 'tat', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Twi', '加纳国内的契维语', 'tw', 'tw', 'twi', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Tahitian', '塔希提语', 'ty', 'ty', 'tah', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Uighur; Uyghur', '维吾尔语', 'ug', 'ug', 'uig', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Ukrainian', '乌克兰语', 'uk', 'uk', 'ukr', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Ukrainian', '乌克兰语', 'uk-UA', 'uk', 'ukr', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Urdu', '乌都语', 'ur', 'ur', 'urd', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Urdu', '乌都语', 'ur-PK', 'ur', 'urd', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Uzbek (Latin)', '乌兹别克语', 'uz', 'uz', 'uzb', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Uzbek (Latin)', '乌兹别克语(西里尔文)', 'uz-UZ', 'uz', 'uzb', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Venda', '文达语', 've', 've', 'ven', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Vietnamese', '越南语', 'vi', 'vi', 'vie', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Vietnamese', '越南语', 'vi-VN', 'vi', 'vie', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Volapük', '沃拉普克语', 'vo', 'vo', 'vol', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Walloon', '瓦隆语', 'wa', 'wa', 'wln', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Wolof', '沃洛夫语', 'wo', 'wo', 'wol', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Xhosa', '班图语', 'xh', 'xh', 'xho', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Yiddish', '意第绪语', 'yi', 'yi', 'yid', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Yoruba', '约鲁巴语', 'yo', 'yo', 'yor', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Zhuang; Chuang', '壮族语', 'za', 'za', 'zha', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Chinese', '中文', 'zh', 'zh', 'chi', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Simplified Chinese', '中文(简体)', 'zh-CN', 'zh', 'chi', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Chinese(Hong Kong)', '中文(香港)', 'zh-HK', 'zh', 'chi', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Chinese(Macao)', '中文(澳门)', 'zh-MO', 'zh', 'chi', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Traditional Chinese', '中文(繁体)', 'zh-TW', 'zh', 'chi', 1, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Zulu', '祖鲁语', 'zu', 'zu', 'zul', 0, '20240001');
INSERT INTO language_code (name_en, name_zh, language_code, code_2, code_3, is_enable, merchant_id) VALUES('Zulu', '祖鲁语', 'zu-ZA', 'zu', 'zul', 0, '20240001');


CREATE TABLE `sales_org`
(
    `id`             int    unsigned      NOT NULL AUTO_INCREMENT COMMENT '组织主键id',
    `name`           varchar(50)  NOT NULL COMMENT '组织名称',
    `p_id`           int          NOT NULL COMMENT '组织上级id',
    `p_ids`          varchar(128) NOT NULL COMMENT '组织上级链条id集合',
    `type`           tinyint      NOT NULL COMMENT '组织类型',
    `address`        varchar(64)           DEFAULT '' COMMENT '组织地址',
    `email`          varchar(64)           DEFAULT '' COMMENT '组织邮箱',
    `phone`          varchar(40)           DEFAULT '' COMMENT '组织电话',
    `area`           varchar(255) NOT NULL COMMENT '组织地区',
    `fax`            varchar(40)           DEFAULT '' COMMENT '组织传真',
    `master`         varchar(64)           DEFAULT '' COMMENT '组织负责人，前台手动输入名称',
    `sort`           int          NOT NULL COMMENT '排序用字段，从小到大排序',
    `remarks`        varchar(128) NOT NULL COMMENT '备注',
    `create_time`    datetime     NOT NULL COMMENT '创建时间',
    `create_user_id` int                   DEFAULT '0' COMMENT '创建人id',
    `update_time`    datetime              DEFAULT NULL COMMENT '更新时间',
    `update_user_id` int                   DEFAULT '0' COMMENT '更新人id',
    `del`            tinyint(1)   NOT NULL DEFAULT '0' COMMENT '删除标识，1-删除，0-未删除',
    `merchant_id`    varchar(32)           DEFAULT NULL COMMENT '商户号',
    PRIMARY KEY (`id`) USING BTREE
) COMMENT ='组织架构表';



CREATE TABLE `user_relation`
(
    `user_id`       int          NOT NULL,
    `user_p_ids`    varchar(128) NOT NULL COMMENT '销售和意向用户关系链',
    `user_inner_id` int          NOT NULL COMMENT '末级销售(作废，无实际意义)',
    `del`           tinyint      NOT NULL,
    `org_id`        int          NOT NULL COMMENT '组织id',
    `user_p_id`     int          NOT NULL COMMENT '上级用户id',
    `merchant_id`   varchar(32) DEFAULT NULL COMMENT '商户号',
    PRIMARY KEY (`user_id`) USING BTREE,
    KEY `INDEX_INNERID` (`user_inner_id`) USING BTREE,
    KEY `INDEX_PIDS` (`user_p_ids`) USING BTREE,
    KEY `idx_PID` (`user_p_id`) USING BTREE COMMENT '索引 p_id'
) COMMENT ='内部用户、意向用户关系表';



CREATE TABLE `user_inner`
(
    `user_id`               int          NOT NULL,
    `name`                  varchar(128) NOT NULL COMMENT '内部用户名',
    `email`                 varchar(64)  NOT NULL COMMENT '用户邮箱',
    `password`              varchar(128) NOT NULL COMMENT '登陆密码',
    `phone`                 varchar(20)           DEFAULT NULL,
    `del`                   tinyint      NOT NULL,
    `create_time`           datetime     NOT NULL,
    `create_user_id`        int          NOT NULL,
    `update_time`           datetime     NOT NULL,
    `update_user_id`        int          NOT NULL,
    `royalty_confed`        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否设置的提成规则，当设置提成规则时根据需求更新该字段',
    `salt`                  varchar(128) NOT NULL COMMENT '盐值',
    `invite_link_id`        int                   DEFAULT NULL COMMENT '邀请链接ID',
    `gen_user_id`           int                   DEFAULT NULL COMMENT '迁移对应的pu的销售userid',
    `auth_random_str`       varchar(50)           DEFAULT NULL COMMENT '2FA使用随机码--32位',
    `auth_status`           int          NOT NULL DEFAULT '1' COMMENT '2FA用户状态：0:取消认证(白名单) 1:未认证  2:已认证',
    `last_login_time`       datetime              DEFAULT NULL COMMENT '上次登录时间',
    `cellxpert_signup_link` varchar(100)          DEFAULT NULL COMMENT 'cellxpert AFFILIATE SIGNUP LINK  注册链接',
    `area_code`             varchar(10)           DEFAULT NULL COMMENT '手机区号',
    `merchant_id`           varchar(32)           DEFAULT NULL COMMENT '商户号',
    `invitation_code`       varchar(16)           DEFAULT NULL COMMENT '邀请码',
    `role_id`               int          NOT NULL COMMENT '角色ID',
    `userPName`             varchar(128)          DEFAULT NULL COMMENT '用户上级名称',
    UNIQUE KEY `user_inner_UN` (`user_id`) USING BTREE,
    KEY `INDEX_EMAIL` (`email`) USING BTREE,
    KEY `INDEX_NAME` (`name`) USING BTREE,
    KEY `INDEX_PHONE` (`phone`) USING BTREE
) COMMENT ='内部用户表';



CREATE TABLE `crm_tb_role`
(
    `id`              int     unsigned     NOT NULL AUTO_INCREMENT,
    `name`            varchar(64)  NOT NULL COMMENT '角色名称',
    `data_scope_type` int          NOT NULL COMMENT '数据权限范围，组织数据或者个人数据',
    `role_type`       tinyint      NOT NULL COMMENT '角色类型1:root 2:外部用户 3:内部用户 4:销售',
    `merchant_id`     varchar(128) NOT NULL COMMENT '商户编号',
    `create_time`     datetime     NOT NULL COMMENT '创建时间',
    `create_user_id`  int                   DEFAULT '0' COMMENT '创建人id',
    `update_time`     datetime              DEFAULT NULL COMMENT '更新时间',
    `update_user_id`  int                   DEFAULT '0' COMMENT '更新人id',
    `del`             int          NOT NULL DEFAULT '0' COMMENT '删除标识，1-删除，0-未删除',
    PRIMARY KEY (`id`) USING BTREE
) COMMENT ='角色表';
