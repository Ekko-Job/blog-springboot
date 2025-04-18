INSERT INTO `tb_permission` (p_id, p_ids,
                             dev_title, fe_code, fe_icon, permission_type, terminal_type, sort,
                             request_uri, can_cache, hidden,
                             create_time, create_user_id, update_time, update_user_id, del, `component`, i18n_key)
VALUES ((SELECT p_id
         FROM (SELECT p_id
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Limitation'
                 AND tb_permission.del = 0) AS parent_id),
        (SELECT p_ids
         FROM (SELECT p_ids
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Limitation'
                 AND tb_permission.del = 0) AS t),
        '授權用戶', 'Authorization', '', 1, 1, 6,
        ',GET:/user/authorization,', 1, 0,
        NOW(), 1, NOW(), 1, 0, 'Authorization', 'Authorization'),

       ((SELECT id
         FROM (SELECT id
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS parent_id),
        (SELECT t.ids
         FROM (SELECT CONCAT(p_ids, id, ',') AS ids
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS t),
        '列表', 'authorize_user_list', '', 2, 1, 1,
        ',GET:/user/operation/authorization/list,', 0, 0,
        NOW(), 1, NOW(), 1, 0, '', 'purview_authorize_user_list'),

       ((SELECT id
         FROM (SELECT id
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS parent_id),
        (SELECT t.ids
         FROM (SELECT CONCAT(p_ids, id, ',') AS ids
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS t),
        '新增', 'authorize_user_add', '', 2, 1, 2,
        ',POST:/user/operation/authorization/add,GET:/user/operation/authorization/list,', 0, 0,
        NOW(), 1, NOW(), 1, 0, '', 'purview_authorize_user_add'),

       ((SELECT id
         FROM (SELECT id
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS parent_id),
        (SELECT t.ids
         FROM (SELECT CONCAT(p_ids, id, ',') AS ids
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS t),
        '編輯', 'authorize_user_edit', '', 2, 1, 3,
        ',PUT:/user/operation/authorization/edit,GET:/user/operation/authorization/list,', 0, 0,
        NOW(), 1, NOW(), 1, 0, '', 'purview_authorize_user_edit'),

       ((SELECT id
         FROM (SELECT id
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS parent_id),
        (SELECT t.ids
         FROM (SELECT CONCAT(p_ids, id, ',') AS ids
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS t),
        '刪除', 'authorize_user_delete', '', 2, 1, 4,
        ',DELETE:/user/operation/authorization/delete,GET:/user/operation/authorization/list,', 0, 0,
        NOW(), 1, NOW(), 1, 0, '', 'purview_authorize_user_delete'),

       ((SELECT id
         FROM (SELECT id
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS parent_id),
        (SELECT t.ids
         FROM (SELECT CONCAT(p_ids, id, ',') AS ids
               FROM tb_permission
               WHERE tb_permission.fe_code = 'Authorization'
                 AND tb_permission.del = 0) AS t),
        '查詢操作紀錄', 'authorize_user_logs', '', 2, 1, 5,
        ',POST:/user/operation/authorization/logs,GET:/user/operation/authorization/list,', 0, 0,
        NOW(), 1, NOW(), 1, 0, '', 'purview_authorize_user_logs')
;








