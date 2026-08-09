/*
 SnailJob Database Transfer Tool
 Source Server Type    : MySQL
 Target Server Type    : PostgreSQL
 Date: 2025-06-21 23:23:10
*/


-- sj_namespace
CREATE TABLE sj_namespace
(
    id          bigserial PRIMARY KEY,
    name        varchar(64)  NOT NULL,
    unique_id   varchar(64)  NOT NULL,
    description varchar(256) NOT NULL DEFAULT '',
    deleted     smallint     NOT NULL DEFAULT 0,
    create_dt   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_namespace_01 ON sj_namespace (name);










INSERT INTO sj_namespace VALUES (1, 'Development', 'dev', '', 0, now(), now());
INSERT INTO sj_namespace VALUES (2, 'Production', 'prod', '', 0, now(), now());

-- sj_group_config
CREATE TABLE sj_group_config
(
    id                bigserial PRIMARY KEY,
    namespace_id      varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name        varchar(64)  NOT NULL DEFAULT '',
    description       varchar(256) NOT NULL DEFAULT '',
    token             varchar(64)  NOT NULL DEFAULT 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT',
    group_status      smallint     NOT NULL DEFAULT 0,
    version           int          NOT NULL,
    group_partition   int          NOT NULL,
    id_generator_mode smallint     NOT NULL DEFAULT 1,
    init_scene        smallint     NOT NULL DEFAULT 0,
    create_dt         timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt         timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_sj_group_config_01 ON sj_group_config (namespace_id, group_name);















INSERT INTO sj_group_config VALUES (1, 'dev', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1,  now(), now());
INSERT INTO sj_group_config VALUES (2, 'prod', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1,  now(), now());

-- sj_notify_config
CREATE TABLE sj_notify_config
(
    id                     bigserial PRIMARY KEY,
    namespace_id           varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name             varchar(64)  NOT NULL,
    notify_name            varchar(64)  NOT NULL DEFAULT '',
    system_task_type       smallint     NOT NULL DEFAULT 3,
    notify_status          smallint     NOT NULL DEFAULT 0,
    recipient_ids          varchar(128) NOT NULL,
    notify_threshold       int          NOT NULL DEFAULT 0,
    notify_scene           smallint     NOT NULL DEFAULT 0,
    rate_limiter_status    smallint     NOT NULL DEFAULT 0,
    rate_limiter_threshold int          NOT NULL DEFAULT 0,
    description            varchar(256) NOT NULL DEFAULT '',
    create_dt              timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt              timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_notify_config_01 ON sj_notify_config (namespace_id, group_name);

















-- sj_notify_recipient
CREATE TABLE sj_notify_recipient
(
    id               bigserial PRIMARY KEY,
    namespace_id     varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    recipient_name   varchar(64)  NOT NULL,
    notify_type      smallint     NOT NULL DEFAULT 0,
    notify_attribute varchar(512) NOT NULL,
    description      varchar(256) NOT NULL DEFAULT '',
    create_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_notify_recipient_01 ON sj_notify_recipient (namespace_id);











-- sj_retry_dead_letter
CREATE TABLE sj_retry_dead_letter
(
    id              bigserial PRIMARY KEY,
    namespace_id    varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name      varchar(64)  NOT NULL,
    group_id        bigint       NOT NULL,
    scene_name      varchar(64)  NOT NULL,
    scene_id        bigint       NOT NULL,
    idempotent_id   varchar(64)  NOT NULL,
    biz_no          varchar(64)  NOT NULL DEFAULT '',
    executor_name   varchar(512) NOT NULL DEFAULT '',
    serializer_name varchar(32)  NOT NULL DEFAULT 'jackson',
    args_str        text         NOT NULL,
    ext_attrs       text         NOT NULL,
    create_dt       timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_retry_dead_letter_01 ON sj_retry_dead_letter (namespace_id, group_name, scene_name);
CREATE INDEX idx_sj_retry_dead_letter_02 ON sj_retry_dead_letter (idempotent_id);
CREATE INDEX idx_sj_retry_dead_letter_03 ON sj_retry_dead_letter (biz_no);
CREATE INDEX idx_sj_retry_dead_letter_04 ON sj_retry_dead_letter (create_dt);
















-- sj_retry
CREATE TABLE sj_retry
(
    id              bigserial PRIMARY KEY,
    namespace_id    varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name      varchar(64)  NOT NULL,
    group_id        bigint       NOT NULL,
    scene_name      varchar(64)  NOT NULL,
    scene_id        bigint       NOT NULL,
    idempotent_id   varchar(64)  NOT NULL,
    biz_no          varchar(64)  NOT NULL DEFAULT '',
    executor_name   varchar(512) NOT NULL DEFAULT '',
    args_str        text         NOT NULL,
    ext_attrs       text         NOT NULL,
    serializer_name varchar(32)  NOT NULL DEFAULT 'jackson',
    next_trigger_at bigint       NOT NULL,
    retry_count     int          NOT NULL DEFAULT 0,
    retry_status    smallint     NOT NULL DEFAULT 0,
    task_type       smallint     NOT NULL DEFAULT 1,
    bucket_index    int          NOT NULL DEFAULT 0,
    parent_id       bigint       NOT NULL DEFAULT 0,
    deleted         bigint       NOT NULL DEFAULT 0,
    create_dt       timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt       timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_sj_retry_01 ON sj_retry (scene_id, task_type, idempotent_id, deleted);

CREATE INDEX idx_sj_retry_01 ON sj_retry (biz_no);
CREATE INDEX idx_sj_retry_02 ON sj_retry (idempotent_id);
CREATE INDEX idx_sj_retry_03 ON sj_retry (retry_status, bucket_index);
CREATE INDEX idx_sj_retry_04 ON sj_retry (parent_id);
CREATE INDEX idx_sj_retry_05 ON sj_retry (create_dt);
























-- sj_retry_task
CREATE TABLE sj_retry_task
(
    id               bigserial PRIMARY KEY,
    namespace_id     varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name       varchar(64)  NOT NULL,
    scene_name       varchar(64)  NOT NULL,
    retry_id         bigint       NOT NULL,
    ext_attrs        text         NOT NULL,
    task_status      smallint     NOT NULL DEFAULT 1,
    task_type        smallint     NOT NULL DEFAULT 1,
    operation_reason smallint     NOT NULL DEFAULT 0,
    client_info      varchar(128) NULL     DEFAULT NULL,
    create_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_retry_task_01 ON sj_retry_task (namespace_id, group_name, scene_name);
CREATE INDEX idx_sj_retry_task_02 ON sj_retry_task (task_status);
CREATE INDEX idx_sj_retry_task_03 ON sj_retry_task (create_dt);
CREATE INDEX idx_sj_retry_task_04 ON sj_retry_task (retry_id);















-- sj_retry_task_log_message
CREATE TABLE sj_retry_task_log_message
(
    id            bigserial PRIMARY KEY,
    namespace_id  varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name    varchar(64) NOT NULL,
    retry_id      bigint      NOT NULL,
    retry_task_id bigint      NOT NULL,
    message       text        NOT NULL,
    log_num       int         NOT NULL DEFAULT 1,
    real_time     bigint      NOT NULL DEFAULT 0,
    create_dt     timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_retry_task_log_message_01 ON sj_retry_task_log_message (namespace_id, group_name, retry_task_id);
CREATE INDEX idx_sj_retry_task_log_message_02 ON sj_retry_task_log_message (create_dt);












-- sj_retry_scene_config
CREATE TABLE sj_retry_scene_config
(
    id                  bigserial PRIMARY KEY,
    namespace_id        varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    scene_name          varchar(64)  NOT NULL,
    group_name          varchar(64)  NOT NULL,
    scene_status        smallint     NOT NULL DEFAULT 0,
    max_retry_count     int          NOT NULL DEFAULT 5,
    back_off            smallint     NOT NULL DEFAULT 1,
    trigger_interval    varchar(16)  NOT NULL DEFAULT '',
    notify_ids          varchar(128) NOT NULL DEFAULT '',
    deadline_request    bigint       NOT NULL DEFAULT 60000,
    executor_timeout    int          NOT NULL DEFAULT 5,
    route_key           smallint     NOT NULL DEFAULT 4,
    block_strategy      smallint     NOT NULL DEFAULT 1,
    cb_status           smallint     NOT NULL DEFAULT 0,
    cb_trigger_type     smallint     NOT NULL DEFAULT 1,
    cb_max_count        int          NOT NULL DEFAULT 16,
    cb_trigger_interval varchar(16)  NOT NULL DEFAULT '',
    owner_id            bigint       NULL     DEFAULT NULL,
    labels              varchar(512) NULL     DEFAULT '',
    description         varchar(256) NOT NULL DEFAULT '',
    create_dt           timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt           timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_sj_retry_scene_config_01 ON sj_retry_scene_config (namespace_id, group_name, scene_name);

























-- sj_server_node
CREATE TABLE sj_server_node
(
    id           bigserial PRIMARY KEY,
    namespace_id varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name   varchar(64)  NOT NULL,
    host_id      varchar(64)  NOT NULL,
    host_ip      varchar(64)  NOT NULL,
    host_port    int          NOT NULL,
    expire_at    timestamp    NOT NULL,
    node_type    smallint     NOT NULL,
    ext_attrs    varchar(256) NULL     DEFAULT '',
    labels       varchar(512) NULL     DEFAULT '',
    create_dt    timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt    timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_sj_server_node_01 ON sj_server_node (host_id, host_ip);

CREATE INDEX idx_sj_server_node_01 ON sj_server_node (namespace_id, group_name);
CREATE INDEX idx_sj_server_node_02 ON sj_server_node (expire_at, node_type);















-- sj_distributed_lock
CREATE TABLE sj_distributed_lock
(
    name       varchar(64)  NOT NULL PRIMARY KEY,
    lock_until timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    locked_at  timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    locked_by  varchar(255) NOT NULL,
    create_dt  timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt  timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);









-- sj_system_user
CREATE TABLE sj_system_user
(
    id        bigserial PRIMARY KEY,
    username  varchar(64)  NOT NULL,
    password  varchar(128) NOT NULL,
    role      smallint     NOT NULL DEFAULT 0,
    create_dt timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);









INSERT INTO sj_system_user (username, password, role)
VALUES ('admin', '465c194afb65670f38322df087f0a9bb225cc257e43eb4ac5a0c98ef5b3173ac', 2);

-- sj_system_user_permission
CREATE TABLE sj_system_user_permission
(
    id             bigserial PRIMARY KEY,
    group_name     varchar(64) NOT NULL,
    namespace_id   varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    system_user_id bigint      NOT NULL,
    create_dt      timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt      timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_sj_system_user_permission_01 ON sj_system_user_permission (namespace_id, group_name, system_user_id);









-- sj_job
CREATE TABLE sj_job
(
    id               bigserial PRIMARY KEY,
    namespace_id     varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    biz_id           varchar(64)  NOT NULL,
    group_name       varchar(64)  NOT NULL,
    job_name         varchar(64)  NOT NULL,
    args_str         text         NULL     DEFAULT NULL,
    args_type        smallint     NOT NULL DEFAULT 1,
    next_trigger_at  bigint       NOT NULL,
    job_status       smallint     NOT NULL DEFAULT 1,
    task_type        smallint     NOT NULL DEFAULT 1,
    route_key        smallint     NOT NULL DEFAULT 4,
    executor_type    smallint     NOT NULL DEFAULT 1,
    executor_info    varchar(255) NULL     DEFAULT NULL,
    trigger_type     smallint     NOT NULL,
    trigger_interval varchar(255) NOT NULL,
    block_strategy   smallint     NOT NULL DEFAULT 1,
    executor_timeout int          NOT NULL DEFAULT 0,
    max_retry_times  int          NOT NULL DEFAULT 0,
    parallel_num     int          NOT NULL DEFAULT 1,
    retry_interval   int          NOT NULL DEFAULT 0,
    bucket_index     int          NOT NULL DEFAULT 0,
    resident         smallint     NOT NULL DEFAULT 0,
    notify_ids       varchar(128) NOT NULL DEFAULT '',
    owner_id         bigint       NULL     DEFAULT NULL,
    labels           varchar(512) NULL     DEFAULT '',
    description      varchar(256) NOT NULL DEFAULT '',
    ext_attrs        varchar(256) NULL     DEFAULT '',
    deleted          smallint     NOT NULL DEFAULT 0,
    create_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_job_01 ON sj_job (namespace_id, group_name);
CREATE INDEX idx_sj_job_02 ON sj_job (job_status, bucket_index);
CREATE INDEX idx_sj_job_03 ON sj_job (create_dt);
CREATE UNIQUE INDEX uk_sj_job_01 ON sj_job (namespace_id, biz_id);

































INSERT INTO sj_job VALUES (1, 'dev', 'demo-job', 'ruoyi_group', 'demo-job', null, 1, 1710344035622, 1, 1, 4, 1, 'testJobExecutor', 2, '60', 1, 60, 3, 1, 1, 116, 0, '', 1, '', '', '', 0, now(), now());

-- sj_job_log_message
CREATE TABLE sj_job_log_message
(
    id            bigserial PRIMARY KEY,
    namespace_id  varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name    varchar(64)  NOT NULL,
    job_id        bigint       NOT NULL,
    task_batch_id bigint       NOT NULL,
    task_id       bigint       NOT NULL,
    message       text         NOT NULL,
    log_num       int          NOT NULL DEFAULT 1,
    real_time     bigint       NOT NULL DEFAULT 0,
    ext_attrs     varchar(256) NULL     DEFAULT '',
    create_dt     timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_job_log_message_01 ON sj_job_log_message (task_batch_id, task_id);
CREATE INDEX idx_sj_job_log_message_02 ON sj_job_log_message (create_dt);
CREATE INDEX idx_sj_job_log_message_03 ON sj_job_log_message (namespace_id, group_name);














-- sj_job_task
CREATE TABLE sj_job_task
(
    id             bigserial PRIMARY KEY,
    namespace_id   varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name     varchar(64)  NOT NULL,
    job_id         bigint       NOT NULL,
    task_batch_id  bigint       NOT NULL,
    parent_id      bigint       NOT NULL DEFAULT 0,
    task_status    smallint     NOT NULL DEFAULT 0,
    retry_count    int          NOT NULL DEFAULT 0,
    mr_stage       smallint     NULL     DEFAULT NULL,
    leaf           smallint     NOT NULL DEFAULT '1',
    task_name      varchar(255) NOT NULL DEFAULT '',
    client_info    varchar(128) NULL     DEFAULT NULL,
    wf_context     text         NULL     DEFAULT NULL,
    result_message text         NOT NULL,
    args_str       text         NULL     DEFAULT NULL,
    args_type      smallint     NOT NULL DEFAULT 1,
    ext_attrs      varchar(256) NULL     DEFAULT '',
    create_dt      timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt      timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_job_task_01 ON sj_job_task (task_batch_id, task_status);
CREATE INDEX idx_sj_job_task_02 ON sj_job_task (create_dt);
CREATE INDEX idx_sj_job_task_03 ON sj_job_task (namespace_id, group_name);






















-- sj_job_task_batch
CREATE TABLE sj_job_task_batch
(
    id                      bigserial PRIMARY KEY,
    namespace_id            varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name              varchar(64)  NOT NULL,
    job_id                  bigint       NOT NULL,
    workflow_node_id        bigint       NOT NULL DEFAULT 0,
    parent_workflow_node_id bigint       NOT NULL DEFAULT 0,
    workflow_task_batch_id  bigint       NOT NULL DEFAULT 0,
    task_batch_status       smallint     NOT NULL DEFAULT 0,
    operation_reason        smallint     NOT NULL DEFAULT 0,
    execution_at            bigint       NOT NULL DEFAULT 0,
    system_task_type        smallint     NOT NULL DEFAULT 3,
    parent_id               varchar(64)  NOT NULL DEFAULT '',
    ext_attrs               varchar(256) NULL     DEFAULT '',
    deleted                 smallint     NOT NULL DEFAULT 0,
    create_dt               timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt               timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_job_task_batch_01 ON sj_job_task_batch (job_id, task_batch_status);
CREATE INDEX idx_sj_job_task_batch_02 ON sj_job_task_batch (create_dt);
CREATE INDEX idx_sj_job_task_batch_03 ON sj_job_task_batch (namespace_id, group_name);
CREATE INDEX idx_sj_job_task_batch_04 ON sj_job_task_batch (workflow_task_batch_id, workflow_node_id);



















-- sj_job_summary
CREATE TABLE sj_job_summary
(
    id               bigserial PRIMARY KEY,
    namespace_id     varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name       varchar(64)  NOT NULL DEFAULT '',
    business_id      bigint       NOT NULL,
    system_task_type smallint     NOT NULL DEFAULT 3,
    trigger_at       timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    success_num      int          NOT NULL DEFAULT 0,
    fail_num         int          NOT NULL DEFAULT 0,
    fail_reason      varchar(512) NOT NULL DEFAULT '',
    stop_num         int          NOT NULL DEFAULT 0,
    stop_reason      varchar(512) NOT NULL DEFAULT '',
    cancel_num       int          NOT NULL DEFAULT 0,
    cancel_reason    varchar(512) NOT NULL DEFAULT '',
    create_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_sj_job_summary_01 ON sj_job_summary (trigger_at, system_task_type, business_id);

CREATE INDEX idx_sj_job_summary_01 ON sj_job_summary (namespace_id, group_name, business_id);


















-- sj_retry_summary
CREATE TABLE sj_retry_summary
(
    id            bigserial PRIMARY KEY,
    namespace_id  varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name    varchar(64) NOT NULL DEFAULT '',
    scene_name    varchar(50) NOT NULL DEFAULT '',
    trigger_at    timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    running_num   int         NOT NULL DEFAULT 0,
    finish_num    int         NOT NULL DEFAULT 0,
    max_count_num int         NOT NULL DEFAULT 0,
    suspend_num   int         NOT NULL DEFAULT 0,
    create_dt     timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt     timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_sj_retry_summary_01 ON sj_retry_summary (namespace_id, group_name, scene_name, trigger_at);

CREATE INDEX idx_sj_retry_summary_01 ON sj_retry_summary (trigger_at);














-- sj_workflow
CREATE TABLE sj_workflow
(
    id               bigserial PRIMARY KEY,
    workflow_name    varchar(64)  NOT NULL,
    namespace_id     varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    biz_id           varchar(64)  NOT NULL,
    group_name       varchar(64)  NOT NULL,
    workflow_status  smallint     NOT NULL DEFAULT 1,
    trigger_type     smallint     NOT NULL,
    trigger_interval varchar(255) NOT NULL,
    next_trigger_at  bigint       NOT NULL,
    block_strategy   smallint     NOT NULL DEFAULT 1,
    executor_timeout int          NOT NULL DEFAULT 0,
    description      varchar(256) NOT NULL DEFAULT '',
    flow_info        text         NULL     DEFAULT NULL,
    wf_context       text         NULL     DEFAULT NULL,
    notify_ids       varchar(128) NOT NULL DEFAULT '',
    bucket_index     int          NOT NULL DEFAULT 0,
    version          int          NOT NULL,
    owner_id         bigint       NULL     DEFAULT NULL,
    ext_attrs        varchar(256) NULL     DEFAULT '',
    deleted          smallint     NOT NULL DEFAULT 0,
    create_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_workflow_01 ON sj_workflow (create_dt);
CREATE INDEX idx_sj_workflow_02 ON sj_workflow (namespace_id, group_name);
CREATE UNIQUE INDEX uk_sj_workflow_01 ON sj_workflow (namespace_id, biz_id);

























-- sj_workflow_node
CREATE TABLE sj_workflow_node
(
    id                   bigserial PRIMARY KEY,
    namespace_id         varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    node_name            varchar(64)  NOT NULL,
    group_name           varchar(64)  NOT NULL,
    job_id               bigint       NOT NULL,
    workflow_id          bigint       NOT NULL,
    node_type            smallint     NOT NULL DEFAULT 1,
    expression_type      smallint     NOT NULL DEFAULT 0,
    fail_strategy        smallint     NOT NULL DEFAULT 1,
    workflow_node_status smallint     NOT NULL DEFAULT 1,
    priority_level       int          NOT NULL DEFAULT 1,
    node_info            text         NULL     DEFAULT NULL,
    version              int          NOT NULL,
    ext_attrs            varchar(256) NULL     DEFAULT '',
    deleted              smallint     NOT NULL DEFAULT 0,
    create_dt            timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt            timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_workflow_node_01 ON sj_workflow_node (create_dt);
CREATE INDEX idx_sj_workflow_node_02 ON sj_workflow_node (namespace_id, group_name);




















-- sj_workflow_task_batch
CREATE TABLE sj_workflow_task_batch
(
    id                bigserial PRIMARY KEY,
    namespace_id      varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name        varchar(64)  NOT NULL,
    workflow_id       bigint       NOT NULL,
    task_batch_status smallint     NOT NULL DEFAULT 0,
    operation_reason  smallint     NOT NULL DEFAULT 0,
    flow_info         text         NULL     DEFAULT NULL,
    wf_context        text         NULL     DEFAULT NULL,
    execution_at      bigint       NOT NULL DEFAULT 0,
    ext_attrs         varchar(256) NULL     DEFAULT '',
    version           int          NOT NULL DEFAULT 1,
    deleted           smallint     NOT NULL DEFAULT 0,
    create_dt         timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt         timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_workflow_task_batch_01 ON sj_workflow_task_batch (workflow_id, task_batch_status);
CREATE INDEX idx_sj_workflow_task_batch_02 ON sj_workflow_task_batch (create_dt);
CREATE INDEX idx_sj_workflow_task_batch_03 ON sj_workflow_task_batch (namespace_id, group_name);

















-- sj_job_executor
CREATE TABLE sj_job_executor
(
    id            bigserial PRIMARY KEY,
    namespace_id  varchar(64)  NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a',
    group_name    varchar(64)  NOT NULL,
    executor_info varchar(256) NOT NULL,
    executor_type varchar(3)   NOT NULL,
    create_dt     timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_dt     timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sj_job_executor_01 ON sj_job_executor (namespace_id, group_name);
CREATE INDEX idx_sj_job_executor_02 ON sj_job_executor (create_dt);









