
-- --------------------------------------------------
-- MWS # marketing
-- --------------------------------------------------
-- 1、执行此SQL
INSERT INTO api_path (`method`, uri, must_login, del) VALUES('GET', '/activityTickDetails/list', 1, 0);
-- 2、执行此SQL
INSERT INTO permission (code, name, api_id, p_id, url, fe_icon, permission_type, can_cache, sort, create_time, create_user_id, update_time, update_user_id, del)
VALUES('func_report_tick_download', '下载报表',
       (SELECT JSON_ARRAYAGG(id) FROM api_path WHERE method = 'GET' AND uri = '/activityTickDetails/list' AND must_login = 1),
       'ActivityTick', NULL, '1', 1, 0, 2, NOW(), '1', NOW(), '1', 0);
INSERT INTO permission (code, name, api_id, p_id, url, fe_icon, permission_type, can_cache, sort, create_time, create_user_id, update_time, update_user_id, del)
VALUES('func_report_tick_list', '列表查询',
       (SELECT JSON_ARRAYAGG(id) FROM api_path WHERE method = 'GET' AND uri = '/activityTickDetails/list' AND must_login = 1),
       'ActivityTick', NULL, '1', 1, 0, 1, NOW(), '1', NOW(), '1', 0);
INSERT INTO permission (code, name, api_id, p_id, url, fe_icon, permission_type, can_cache, sort, create_time, create_user_id, update_time, update_user_id, del)
VALUES('ActivityTick', '客户勾选详情报表', 'null', 'ReportManage', '/report/tick', '1', 0, 0, 5, NOW(), '1', NOW(), '1', 0);


INSERT INTO permission (code, name, api_id, p_id, url, fe_icon, permission_type, can_cache, sort, create_time, create_user_id, update_time, update_user_id, del)
VALUES('func_report_tick_download', '下载报表',
       (SELECT CAST(JSON_ARRAYAGG(id) AS CHAR) FROM api_path WHERE method = 'GET' AND uri = '/activityTickDetails/list' AND must_login = 1),
       'ActivityTick', NULL, '1', 1, 0, 2, NOW(), '1', NOW(), '1', 0);
