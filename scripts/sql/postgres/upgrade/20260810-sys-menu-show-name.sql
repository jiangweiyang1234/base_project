-- 已有 Postgres 环境升级：sys_menu 增加 show_name（与 SysMenu.showName 对齐）
-- 用法示例：
--   docker exec -i slion-service-postgres psql -U postgres -d slion < scripts/sql/postgres/upgrade/20260810-sys-menu-show-name.sql

ALTER TABLE sys_menu ADD COLUMN IF NOT EXISTS show_name varchar(50) DEFAULT NULL;
COMMENT ON COLUMN sys_menu.show_name IS '显示菜单名称';
