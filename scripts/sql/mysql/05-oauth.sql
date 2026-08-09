-- OAuth2 开放应用（AppKey / AppSecret）
-- 管理后台 Sa-Token 与 open-api OAuth2 双轨并存

CREATE TABLE IF NOT EXISTS slion_oauth_client (
    id               bigint        NOT NULL COMMENT '主键',
    app_name         varchar(100)  NOT NULL COMMENT '应用名称',
    app_key          varchar(64)   NOT NULL COMMENT 'AppKey（OAuth2 client_id）',
    app_secret       varchar(255)  NOT NULL COMMENT 'AppSecret（加密存储）',
    grant_types      varchar(200)  NOT NULL DEFAULT 'client_credentials' COMMENT '授权类型，逗号分隔',
    scopes           varchar(500)  NOT NULL DEFAULT 'open.api' COMMENT '授权范围，逗号分隔',
    access_token_ttl int           DEFAULT 7200 COMMENT '访问令牌有效期（秒）',
    status           char(1)       DEFAULT '0' COMMENT '状态（0正常 1停用）',
    del_flag         char(1)       DEFAULT '0' COMMENT '删除标志（0存在 1删除）',
    remark           varchar(500)  DEFAULT NULL COMMENT '备注',
    create_dept      bigint        DEFAULT NULL,
    create_by        bigint        DEFAULT NULL,
    create_time      datetime      DEFAULT NULL,
    update_by        bigint        DEFAULT NULL,
    update_time      datetime      DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_slion_oauth_app_key (app_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='OAuth2 开放应用（AppKey/AppSecret）';

CREATE TABLE IF NOT EXISTS oauth2_registered_client (
    id                            varchar(100)  NOT NULL,
    client_id                     varchar(100)  NOT NULL,
    client_id_issued_at           timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    client_secret                 varchar(200)  DEFAULT NULL,
    client_secret_expires_at      timestamp     NULL DEFAULT NULL,
    client_name                   varchar(200)  NOT NULL,
    client_authentication_methods varchar(1000) NOT NULL,
    authorization_grant_types     varchar(1000) NOT NULL,
    redirect_uris                 varchar(1000) DEFAULT NULL,
    post_logout_redirect_uris     varchar(1000) DEFAULT NULL,
    scopes                        varchar(1000) NOT NULL,
    client_settings               varchar(2000) NOT NULL,
    token_settings                varchar(2000) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_oauth2_client_id (client_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='OAuth2 注册客户端（SAS 标准表，预留）';

insert ignore into sys_menu values('1700', '开放应用',     '1',    '12', 'oauthClient', 'system/oauthClient/index', '', 1, 0, 'C', '0', '0', 'system:oauthClient:list',   'validCode', 103, 1, sysdate(), null, null, 'OAuth2 开放应用（AppKey/AppSecret）');
insert ignore into sys_menu values('1701', '开放应用查询', '1700', '1',  '#', '', '', 1, 0, 'F', '0', '0', 'system:oauthClient:query',  '#', 103, 1, sysdate(), null, null, '');
insert ignore into sys_menu values('1702', '开放应用新增', '1700', '2',  '#', '', '', 1, 0, 'F', '0', '0', 'system:oauthClient:add',    '#', 103, 1, sysdate(), null, null, '');
insert ignore into sys_menu values('1703', '开放应用修改', '1700', '3',  '#', '', '', 1, 0, 'F', '0', '0', 'system:oauthClient:edit',   '#', 103, 1, sysdate(), null, null, '');
insert ignore into sys_menu values('1704', '开放应用删除', '1700', '4',  '#', '', '', 1, 0, 'F', '0', '0', 'system:oauthClient:remove', '#', 103, 1, sysdate(), null, null, '');
insert ignore into sys_menu values('1705', '开放应用导出', '1700', '5',  '#', '', '', 1, 0, 'F', '0', '0', 'system:oauthClient:export', '#', 103, 1, sysdate(), null, null, '');

insert ignore into sys_role_menu values ('3', '1700');
insert ignore into sys_role_menu values ('3', '1701');
insert ignore into sys_role_menu values ('3', '1702');
insert ignore into sys_role_menu values ('3', '1703');
insert ignore into sys_role_menu values ('3', '1704');
insert ignore into sys_role_menu values ('3', '1705');
