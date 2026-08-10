-- 将菜单组件路径对齐 SlionWeb 视图（若已使用 01-biz / 03-workflow 初始化可再执行本脚本做增量修正）
-- 系统管理
UPDATE sys_menu SET component = 'system/user/index' WHERE menu_id = 100;
UPDATE sys_menu SET component = 'system/role/index' WHERE menu_id = 101;
UPDATE sys_menu SET component = 'system/menu/index' WHERE menu_id = 102;
UPDATE sys_menu SET component = 'system/dept/index' WHERE menu_id = 103;
UPDATE sys_menu SET component = 'system/tenant/index' WHERE menu_id = 121;

-- 工作流（对齐现有页面）
UPDATE sys_menu SET component = 'workflow/task/taskWaiting' WHERE menu_id = 11619;
UPDATE sys_menu SET component = 'workflow/task/taskFinish' WHERE menu_id = 11632;
UPDATE sys_menu SET component = 'workflow/task/allTaskWaiting' WHERE menu_id = 11631;
UPDATE sys_menu SET component = 'workflow/task/myDocument' WHERE menu_id = 11629;
UPDATE sys_menu SET component = 'workflow/task/taskCopyList' WHERE menu_id = 11633;
UPDATE sys_menu SET component = 'workflow/spel/index' WHERE menu_id = 11801;
UPDATE sys_menu SET component = 'workflow/form/index' WHERE menu_id = 11810;
UPDATE sys_menu SET path = 'formDesigner', component = 'workflow/form/designer' WHERE menu_id = 11816;
UPDATE sys_menu SET component = 'workflow/processDefinition/index' WHERE menu_id = 11620;
UPDATE sys_menu SET component = 'workflow/processInstance/index' WHERE menu_id = 11621;
UPDATE sys_menu SET component = 'workflow/category/index' WHERE menu_id = 11622;

-- 我的任务归入工作流
UPDATE sys_menu SET parent_id = 11616, order_num = 0 WHERE menu_id = 11618 AND parent_id = 0;
