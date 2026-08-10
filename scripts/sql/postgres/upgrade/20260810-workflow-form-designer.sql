-- 流程表单可视化设计器：隐藏路由菜单（与「流程设计」同类）
-- 用法示例：
--   docker exec -i slion-service-postgres psql -U postgres -d slion < scripts/sql/postgres/upgrade/20260810-workflow-form-designer.sql

INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_dept, create_by, create_time, update_by, update_time, remark
)
SELECT 11816, '表单设计', 11616, 8, 'form/designer', 'workflow/form/designer', '',
       '1', '1', 'C', '1', '0', 'workflow:form:edit', '#',
       103, 1, now(), NULL, NULL, '/workflow/form'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 11816);

INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 1, 11816
WHERE NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = 11816
);
