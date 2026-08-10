-- ----------------------------
-- 第三方平台授权表
-- ----------------------------
create table sys_social
(
    id                 int8             not null,
    user_id            int8             not null,
    tenant_id          varchar(20)      default '000000',
    auth_id            varchar(255)     not null,
    source             varchar(255)     not null,
    open_id            varchar(255)     default null,
    user_name          varchar(30)      not null,
    nick_name          varchar(30)      default '',
    email              varchar(255)     default '',
    avatar             varchar(500)     default '',
    access_token       varchar(2000)    not null,
    expire_in          int8             default null,
    refresh_token      varchar(2000)    default null,
    access_code        varchar(255)     default null,
    union_id           varchar(255)     default null,
    scope              varchar(255)     default null,
    token_type         varchar(255)     default null,
    id_token           varchar(2000)    default null,
    mac_algorithm      varchar(255)     default null,
    mac_key            varchar(255)     default null,
    code               varchar(255)     default null,
    oauth_token        varchar(255)     default null,
    oauth_token_secret varchar(255)     default null,
    create_dept        int8,
    create_by          int8,
    create_time        timestamp,
    update_by          int8,
    update_time        timestamp,
    del_flag           char             default '0'::bpchar,
    constraint "pk_sys_social" primary key (id)
);
































-- ----------------------------
-- 租户表
-- ----------------------------
create table if not exists sys_tenant
(
    id                int8,
    tenant_id         varchar(20)   not null,
    contact_user_name varchar(20)   default null,
    contact_phone     varchar(20)   default null,
    company_name      varchar(30)   default null,
    license_number    varchar(30)   default null,
    address           varchar(200)  default null,
    intro             varchar(200)  default null,
    domain            varchar(200)  default null,
    remark            varchar(200)  default null,
    package_id        int8,
    expire_time       timestamp,
    account_count     int4          default -1,
    status            char          default '0'::bpchar,
    del_flag          char          default '0'::bpchar,
    create_dept       int8,
    create_by         int8,
    create_time       timestamp,
    update_by         int8,
    update_time       timestamp,
    constraint "pk_sys_tenant" primary key (id)
);
























-- ----------------------------
-- 初始化-租户表数据
-- ----------------------------

insert into sys_tenant values(1, '000000', '管理组', '15888888888', 'XXX有限公司', null, null, '多租户通用后台管理管理系统', null, null, null, null, -1, '0', '0', 103, 1, now(), null, null);


-- ----------------------------
-- 租户套餐表
-- ----------------------------
create table if not exists sys_tenant_package
(
    package_id          int8,
    package_name        varchar(20)     default '',
    menu_ids            varchar(3000)   default '',
    remark              varchar(200)    default '',
    menu_check_strictly bool            default true,
    status              char            default '0'::bpchar,
    del_flag            char            default '0'::bpchar,
    create_dept         int8,
    create_by           int8,
    create_time         timestamp,
    update_by           int8,
    update_time         timestamp,
    constraint "pk_sys_tenant_package" primary key (package_id)
);
















-- ----------------------------
-- 1、部门表
-- ----------------------------
create table if not exists sys_dept
(
    dept_id     int8,
    tenant_id   varchar(20) default '000000',
    parent_id   int8        default 0,
    ancestors   varchar(500)default '',
    dept_name   varchar(30) default '',
    dept_category varchar(100) default null,
    order_num   int4        default 0,
    leader      int8        default null,
    phone       varchar(11) default null,
    email       varchar(50) default null,
    status      char        default '0'::bpchar,
    del_flag    char        default '0'::bpchar,
    create_dept int8,
    create_by   int8,
    create_time timestamp,
    update_by   int8,
    update_time timestamp,
    constraint "sys_dept_pk" primary key (dept_id)
);




















-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------
insert into sys_dept values(100, '000000', 0,   '0',          'XXX科技',   null,0, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(101, '000000', 100, '0,100',      '深圳总公司', null,1, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(102, '000000', 100, '0,100',      '长沙分公司', null,2, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(103, '000000', 101, '0,100,101',  '研发部门',   null,1, 1, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(104, '000000', 101, '0,100,101',  '市场部门',   null,2, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(105, '000000', 101, '0,100,101',  '测试部门',   null,3, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(106, '000000', 101, '0,100,101',  '财务部门',   null,4, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(107, '000000', 101, '0,100,101',  '运维部门',   null,5, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(108, '000000', 102, '0,100,102',  '市场部门',   null,1, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);
insert into sys_dept values(109, '000000', 102, '0,100,102',  '财务部门',   null,2, null, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, now(), null, null);

-- ----------------------------
-- 2、用户信息表
-- ----------------------------
create table if not exists sys_user
(
    user_id     int8,
    tenant_id   varchar(20)  default '000000',
    dept_id     int8,
    user_name   varchar(30)  not null,
    nick_name   varchar(30)  not null,
    user_type   varchar(10)  default 'sys_user',
    email       varchar(50)  default '',
    phonenumber varchar(11)  default '',
    sex         char         default '0'::bpchar,
    avatar      int8,
    password    varchar(100) default '',
    status      char         default '0'::bpchar,
    del_flag    char         default '0'::bpchar,
    login_ip    varchar(128) default '',
    login_date  timestamp,
    create_dept int8,
    create_by   int8,
    create_time timestamp,
    update_by   int8,
    update_time timestamp,
    remark      varchar(500) default null,
    constraint "sys_user_pk" primary key (user_id)
);
























-- ----------------------------

-- 初始化-用户信息表数据
-- ----------------------------
insert into sys_user values(1, '000000', 103, 'admin', '疯狂的狮子Li', 'sys_user', 'crazyLionLi@163.com', '15888888888', '1', null, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', now(), 103, 1, now(), null, null, '管理员');
insert into sys_user VALUES(3, '000000', 108, 'test', '本部门及以下 密码666666', 'sys_user', '', '', '0', null, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', now(), 103, 1, now(), 3, now(), NULL);
insert into sys_user VALUES(4, '000000', 102, 'test1', '仅本人 密码666666', 'sys_user', '', '', '0', null, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', now(), 103, 1, now(), 4, now(), NULL);

-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
create table if not exists sys_post
(
    post_id     int8,
    tenant_id   varchar(20) default '000000',
    dept_id     int8,
    post_code   varchar(64) not null,
    post_category   varchar(100) default null,
    post_name   varchar(50) not null,
    post_sort   int4        not null,
    status      char        not null,
    create_dept int8,
    create_by   int8,
    create_time timestamp,
    update_by   int8,
    update_time timestamp,
    remark      varchar(500) default null,
    constraint "sys_post_pk" primary key (post_id)
);

















-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
insert into sys_post values(1, '000000', 103, 'ceo',  null, '董事长',    1, '0', 103, 1, now(), null, null, '');
insert into sys_post values(2, '000000', 100, 'se',   null, '项目经理',  2, '0', 103, 1, now(), null, null, '');
insert into sys_post values(3, '000000', 100, 'hr',   null, '人力资源',  3, '0', 103, 1, now(), null, null, '');
insert into sys_post values(4, '000000', 100, 'user', null, '普通员工',  4, '0', 103, 1, now(), null, null, '');

-- ----------------------------
-- 4、角色信息表
-- ----------------------------
create table if not exists sys_role
(
    role_id             int8,
    tenant_id           varchar(20)  default '000000',
    role_name           varchar(30)  not null,
    role_key            varchar(100) not null,
    role_sort           int4         not null,
    data_scope          char         default '1'::bpchar,
    menu_check_strictly bool         default true,
    dept_check_strictly bool         default true,
    status              char         not null,
    del_flag            char         default '0'::bpchar,
    create_dept         int8,
    create_by           int8,
    create_time         timestamp,
    update_by           int8,
    update_time         timestamp,
    remark              varchar(500) default null,
    constraint "sys_role_pk" primary key (role_id)
);



















-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into sys_role values('1', '000000', '超级管理员',  'superadmin',  1, '1', 't', 't', '0', '0', 103, 1, now(), null, null, '超级管理员');
insert into sys_role values('3', '000000', '本部门及以下', 'test1', 3, '4', 't', 't', '0', '0', 103, 1, now(), NULL, NULL, '');
insert into sys_role values('4', '000000', '仅本人', 'test2', 4, '5', 't', 't', '0', '0', 103, 1, now(), NULL, NULL, '');

-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
create table if not exists sys_menu
(
    menu_id     int8,
    menu_name   varchar(50) not null,
    parent_id   int8         default 0,
    order_num   int4         default 0,
    path        varchar(200) default '',
    component   varchar(255) default null,
    query_param varchar(255) default null,
    is_frame    char         default '1'::bpchar,
    is_cache    char         default '0'::bpchar,
    menu_type   char         default ''::bpchar,
    visible     char         default '0'::bpchar,
    status      char         default '0'::bpchar,
    perms       varchar(100) default null,
    icon        varchar(100) default '#',
    create_dept int8,
    create_by   int8,
    create_time timestamp,
    update_by   int8,
    update_time timestamp,
    remark      varchar(500) default '',
    constraint "sys_menu_pk" primary key (menu_id)
);























-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
-- 一级菜单
insert into sys_menu values('1', '系统管理', '0', '1', 'system',           null, '', '1', '0', 'M', '0', '0', '', 'system',   103, 1, now(), null, null, '系统管理目录');
insert into sys_menu values('6', '租户管理', '0', '2', 'tenant',           null, '', '1', '0', 'M', '0', '0', '', 'chart',    103, 1, now(), null, null, '租户管理目录');
insert into sys_menu values('2', '系统监控', '0', '3', 'monitor',          null, '', '1', '0', 'M', '0', '0', '', 'monitor',  103, 1, now(), null, null, '系统监控目录');
insert into sys_menu values('3', '系统工具', '0', '4', 'tool',             null, '', '1', '0', 'M', '0', '0', '', 'tool',     103, 1, now(), null, null, '系统工具目录');
insert into sys_menu values('4', 'PLUS官网', '0', '5', 'https://gitee.com/dromara/RuoYi-Vue-Plus', null, '', '0', '0', 'M', '0', '0', '', 'guide',    103, 1, now(), null, null, 'RuoYi-Vue-Plus官网地址');
insert into sys_menu VALUES('5', '测试菜单', '0', '5', 'demo',             null, '', '1', '0', 'M', '0', '0', null, 'star',       103, 1, now(), null, null, '测试菜单');
-- 二级菜单
insert into sys_menu values('100',  '用户管理',     '1',   '1', 'user',             'system/user/index',            '', '1', '0', 'C', '0', '0', 'system:user:list',            'user',          103, 1, now(), null, null, '用户管理菜单');
insert into sys_menu values('101',  '角色管理',     '1',   '2', 'role',             'system/role/index',            '', '1', '0', 'C', '0', '0', 'system:role:list',            'peoples',       103, 1, now(), null, null, '角色管理菜单');
insert into sys_menu values('102',  '菜单管理',     '1',   '3', 'menu',             'system/menu/index',            '', '1', '0', 'C', '0', '0', 'system:menu:list',            'tree-table',    103, 1, now(), null, null, '菜单管理菜单');
insert into sys_menu values('103',  '部门管理',     '1',   '4', 'dept',             'system/dept/index',            '', '1', '0', 'C', '0', '0', 'system:dept:list',            'tree',          103, 1, now(), null, null, '部门管理菜单');
insert into sys_menu values('104',  '岗位管理',     '1',   '5', 'post',             'system/post/index',            '', '1', '0', 'C', '0', '0', 'system:post:list',            'post',          103, 1, now(), null, null, '岗位管理菜单');
insert into sys_menu values('105',  '字典管理',     '1',   '6', 'dict',             'system/dict/index',            '', '1', '0', 'C', '0', '0', 'system:dict:list',            'dict',          103, 1, now(), null, null, '字典管理菜单');
insert into sys_menu values('106',  '参数设置',     '1',   '7', 'config',           'system/config/index',          '', '1', '0', 'C', '0', '0', 'system:config:list',          'edit',          103, 1, now(), null, null, '参数设置菜单');
insert into sys_menu values('107',  '通知公告',     '1',   '8', 'notice',           'system/notice/index',          '', '1', '0', 'C', '0', '0', 'system:notice:list',          'message',       103, 1, now(), null, null, '通知公告菜单');
insert into sys_menu values('108',  '日志管理',     '1',   '9', 'log',              '',                             '', '1', '0', 'M', '0', '0', '',                            'log',           103, 1, now(), null, null, '日志管理菜单');
insert into sys_menu values('109',  '在线用户',     '2',   '1', 'online',           'monitor/online/index',         '', '1', '0', 'C', '0', '0', 'monitor:online:list',         'online',        103, 1, now(), null, null, '在线用户菜单');
insert into sys_menu values('113',  '缓存监控',     '2',   '5', 'cache',            'monitor/cache/index',          '', '1', '0', 'C', '0', '0', 'monitor:cache:list',          'redis',         103, 1, now(), null, null, '缓存监控菜单');
insert into sys_menu values('115',  '代码生成',     '3',   '2', 'gen',              'tool/gen/index',               '', '1', '0', 'C', '0', '0', 'tool:gen:list',               'code',          103, 1, now(), null, null, '代码生成菜单');
insert into sys_menu values('121',  '租户管理',     '6',   '1', 'tenant',           'system/tenant/index',          '', '1', '0', 'C', '0', '0', 'system:tenant:list',          'list',          103, 1, now(), null, null, '租户管理菜单');
insert into sys_menu values('122',  '租户套餐管理', '6',   '2', 'tenantPackage',    'system/tenantPackage/index',   '', '1', '0', 'C', '0', '0', 'system:tenantPackage:list',   'form',          103, 1, now(), null, null, '租户套餐管理菜单');
insert into sys_menu values('123',  '客户端管理',   '1',   '11', 'client',           'system/client/index',          '', '1', '0', 'C', '0', '0', 'system:client:list',          'international', 103, 1, now(), null, null, '客户端管理菜单');
insert into sys_menu values('116', '修改生成配置',  '3',   '2', 'gen-edit/index/:tableId', 'tool/gen/editTable', '', '1', '1', 'C', '1', '0', 'tool:gen:edit',           '#',               103, 1, now(), null, null, '/tool/gen');
insert into sys_menu values('130', '分配用户',     '1',   '2', 'role-auth/user/:roleId', 'system/role/authUser', '', '1', '1', 'C', '1', '0', 'system:role:edit',      '#',               103, 1, now(), null, null, '/system/role');
insert into sys_menu values('131', '分配角色',     '1',   '1', 'user-auth/role/:userId', 'system/user/authRole', '', '1', '1', 'C', '1', '0', 'system:user:edit',      '#',               103, 1, now(), null, null, '/system/user');
insert into sys_menu values('132', '字典数据',     '1',   '6', 'dict-data/index/:dictId', 'system/dict/data', '', '1', '1', 'C', '1', '0', 'system:dict:list',         '#',               103, 1, now(), null, null, '/system/dict');
insert into sys_menu values('133', '文件配置管理',  '1',   '10', 'oss-config/index',              'system/oss/config', '', '1', '1', 'C', '1', '0', 'system:ossConfig:list',  '#',                103, 1, now(), null, null, '/system/oss');

-- springboot-admin监控
insert into sys_menu values('117',  'Admin监控',   '2',   '5',  'Admin',            'monitor/admin/index',         '', '1', '0', 'C', '0', '0', 'monitor:admin:list',          'dashboard',     103, 1, now(), null, null, 'Admin监控菜单');
-- oss菜单
insert into sys_menu values('118',  '文件管理',     '1',   '10', 'oss',              'system/oss/index',            '', '1', '0', 'C', '0', '0', 'system:oss:list',             'upload',        103, 1, now(), null, null, '文件管理菜单');
-- snail-job server控制台
insert into sys_menu values('120',  '任务调度中心',  '2',   '6',  'snailjob',     'monitor/snailjob/index',    '', '1', '0', 'C', '0', '0', 'monitor:snailjob:list',          'job',           103, 1, now(), null, null, 'SnailJob控制台菜单');

-- 三级菜单
insert into sys_menu values('500',  '操作日志', '108', '1', 'operlog',    'monitor/operlog/index',    '', '1', '0', 'C', '0', '0', 'monitor:operlog:list',    'form',          103, 1, now(), null, null, '操作日志菜单');
insert into sys_menu values('501',  '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor',    103, 1, now(), null, null, '登录日志菜单');
-- 用户管理按钮
insert into sys_menu values('1001', '用户查询', '100', '1',  '', '', '', '1', '0', 'F', '0', '0', 'system:user:query',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1002', '用户新增', '100', '2',  '', '', '', '1', '0', 'F', '0', '0', 'system:user:add',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1003', '用户修改', '100', '3',  '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit',           '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1004', '用户删除', '100', '4',  '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1005', '用户导出', '100', '5',  '', '', '', '1', '0', 'F', '0', '0', 'system:user:export',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1006', '用户导入', '100', '6',  '', '', '', '1', '0', 'F', '0', '0', 'system:user:import',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1007', '重置密码', '100', '7',  '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd',       '#', 103, 1, now(), null, null, '');
-- 角色管理按钮
insert into sys_menu values('1008', '角色查询', '101', '1',  '', '', '', '1', '0', 'F', '0', '0', 'system:role:query',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1009', '角色新增', '101', '2',  '', '', '', '1', '0', 'F', '0', '0', 'system:role:add',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1010', '角色修改', '101', '3',  '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit',           '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1011', '角色删除', '101', '4',  '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1012', '角色导出', '101', '5',  '', '', '', '1', '0', 'F', '0', '0', 'system:role:export',         '#', 103, 1, now(), null, null, '');
-- 菜单管理按钮
insert into sys_menu values('1013', '菜单查询', '102', '1',  '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1014', '菜单新增', '102', '2',  '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1015', '菜单修改', '102', '3',  '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit',           '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1016', '菜单删除', '102', '4',  '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove',         '#', 103, 1, now(), null, null, '');
-- 部门管理按钮
insert into sys_menu values('1017', '部门查询', '103', '1',  '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1018', '部门新增', '103', '2',  '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1019', '部门修改', '103', '3',  '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit',           '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1020', '部门删除', '103', '4',  '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove',         '#', 103, 1, now(), null, null, '');
-- 岗位管理按钮
insert into sys_menu values('1021', '岗位查询', '104', '1',  '', '', '', '1', '0', 'F', '0', '0', 'system:post:query',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1022', '岗位新增', '104', '2',  '', '', '', '1', '0', 'F', '0', '0', 'system:post:add',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1023', '岗位修改', '104', '3',  '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit',           '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1024', '岗位删除', '104', '4',  '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1025', '岗位导出', '104', '5',  '', '', '', '1', '0', 'F', '0', '0', 'system:post:export',         '#', 103, 1, now(), null, null, '');
-- 字典管理按钮
insert into sys_menu values('1026', '字典查询', '105', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1027', '字典新增', '105', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1028', '字典修改', '105', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit',           '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1029', '字典删除', '105', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1030', '字典导出', '105', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export',         '#', 103, 1, now(), null, null, '');
-- 参数设置按钮
insert into sys_menu values('1031', '参数查询', '106', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query',        '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1032', '参数新增', '106', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1033', '参数修改', '106', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1034', '参数删除', '106', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove',       '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1035', '参数导出', '106', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export',       '#', 103, 1, now(), null, null, '');
-- 通知公告按钮
insert into sys_menu values('1036', '公告查询', '107', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query',        '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1037', '公告新增', '107', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1038', '公告修改', '107', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1039', '公告删除', '107', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove',       '#', 103, 1, now(), null, null, '');
-- 操作日志按钮
insert into sys_menu values('1040', '操作查询', '500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query',      '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1041', '操作删除', '500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove',     '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1042', '日志导出', '500', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export',     '#', 103, 1, now(), null, null, '');
-- 登录日志按钮
insert into sys_menu values('1043', '登录查询', '501', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query',   '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1044', '登录删除', '501', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove',  '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1045', '日志导出', '501', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export',  '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1050', '账户解锁', '501', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock',  '#', 103, 1, now(), null, null, '');
-- 在线用户按钮
insert into sys_menu values('1046', '在线查询', '109', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query',       '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1047', '批量强退', '109', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1048', '单条强退', '109', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 103, 1, now(), null, null, '');
-- 代码生成按钮
insert into sys_menu values('1055', '生成查询', '115', '1', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query',             '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1056', '生成修改', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit',              '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1057', '生成删除', '115', '3', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1058', '导入代码', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import',            '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1059', '预览代码', '115', '4', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview',           '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1060', '生成代码', '115', '5', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code',              '#', 103, 1, now(), null, null, '');
-- oss相关按钮
insert into sys_menu values('1600', '文件查询', '118', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:query',        '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1601', '文件上传', '118', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:upload',       '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1602', '文件下载', '118', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:download',     '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1603', '文件删除', '118', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:remove',       '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1620', '配置列表', '118', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:list',   '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1621', '配置添加', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:add',    '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1622', '配置编辑', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:edit',   '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1623', '配置删除', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:remove', '#', 103, 1, now(), null, null, '');
-- 租户管理相关按钮
insert into sys_menu values('1606', '租户查询', '121', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:query',   '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1607', '租户新增', '121', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:add',     '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1608', '租户修改', '121', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:edit',    '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1609', '租户删除', '121', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:remove',  '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1610', '租户导出', '121', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:export',  '#', 103, 1, now(), null, null, '');
-- 租户套餐管理相关按钮
insert into sys_menu values('1611', '租户套餐查询', '122', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:query',   '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1612', '租户套餐新增', '122', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:add',     '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1613', '租户套餐修改', '122', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:edit',    '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1614', '租户套餐删除', '122', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:remove',  '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1615', '租户套餐导出', '122', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:export',  '#', 103, 1, now(), null, null, '');
-- 客户端管理按钮
insert into sys_menu values('1061', '客户端管理查询', '123', '1',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:query',        '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1062', '客户端管理新增', '123', '2',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:add',          '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1063', '客户端管理修改', '123', '3',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:edit',         '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1064', '客户端管理删除', '123', '4',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:remove',       '#', 103, 1, now(), null, null, '');
insert into sys_menu values('1065', '客户端管理导出', '123', '5',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:export',       '#', 103, 1, now(), null, null, '');
-- 测试菜单
INSERT INTO sys_menu VALUES('1500', '测试单表',     '5',   '1', 'demo', 'demo/demo/index', '',  '1', '0', 'C', '0', '0', 'demo:demo:list', '#', 103, 1, now(), NULL, NULL, '测试单表菜单');
INSERT INTO sys_menu VALUES('1501', '测试单表查询', '1500', '1', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:demo:query',                  '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1502', '测试单表新增', '1500', '2', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:demo:add',                    '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1503', '测试单表修改', '1500', '3', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:demo:edit',                   '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1504', '测试单表删除', '1500', '4', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:demo:remove',                 '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1505', '测试单表导出', '1500', '5', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:demo:export',                 '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1506', '测试树表',     '5',   '1', 'tree', 'demo/tree/index', '',  '1', '0', 'C', '0', '0', 'demo:tree:list', '#', 103, 1, now(), NULL, NULL, '测试树表菜单');
INSERT INTO sys_menu VALUES('1507', '测试树表查询', '1506', '1', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:tree:query',                  '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1508', '测试树表新增', '1506', '2', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:tree:add',                    '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1509', '测试树表修改', '1506', '3', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:tree:edit',                   '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1510', '测试树表删除', '1506', '4', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:tree:remove',                 '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES('1511', '测试树表导出', '1506', '5', '#', '', '',  '1', '0', 'F', '0', '0', 'demo:tree:export',                 '#', 103, 1, now(), NULL, NULL, '');


-- ----------------------------
-- 6、用户和角色关联表  用户N-1角色
-- ----------------------------
create table if not exists sys_user_role
(
    user_id int8 not null,
    role_id int8 not null,
    constraint sys_user_role_pk primary key (user_id, role_id)
);





-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into sys_user_role values ('1', '1');
insert into sys_user_role values ('3', '3');
insert into sys_user_role values ('4', '4');

-- ----------------------------
-- 7、角色和菜单关联表  角色1-N菜单
-- ----------------------------
create table if not exists sys_role_menu
(
    role_id int8 not null,
    menu_id int8 not null,
    constraint sys_role_menu_pk primary key (role_id, menu_id)
);





-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------
insert into sys_role_menu values ('3', '1');
insert into sys_role_menu values ('3', '5');
insert into sys_role_menu values ('3', '100');
insert into sys_role_menu values ('3', '101');
insert into sys_role_menu values ('3', '102');
insert into sys_role_menu values ('3', '103');
insert into sys_role_menu values ('3', '104');
insert into sys_role_menu values ('3', '105');
insert into sys_role_menu values ('3', '106');
insert into sys_role_menu values ('3', '107');
insert into sys_role_menu values ('3', '108');
insert into sys_role_menu values ('3', '118');
insert into sys_role_menu values ('3', '123');
insert into sys_role_menu values ('3', '130');
insert into sys_role_menu values ('3', '131');
insert into sys_role_menu values ('3', '132');
insert into sys_role_menu values ('3', '133');
insert into sys_role_menu values ('3', '500');
insert into sys_role_menu values ('3', '501');
insert into sys_role_menu values ('3', '1001');
insert into sys_role_menu values ('3', '1002');
insert into sys_role_menu values ('3', '1003');
insert into sys_role_menu values ('3', '1004');
insert into sys_role_menu values ('3', '1005');
insert into sys_role_menu values ('3', '1006');
insert into sys_role_menu values ('3', '1007');
insert into sys_role_menu values ('3', '1008');
insert into sys_role_menu values ('3', '1009');
insert into sys_role_menu values ('3', '1010');
insert into sys_role_menu values ('3', '1011');
insert into sys_role_menu values ('3', '1012');
insert into sys_role_menu values ('3', '1013');
insert into sys_role_menu values ('3', '1014');
insert into sys_role_menu values ('3', '1015');
insert into sys_role_menu values ('3', '1016');
insert into sys_role_menu values ('3', '1017');
insert into sys_role_menu values ('3', '1018');
insert into sys_role_menu values ('3', '1019');
insert into sys_role_menu values ('3', '1020');
insert into sys_role_menu values ('3', '1021');
insert into sys_role_menu values ('3', '1022');
insert into sys_role_menu values ('3', '1023');
insert into sys_role_menu values ('3', '1024');
insert into sys_role_menu values ('3', '1025');
insert into sys_role_menu values ('3', '1026');
insert into sys_role_menu values ('3', '1027');
insert into sys_role_menu values ('3', '1028');
insert into sys_role_menu values ('3', '1029');
insert into sys_role_menu values ('3', '1030');
insert into sys_role_menu values ('3', '1031');
insert into sys_role_menu values ('3', '1032');
insert into sys_role_menu values ('3', '1033');
insert into sys_role_menu values ('3', '1034');
insert into sys_role_menu values ('3', '1035');
insert into sys_role_menu values ('3', '1036');
insert into sys_role_menu values ('3', '1037');
insert into sys_role_menu values ('3', '1038');
insert into sys_role_menu values ('3', '1039');
insert into sys_role_menu values ('3', '1040');
insert into sys_role_menu values ('3', '1041');
insert into sys_role_menu values ('3', '1042');
insert into sys_role_menu values ('3', '1043');
insert into sys_role_menu values ('3', '1044');
insert into sys_role_menu values ('3', '1045');
insert into sys_role_menu values ('3', '1050');
insert into sys_role_menu values ('3', '1061');
insert into sys_role_menu values ('3', '1062');
insert into sys_role_menu values ('3', '1063');
insert into sys_role_menu values ('3', '1064');
insert into sys_role_menu values ('3', '1065');
insert into sys_role_menu values ('3', '1500');
insert into sys_role_menu values ('3', '1501');
insert into sys_role_menu values ('3', '1502');
insert into sys_role_menu values ('3', '1503');
insert into sys_role_menu values ('3', '1504');
insert into sys_role_menu values ('3', '1505');
insert into sys_role_menu values ('3', '1506');
insert into sys_role_menu values ('3', '1507');
insert into sys_role_menu values ('3', '1508');
insert into sys_role_menu values ('3', '1509');
insert into sys_role_menu values ('3', '1510');
insert into sys_role_menu values ('3', '1511');
insert into sys_role_menu values ('3', '1600');
insert into sys_role_menu values ('3', '1601');
insert into sys_role_menu values ('3', '1602');
insert into sys_role_menu values ('3', '1603');
insert into sys_role_menu values ('3', '1620');
insert into sys_role_menu values ('3', '1621');
insert into sys_role_menu values ('3', '1622');
insert into sys_role_menu values ('3', '1623');
insert into sys_role_menu values ('3', '11616');
insert into sys_role_menu values ('3', '11618');
insert into sys_role_menu values ('3', '11619');
insert into sys_role_menu values ('3', '11622');
insert into sys_role_menu values ('3', '11623');
insert into sys_role_menu values ('3', '11629');
insert into sys_role_menu values ('3', '11632');
insert into sys_role_menu values ('3', '11633');
insert into sys_role_menu values ('3', '11638');
insert into sys_role_menu values ('3', '11639');
insert into sys_role_menu values ('3', '11640');
insert into sys_role_menu values ('3', '11641');
insert into sys_role_menu values ('3', '11642');
insert into sys_role_menu values ('3', '11643');
insert into sys_role_menu values ('3', '11701');
insert into sys_role_menu values ('4', '5');
insert into sys_role_menu values ('4', '1500');
insert into sys_role_menu values ('4', '1501');
insert into sys_role_menu values ('4', '1502');
insert into sys_role_menu values ('4', '1503');
insert into sys_role_menu values ('4', '1504');
insert into sys_role_menu values ('4', '1505');
insert into sys_role_menu values ('4', '1506');
insert into sys_role_menu values ('4', '1507');
insert into sys_role_menu values ('4', '1508');
insert into sys_role_menu values ('4', '1509');
insert into sys_role_menu values ('4', '1510');
insert into sys_role_menu values ('4', '1511');

-- ----------------------------
-- 8、角色和部门关联表  角色1-N部门
-- ----------------------------
create table if not exists sys_role_dept
(
    role_id int8 not null,
    dept_id int8 not null,
    constraint sys_role_dept_pk primary key (role_id, dept_id)
);






-- ----------------------------
-- 9、用户与岗位关联表  用户1-N岗位
-- ----------------------------
create table if not exists sys_user_post
(
    user_id int8 not null,
    post_id int8 not null,
    constraint sys_user_post_pk primary key (user_id, post_id)
);





-- ----------------------------
-- 初始化-用户与岗位关联表数据
-- ----------------------------
insert into sys_user_post values ('1', '1');

-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
create table if not exists sys_oper_log
(
    oper_id        int8,
    tenant_id      varchar(20)   default '000000',
    title          varchar(50)   default '',
    business_type  int4          default 0,
    method         varchar(100)  default '',
    request_method varchar(10)   default '',
    operator_type  int4          default 0,
    oper_name      varchar(50)   default '',
    dept_name      varchar(50)   default '',
    oper_url       varchar(255)  default '',
    oper_ip        varchar(128)  default '',
    oper_location  varchar(255)  default '',
    oper_param     varchar(4000) default '',
    json_result    varchar(4000) default '',
    status         int4          default 0,
    error_msg      varchar(4000) default '',
    oper_time      timestamp,
    cost_time      int8          default 0,
    constraint sys_oper_log_pk primary key (oper_id)
);

create index idx_sys_oper_log_bt ON sys_oper_log (business_type);
create index idx_sys_oper_log_s ON sys_oper_log (status);
create index idx_sys_oper_log_ot ON sys_oper_log (oper_time);





















-- ----------------------------
-- 11、字典类型表
-- ----------------------------
create table if not exists sys_dict_type
(
    dict_id     int8,
    tenant_id   varchar(20)  default '000000',
    dict_name   varchar(100) default '',
    dict_type   varchar(100) default '',
    create_dept int8,
    create_by   int8,
    create_time timestamp,
    update_by   int8,
    update_time timestamp,
    remark      varchar(500) default null,
    constraint sys_dict_type_pk primary key (dict_id)
);

create unique index sys_dict_type_index1 ON sys_dict_type (tenant_id, dict_type);













insert into sys_dict_type values(1, '000000', '用户性别', 'sys_user_sex',        103, 1, now(), null, null, '用户性别列表');
insert into sys_dict_type values(2, '000000', '菜单状态', 'sys_show_hide',       103, 1, now(), null, null, '菜单状态列表');
insert into sys_dict_type values(3, '000000', '系统开关', 'sys_normal_disable',  103, 1, now(), null, null, '系统开关列表');
insert into sys_dict_type values(6, '000000', '系统是否', 'sys_yes_no',          103, 1, now(), null, null, '系统是否列表');
insert into sys_dict_type values(7, '000000', '通知类型', 'sys_notice_type',     103, 1, now(), null, null, '通知类型列表');
insert into sys_dict_type values(8, '000000', '通知状态', 'sys_notice_status',   103, 1, now(), null, null, '通知状态列表');
insert into sys_dict_type values(9, '000000', '操作类型', 'sys_oper_type',       103, 1, now(), null, null, '操作类型列表');
insert into sys_dict_type values(10, '000000', '系统状态', 'sys_common_status',  103, 1, now(), null, null, '登录状态列表');
insert into sys_dict_type values(11, '000000', '授权类型', 'sys_grant_type',     103, 1, now(), null, null, '认证授权类型');
insert into sys_dict_type values(12, '000000', '设备类型', 'sys_device_type',    103, 1, now(), null, null, '客户端设备类型');

-- ----------------------------
-- 12、字典数据表
-- ----------------------------
create table if not exists sys_dict_data
(
    dict_code   int8,
    tenant_id   varchar(20)  default '000000',
    dict_sort   int4         default 0,
    dict_label  varchar(100) default '',
    dict_value  varchar(100) default '',
    dict_type   varchar(100) default '',
    css_class   varchar(100) default null,
    list_class  varchar(100) default null,
    is_default  char         default 'N'::bpchar,
    create_dept int8,
    create_by   int8,
    create_time timestamp,
    update_by   int8,
    update_time timestamp,
    remark      varchar(500) default null,
    constraint sys_dict_data_pk primary key (dict_code)
);


















insert into sys_dict_data values(1, '000000', 1,  '男',       '0',       'sys_user_sex',        '',   '',        'Y', 103, 1, now(), null, null, '性别男');
insert into sys_dict_data values(2, '000000', 2,  '女',       '1',       'sys_user_sex',        '',   '',        'N', 103, 1, now(), null, null, '性别女');
insert into sys_dict_data values(3, '000000', 3,  '未知',     '2',       'sys_user_sex',        '',   '',        'N', 103, 1, now(), null, null, '性别未知');
insert into sys_dict_data values(4, '000000', 1,  '显示',     '0',       'sys_show_hide',       '',   'primary', 'Y', 103, 1, now(), null, null, '显示菜单');
insert into sys_dict_data values(5, '000000', 2,  '隐藏',     '1',       'sys_show_hide',       '',   'danger',  'N', 103, 1, now(), null, null, '隐藏菜单');
insert into sys_dict_data values(6, '000000', 1,  '正常',     '0',       'sys_normal_disable',  '',   'primary', 'Y', 103, 1, now(), null, null, '正常状态');
insert into sys_dict_data values(7, '000000', 2,  '停用',     '1',       'sys_normal_disable',  '',   'danger',  'N', 103, 1, now(), null, null, '停用状态');
insert into sys_dict_data values(12, '000000', 1,  '是',       'Y',       'sys_yes_no',          '',   'primary', 'Y', 103, 1, now(), null, null, '系统默认是');
insert into sys_dict_data values(13, '000000', 2,  '否',       'N',       'sys_yes_no',          '',   'danger',  'N', 103, 1, now(), null, null, '系统默认否');
insert into sys_dict_data values(14, '000000', 1,  '通知',     '1',       'sys_notice_type',     '',   'warning', 'Y', 103, 1, now(), null, null, '通知');
insert into sys_dict_data values(15, '000000', 2,  '公告',     '2',       'sys_notice_type',     '',   'success', 'N', 103, 1, now(), null, null, '公告');
insert into sys_dict_data values(16, '000000', 1,  '正常',     '0',       'sys_notice_status',   '',   'primary', 'Y', 103, 1, now(), null, null, '正常状态');
insert into sys_dict_data values(17, '000000', 2,  '关闭',     '1',       'sys_notice_status',   '',   'danger',  'N', 103, 1, now(), null, null, '关闭状态');
insert into sys_dict_data values(29, '000000', 99, '其他',     '0',       'sys_oper_type',       '',   'info',    'N', 103, 1, now(), null, null, '其他操作');
insert into sys_dict_data values(18, '000000', 1,  '新增',     '1',       'sys_oper_type',       '',   'info',    'N', 103, 1, now(), null, null, '新增操作');
insert into sys_dict_data values(19, '000000', 2,  '修改',     '2',       'sys_oper_type',       '',   'info',    'N', 103, 1, now(), null, null, '修改操作');
insert into sys_dict_data values(20, '000000', 3,  '删除',     '3',       'sys_oper_type',       '',   'danger',  'N', 103, 1, now(), null, null, '删除操作');
insert into sys_dict_data values(21, '000000', 4,  '授权',     '4',       'sys_oper_type',       '',   'primary', 'N', 103, 1, now(), null, null, '授权操作');
insert into sys_dict_data values(22, '000000', 5,  '导出',     '5',       'sys_oper_type',       '',   'warning', 'N', 103, 1, now(), null, null, '导出操作');
insert into sys_dict_data values(23, '000000', 6,  '导入',     '6',       'sys_oper_type',       '',   'warning', 'N', 103, 1, now(), null, null, '导入操作');
insert into sys_dict_data values(24, '000000', 7,  '强退',     '7',       'sys_oper_type',       '',   'danger',  'N', 103, 1, now(), null, null, '强退操作');
insert into sys_dict_data values(25, '000000', 8,  '生成代码', '8',       'sys_oper_type',       '',   'warning', 'N', 103, 1, now(), null, null, '生成操作');
insert into sys_dict_data values(26, '000000', 9,  '清空数据', '9',       'sys_oper_type',       '',   'danger',  'N', 103, 1, now(), null, null, '清空操作');
insert into sys_dict_data values(27, '000000', 1,  '成功',     '0',       'sys_common_status',   '',   'primary', 'N', 103, 1, now(), null, null, '正常状态');
insert into sys_dict_data values(28, '000000', 2,  '失败',     '1',       'sys_common_status',   '',   'danger',  'N', 103, 1, now(), null, null, '停用状态');
insert into sys_dict_data values(30, '000000', 0,  '密码认证', 'password',   'sys_grant_type',   '',   'default', 'N', 103, 1, now(), null, null, '密码认证');
insert into sys_dict_data values(31, '000000', 0,  '短信认证', 'sms',        'sys_grant_type',   '',   'default', 'N', 103, 1, now(), null, null, '短信认证');
insert into sys_dict_data values(32, '000000', 0,  '邮件认证', 'email',      'sys_grant_type',   '',   'default', 'N', 103, 1, now(), null, null, '邮件认证');
insert into sys_dict_data values(33, '000000', 0,  '小程序认证', 'xcx',      'sys_grant_type',   '',   'default', 'N', 103, 1, now(), null, null, '小程序认证');
insert into sys_dict_data values(34, '000000', 0,  '三方登录认证', 'social', 'sys_grant_type',   '',   'default', 'N', 103, 1, now(), null, null, '三方登录认证');
insert into sys_dict_data values(35, '000000', 0,  'PC', 'pc',              'sys_device_type',   '',   'default', 'N', 103, 1, now(), null, null, 'PC');
insert into sys_dict_data values(36, '000000', 0,  '安卓', 'android',       'sys_device_type',   '',   'default', 'N', 103, 1, now(), null, null, '安卓');
insert into sys_dict_data values(37, '000000', 0,  'iOS', 'ios',            'sys_device_type',   '',   'default', 'N', 103, 1, now(), null, null, 'iOS');
insert into sys_dict_data values(38, '000000', 0,  '小程序', 'xcx',         'sys_device_type',   '',   'default', 'N', 103, 1, now(), null, null, '小程序');


-- ----------------------------
-- 13、参数配置表
-- ----------------------------
create table if not exists sys_config
(
    config_id    int8,
    tenant_id    varchar(20)  default '000000',
    config_name  varchar(100) default '',
    config_key   varchar(100) default '',
    config_value varchar(500) default '',
    config_type  char         default 'N'::bpchar,
    create_dept  int8,
    create_by    int8,
    create_time  timestamp,
    update_by    int8,
    update_time  timestamp,
    remark       varchar(500) default null,
    constraint sys_config_pk primary key (config_id)
);















insert into sys_config values(1, '000000', '主框架页-默认皮肤样式名称',     'sys.index.skinName',            'skin-blue',     'Y', 103, 1, now(), null, null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow' );
insert into sys_config values(2, '000000', '用户管理-账号初始密码',         'sys.user.initPassword',         '123456',        'Y', 103, 1, now(), null, null, '初始化密码 123456' );
insert into sys_config values(3, '000000', '主框架页-侧边栏主题',           'sys.index.sideTheme',           'theme-dark',    'Y', 103, 1, now(), null, null, '深色主题theme-dark，浅色主题theme-light' );
insert into sys_config values(5, '000000', '账号自助-是否开启用户注册功能',   'sys.account.registerUser',      'false',         'Y', 103, 1, now(), null, null, '是否开启注册用户功能（true开启，false关闭）');
insert into sys_config values(11, '000000', 'OSS预览列表资源开关',          'sys.oss.previewListResource',   'true',          'Y', 103, 1, now(), null, null, 'true:开启, false:关闭');


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
create table if not exists sys_logininfor
(
    info_id        int8,
    tenant_id      varchar(20)  default '000000',
    user_name      varchar(50)  default '',
    client_key     varchar(32)  default '',
    device_type    varchar(32)  default '',
    ipaddr         varchar(128) default '',
    login_location varchar(255) default '',
    browser        varchar(50)  default '',
    os             varchar(50)  default '',
    status         char         default '0'::bpchar,
    msg            varchar(255) default '',
    login_time     timestamp,
    constraint sys_logininfor_pk primary key (info_id)
);

create index idx_sys_logininfor_s ON sys_logininfor (status);
create index idx_sys_logininfor_lt ON sys_logininfor (login_time);















-- ----------------------------
-- 17、通知公告表
-- ----------------------------
create table if not exists sys_notice
(
    notice_id      int8,
    tenant_id      varchar(20)  default '000000',
    notice_title   varchar(50)  not null,
    notice_type    char         not null,
    notice_content text,
    status         char         default '0'::bpchar,
    create_dept    int8,
    create_by      int8,
    create_time    timestamp,
    update_by      int8,
    update_time    timestamp,
    remark         varchar(255) default null,
    constraint sys_notice_pk primary key (notice_id)
);















-- ----------------------------
-- 初始化-公告信息表数据
-- ----------------------------
insert into sys_notice values('1', '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', '新版本内容', '0', 103, 1, now(), null, null, '管理员');
insert into sys_notice values('2', '000000', '维护通知：2018-07-01 系统凌晨维护', '1', '维护内容',   '0', 103, 1, now(), null, null, '管理员');


-- ----------------------------
-- 18、代码生成业务表
-- ----------------------------
create table if not exists gen_table
(
    table_id          int8,
    data_name         varchar(200)  default '',
    table_name        varchar(200)  default '',
    table_comment     varchar(500)  default '',
    sub_table_name    varchar(64)   default '',
    sub_table_fk_name varchar(64)   default '',
    class_name        varchar(100)  default '',
    tpl_category      varchar(200)  default 'crud',
    package_name      varchar(100)  default null,
    module_name       varchar(30)   default null,
    business_name     varchar(30)   default null,
    function_name     varchar(50)   default null,
    function_author   varchar(50)   default null,
    gen_type          char          default '0'::bpchar not null,
    gen_path          varchar(200)  default '/',
    options           varchar(1000) default null,
    create_dept       int8,
    create_by         int8,
    create_time       timestamp,
    update_by         int8,
    update_time       timestamp,
    remark            varchar(500)  default null,
    constraint gen_table_pk primary key (table_id)
);

























-- ----------------------------
-- 19、代码生成业务表字段
-- ----------------------------
create table if not exists gen_table_column
(
    column_id      int8,
    table_id       int8,
    column_name    varchar(200) default null,
    column_comment varchar(500) default null,
    column_type    varchar(100) default null,
    java_type      varchar(500) default null,
    java_field     varchar(200) default null,
    is_pk          char         default null::bpchar,
    is_increment   char         default null::bpchar,
    is_required    char         default null::bpchar,
    is_insert      char         default null::bpchar,
    is_edit        char         default null::bpchar,
    is_list        char         default null::bpchar,
    is_query       char         default null::bpchar,
    query_type     varchar(200) default 'EQ',
    html_type      varchar(200) default null,
    dict_type      varchar(200) default '',
    sort           int4,
    create_dept    int8,
    create_by      int8,
    create_time    timestamp,
    update_by      int8,
    update_time    timestamp,
    constraint gen_table_column_pk primary key (column_id)
);


























-- ----------------------------
-- OSS对象存储表
-- ----------------------------
create table if not exists sys_oss
(
    oss_id        int8,
    tenant_id     varchar(20)  default '000000',
    file_name     varchar(255) default '' not null,
    original_name varchar(255) default '' not null,
    file_suffix   varchar(10)  default '' not null,
    url           varchar(500) default '' not null,
    ext1          varchar(500) default '',
    create_dept   int8,
    create_by     int8,
    create_time   timestamp,
    update_by     int8,
    update_time   timestamp,
    service       varchar(20)  default 'minio',
    constraint sys_oss_pk primary key (oss_id)
);
















-- ----------------------------
-- OSS对象存储动态配置表
-- ----------------------------
create table if not exists sys_oss_config
(
    oss_config_id int8,
    tenant_id     varchar(20)  default '000000',
    config_key    varchar(20)  default '' not null,
    access_key    varchar(255) default '',
    secret_key    varchar(255) default '',
    bucket_name   varchar(255) default '',
    prefix        varchar(255) default '',
    endpoint      varchar(255) default '',
    domain        varchar(255) default '',
    is_https      char         default 'N'::bpchar,
    region        varchar(255) default '',
    access_policy char(1)      default '1'::bpchar not null,
    status        char         default '1'::bpchar,
    ext1          varchar(255) default '',
    create_dept   int8,
    create_by     int8,
    create_time   timestamp,
    update_by     int8,
    update_time   timestamp,
    remark        varchar(500) default '',
    constraint sys_oss_config_pk primary key (oss_config_id)
);























insert into sys_oss_config values (1, '000000', 'minio',  'ruoyi',            'ruoyi123',        'slion',             '', 'minio:9000',                      'https://slion.hxsoft.net/oss','N', '',            '1', '0', '', 103, 1, now(), 1, now(), null);
insert into sys_oss_config values (2, '000000', 'qiniu',  'XXXXXXXXXXXXXXX',  'XXXXXXXXXXXXXXX', 'ruoyi',             '', 's3-cn-north-1.qiniucs.com',           '','N', '',            '1', '1', '', 103, 1, now(), 1, now(), null);
insert into sys_oss_config values (3, '000000', 'aliyun', 'XXXXXXXXXXXXXXX',  'XXXXXXXXXXXXXXX', 'ruoyi',             '', 'oss-cn-beijing.aliyuncs.com',         '','N', '',            '1', '1', '', 103, 1, now(), 1, now(), null);
insert into sys_oss_config values (4, '000000', 'qcloud', 'XXXXXXXXXXXXXXX',  'XXXXXXXXXXXXXXX', 'ruoyi-1240000000',  '', 'cos.ap-beijing.myqcloud.com',         '','N', 'ap-beijing',  '1', '1', '', 103, 1, now(), 1, now(), null);
insert into sys_oss_config values (5, '000000', 'image',  'ruoyi',            'ruoyi123',        'slion',             'image', 'minio:9000',                 'https://slion.hxsoft.net/oss','N', '',            '1', '1', '', 103, 1, now(), 1, now(), NULL);

-- ----------------------------
-- 系统授权表
-- ----------------------------
create table sys_client (
    id                  int8,
    client_id           varchar(64)   default '',
    client_key          varchar(32)   default '',
    client_secret       varchar(255)  default '',
    grant_type          varchar(255)  default '',
    device_type         varchar(32)   default '',
    active_timeout      int4          default 1800,
    timeout             int4          default 604800,
    status              char(1)       default '0'::bpchar,
    del_flag            char(1)       default '0'::bpchar,
    create_dept         int8,
    create_by           int8,
    create_time         timestamp,
    update_by           int8,
    update_time         timestamp,
    constraint sys_client_pk primary key (id)
);


















insert into sys_client values (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, 0, 0, 103, 1, now(), 1, now());
insert into sys_client values (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, 0, 0, 103, 1, now(), 1, now());

create table if not exists test_demo
(
    id          int8,
    tenant_id   varchar(20)     default '000000',
    dept_id     int8,
    user_id     int8,
    order_num   int4            default 0,
    test_key    varchar(255),
    value       varchar(255),
    version     int4            default 0,
    create_dept int8,
    create_time timestamp,
    create_by   int8,
    update_time timestamp,
    update_by   int8,
    del_flag    int4            default 0
);

















create table if not exists test_tree
(
    id          int8,
    tenant_id   varchar(20)     default '000000',
    parent_id   int8            default 0,
    dept_id     int8,
    user_id     int8,
    tree_name   varchar(255),
    version     int4            default 0,
    create_dept int8,
    create_time timestamp,
    create_by   int8,
    update_time timestamp,
    update_by   int8,
    del_flag    integer         default 0
);
















INSERT INTO test_demo VALUES (1, '000000', 102, 4, 1, '测试数据权限', '测试', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (2, '000000', 102, 3, 2, '子节点1', '111', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (3, '000000', 102, 3, 3, '子节点2', '222', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (4, '000000', 108, 4, 4, '测试数据', 'demo', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (5, '000000', 108, 3, 13, '子节点11', '1111', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (6, '000000', 108, 3, 12, '子节点22', '2222', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (7, '000000', 108, 3, 11, '子节点33', '3333', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (8, '000000', 108, 3, 10, '子节点44', '4444', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (9, '000000', 108, 3, 9, '子节点55', '5555', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (10, '000000', 108, 3, 8, '子节点66', '6666', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (11, '000000', 108, 3, 7, '子节点77', '7777', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (12, '000000', 108, 3, 6, '子节点88', '8888', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_demo VALUES (13, '000000', 108, 3, 5, '子节点99', '9999', 0, 103, now(), 1, NULL, NULL, 0);

INSERT INTO test_tree VALUES (1, '000000', 0, 102, 4, '测试数据权限', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (2, '000000', 1, 102, 3, '子节点1', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (3, '000000', 2, 102, 3, '子节点2', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (4, '000000', 0, 108, 4, '测试树1', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (5, '000000', 4, 108, 3, '子节点11', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (6, '000000', 4, 108, 3, '子节点22', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (7, '000000', 4, 108, 3, '子节点33', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (8, '000000', 5, 108, 3, '子节点44', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (9, '000000', 6, 108, 3, '子节点55', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (10, '000000', 7, 108, 3, '子节点66', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (11, '000000', 7, 108, 3, '子节点77', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (12, '000000', 10, 108, 3, '子节点88', 0, 103, now(), 1, NULL, NULL, 0);
INSERT INTO test_tree VALUES (13, '000000', 10, 108, 3, '子节点99', 0, 103, now(), 1, NULL, NULL, 0);

-- 字符串自动转时间 避免框架时间查询报错问题
create or replace function cast_varchar_to_timestamp(varchar) returns timestamptz as $$
select to_timestamp($1, 'yyyy-mm-dd hh24:mi:ss');
$$ language sql strict ;

create cast (varchar as timestamptz) with function cast_varchar_to_timestamp as IMPLICIT;
