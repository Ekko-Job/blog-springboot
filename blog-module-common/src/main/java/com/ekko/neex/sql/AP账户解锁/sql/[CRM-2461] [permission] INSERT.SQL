CREATE TABLE `hr_sales`
(
    `id`                int NOT NULL AUTO_INCREMENT,
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
    `id`               int NOT NULL AUTO_INCREMENT,
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
    `id`             int          NOT NULL AUTO_INCREMENT COMMENT '组织主键id',
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
    `id`              int          NOT NULL AUTO_INCREMENT,
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
