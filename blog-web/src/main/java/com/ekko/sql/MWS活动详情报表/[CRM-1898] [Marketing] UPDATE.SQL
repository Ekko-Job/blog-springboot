
-- --------------------------------------------------
-- MWS # marketing
-- --------------------------------------------------
update p_role set permission_show = replace(permission_show, ',"ReportManage"', '') where permission_show like '%Dashboard%';




-- --------------------------------------------------
-- MWS # marketing
-- --------------------------------------------------
ALTER TABLE `activity_tick_details`
    ADD COLUMN `merchants_id` int NOT NULL COMMENT '商户号';
