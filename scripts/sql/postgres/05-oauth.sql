-- OAuth2 客户端扩展表（可选，oauth2.enabled=true 时使用）
-- 管理后台 Sa-Token 与 open-api OAuth2 双轨并存

CREATE TABLE IF NOT EXISTS oauth2_registered_client (
    id                         varchar(100)  NOT NULL PRIMARY KEY,
    client_id                  varchar(100)  NOT NULL,
    client_id_issued_at        timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    client_secret              varchar(200)  DEFAULT NULL,
    client_secret_expires_at   timestamp     DEFAULT NULL,
    client_name                varchar(200)  NOT NULL,
    client_authentication_methods varchar(1000) NOT NULL,
    authorization_grant_types  varchar(1000) NOT NULL,
    redirect_uris              varchar(1000) DEFAULT NULL,
    post_logout_redirect_uris  varchar(1000) DEFAULT NULL,
    scopes                     varchar(1000) NOT NULL,
    client_settings            varchar(2000) NOT NULL,
    token_settings             varchar(2000) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS uk_oauth2_client_id ON oauth2_registered_client (client_id);

COMMENT ON TABLE oauth2_registered_client IS 'OAuth2 注册客户端';
