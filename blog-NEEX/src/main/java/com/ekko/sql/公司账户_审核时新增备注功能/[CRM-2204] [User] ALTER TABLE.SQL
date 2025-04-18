-- --------------------------------------------------
--   Cloud  &  user
-- --------------------------------------------------


ALTER TABLE `rebate_account`
    MODIFY COLUMN `comments` VARCHAR(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '审核备注';
