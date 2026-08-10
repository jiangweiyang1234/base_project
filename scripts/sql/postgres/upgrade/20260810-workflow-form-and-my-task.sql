-- 流程表单表 + 我的任务挂到工作流 + 流程表单菜单
-- 用法示例：
--   docker exec -i slion-service-postgres psql -U postgres -d slion < scripts/sql/postgres/upgrade/20260810-workflow-form-and-my-task.sql

-- 1) Warm-Flow 流程表单表
CREATE TABLE IF NOT EXISTS flow_form
(
    id           int8         NOT NULL,
    form_code    varchar(40)  NOT NULL,
    form_name    varchar(100) NOT NULL,
    "version"    varchar(20)  NOT NULL,
    is_publish   int2         NOT NULL DEFAULT 0,
    form_type    int2         NULL     DEFAULT 0,
    form_path    varchar(100) NULL,
    form_content text         NULL,
    ext          varchar(400) NULL,
    create_time  timestamp    NULL,
    create_by    varchar(64)  NULL     DEFAULT ''::character varying,
    update_time  timestamp    NULL,
    update_by    varchar(64)  NULL     DEFAULT ''::character varying,
    del_flag     bpchar(1)    NULL     DEFAULT '0'::character varying,
    tenant_id    varchar(40)  NULL,
    CONSTRAINT flow_form_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE flow_form IS '流程表单表';
COMMENT ON COLUMN flow_form.id IS '主键id';
COMMENT ON COLUMN flow_form.form_code IS '表单编码';
COMMENT ON COLUMN flow_form.form_name IS '表单名称';
COMMENT ON COLUMN flow_form."version" IS '表单版本';
COMMENT ON COLUMN flow_form.is_publish IS '是否发布（0未发布 1已发布 9失效）';
COMMENT ON COLUMN flow_form.form_type IS '表单类型（0内置表单存form_content 1外挂表单存form_path）';
COMMENT ON COLUMN flow_form.form_path IS '表单路径';
COMMENT ON COLUMN flow_form.form_content IS '表单内容';
COMMENT ON COLUMN flow_form.ext IS '表单扩展';
COMMENT ON COLUMN flow_form.create_time IS '创建时间';
COMMENT ON COLUMN flow_form.create_by IS '创建人';
COMMENT ON COLUMN flow_form.update_time IS '更新时间';
COMMENT ON COLUMN flow_form.update_by IS '更新人';
COMMENT ON COLUMN flow_form.del_flag IS '删除标志';
COMMENT ON COLUMN flow_form.tenant_id IS '租户id';

-- 2) 「我的任务」挂到「工作流」下作为二级菜单（原子菜单自动变三级）
UPDATE sys_menu
SET parent_id = 11616,
    order_num = 0
WHERE menu_id = 11618
  AND parent_id = 0;

-- 3) 流程表单管理菜单
INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11810, '流程表单', 11616, 2, 'form', 'workflow/form/index', '',
       '1', '0', 'C', '0', '0', 'workflow:form:list', 'file-list-3-line',
       103, 1, now(), NULL, NULL, '流程表单管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11810);

INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11811, '流程表单查询', 11810, 1, '#', '', '',
       '1', '0', 'F', '0', '0', 'workflow:form:query', '#',
       103, 1, now(), NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11811);

INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11812, '流程表单新增', 11810, 2, '#', '', '',
       '1', '0', 'F', '0', '0', 'workflow:form:add', '#',
       103, 1, now(), NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11812);

INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11813, '流程表单修改', 11810, 3, '#', '', '',
       '1', '0', 'F', '0', '0', 'workflow:form:edit', '#',
       103, 1, now(), NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11813);

INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11814, '流程表单删除', 11810, 4, '#', '', '',
       '1', '0', 'F', '0', '0', 'workflow:form:remove', '#',
       103, 1, now(), NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11814);

INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11815, '流程表单发布', 11810, 5, '#', '', '',
       '1', '0', 'F', '0', '0', 'workflow:form:publish', '#',
       103, 1, now(), NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11815);

INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11816, '表单设计', 11616, 8, 'form/designer', 'workflow/form/designer', '',
       '1', '1', 'C', '1', '0', 'workflow:form:edit', '#',
       103, 1, now(), NULL, NULL, '/workflow/form'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11816);

-- 超级管理员角色授权
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 1, m.menu_id
FROM (VALUES (11810), (11811), (11812), (11813), (11814), (11815), (11816)) AS m(menu_id)
WHERE NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = m.menu_id
);

-- 调整排序：表单=2，表达式=3，定义=4，监控=5
UPDATE sys_menu SET order_num = 3 WHERE menu_id = 11801;
UPDATE sys_menu SET order_num = 4 WHERE menu_id = 11620;
UPDATE sys_menu SET order_num = 5 WHERE menu_id = 11630;
