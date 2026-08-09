-- 已有 Postgres 环境升级脚本（可重复执行）
-- 用法示例：
--   docker exec -i slion-service-postgres psql -U postgres -d slion < scripts/sql/postgres/upgrade/20260809-oauth-client.sql

CREATE TABLE IF NOT EXISTS slion_oauth_client (
    id               int8          NOT NULL,
    app_name         varchar(100)  NOT NULL,
    app_key          varchar(64)   NOT NULL,
    app_secret       varchar(255)  NOT NULL,
    grant_types      varchar(200)  NOT NULL DEFAULT 'client_credentials',
    scopes           varchar(500)  NOT NULL DEFAULT 'open.api',
    access_token_ttl int4          DEFAULT 7200,
    status           char(1)       DEFAULT '0',
    del_flag         char(1)       DEFAULT '0',
    remark           varchar(500)  DEFAULT NULL,
    create_dept      int8,
    create_by        int8,
    create_time      timestamp,
    update_by        int8,
    update_time      timestamp,
    constraint slion_oauth_client_pk primary key (id)
);

CREATE UNIQUE INDEX IF NOT EXISTS uk_slion_oauth_app_key ON slion_oauth_client (app_key);

CREATE TABLE IF NOT EXISTS oauth2_registered_client (
    id                            varchar(100)  NOT NULL PRIMARY KEY,
    client_id                     varchar(100)  NOT NULL,
    client_id_issued_at           timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    client_secret                 varchar(200)  DEFAULT NULL,
    client_secret_expires_at      timestamp     DEFAULT NULL,
    client_name                   varchar(200)  NOT NULL,
    client_authentication_methods varchar(1000) NOT NULL,
    authorization_grant_types     varchar(1000) NOT NULL,
    redirect_uris                 varchar(1000) DEFAULT NULL,
    post_logout_redirect_uris     varchar(1000) DEFAULT NULL,
    scopes                        varchar(1000) NOT NULL,
    client_settings               varchar(2000) NOT NULL,
    token_settings                varchar(2000) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS uk_oauth2_client_id ON oauth2_registered_client (client_id);

insert into sys_menu values('1700', '开放应用',     '1',    '12', 'oauthClient', 'system/oauthClient/index', '', '1', '0', 'C', '0', '0', 'system:oauthClient:list',   'validCode', 103, 1, now(), null, null, 'OAuth2 开放应用（AppKey/AppSecret）')
on conflict (menu_id) do nothing;
insert into sys_menu values('1701', '开放应用查询', '1700', '1',  '#', '', '', '1', '0', 'F', '0', '0', 'system:oauthClient:query',  '#', 103, 1, now(), null, null, '')
on conflict (menu_id) do nothing;
insert into sys_menu values('1702', '开放应用新增', '1700', '2',  '#', '', '', '1', '0', 'F', '0', '0', 'system:oauthClient:add',    '#', 103, 1, now(), null, null, '')
on conflict (menu_id) do nothing;
insert into sys_menu values('1703', '开放应用修改', '1700', '3',  '#', '', '', '1', '0', 'F', '0', '0', 'system:oauthClient:edit',   '#', 103, 1, now(), null, null, '')
on conflict (menu_id) do nothing;
insert into sys_menu values('1704', '开放应用删除', '1700', '4',  '#', '', '', '1', '0', 'F', '0', '0', 'system:oauthClient:remove', '#', 103, 1, now(), null, null, '')
on conflict (menu_id) do nothing;
insert into sys_menu values('1705', '开放应用导出', '1700', '5',  '#', '', '', '1', '0', 'F', '0', '0', 'system:oauthClient:export', '#', 103, 1, now(), null, null, '')
on conflict (menu_id) do nothing;

insert into sys_role_menu values ('3', '1700') on conflict do nothing;
insert into sys_role_menu values ('3', '1701') on conflict do nothing;
insert into sys_role_menu values ('3', '1702') on conflict do nothing;
insert into sys_role_menu values ('3', '1703') on conflict do nothing;
insert into sys_role_menu values ('3', '1704') on conflict do nothing;
insert into sys_role_menu values ('3', '1705') on conflict do nothing;
