-- 清理不需要的菜单（可重复执行）
-- 用法：
--   docker exec -i slion-service-postgres psql -U postgres -d slion < scripts/sql/postgres/upgrade/20260810-cleanup-unused-menus.sql
--
-- 删除范围：
--   PLUS官网(4)
--   系统工具及子菜单(3,115,116,1055-1060)
--   测试菜单及子菜单(5,1500-1511)
--   Admin监控(117)、任务调度中心(120)
--   租户套餐管理(122,1611-1615)

WITH doomed AS (
    SELECT unnest(ARRAY[
        3, 4, 5,
        115, 116, 117, 120, 122,
        1055, 1056, 1057, 1058, 1059, 1060,
        1500, 1501, 1502, 1503, 1504, 1505,
        1506, 1507, 1508, 1509, 1510, 1511,
        1611, 1612, 1613, 1614, 1615
    ]::bigint[]) AS menu_id
)
DELETE FROM sys_role_menu rm
USING doomed d
WHERE rm.menu_id = d.menu_id;

WITH doomed AS (
    SELECT unnest(ARRAY[
        3, 4, 5,
        115, 116, 117, 120, 122,
        1055, 1056, 1057, 1058, 1059, 1060,
        1500, 1501, 1502, 1503, 1504, 1505,
        1506, 1507, 1508, 1509, 1510, 1511,
        1611, 1612, 1613, 1614, 1615
    ]::bigint[]) AS menu_id
)
DELETE FROM sys_menu m
USING doomed d
WHERE m.menu_id = d.menu_id;
