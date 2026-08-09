CREATE TABLE flow_definition
(
    id              int8         NOT NULL,
    flow_code       varchar(40)  NOT NULL,
    flow_name       varchar(100) NOT NULL,
    model_value     varchar(40)  NOT NULL DEFAULT 'CLASSICS',
    category        varchar(100) NULL,
    "version"       varchar(20)  NOT NULL,
    is_publish      int2         NOT NULL DEFAULT 0,
    form_custom     bpchar(1)    NULL     DEFAULT 'N':: character varying,
    form_path       varchar(100) NULL,
    activity_status int2         NOT NULL DEFAULT 1,
    listener_type   varchar(100) NULL,
    listener_path   varchar(400) NULL,
    ext             varchar(500) NULL,
    create_time     timestamp    NULL,
    create_by       varchar(64)  NULL     DEFAULT '':: character varying,
    update_time     timestamp    NULL,
    update_by       varchar(64)  NULL     DEFAULT '':: character varying,
    del_flag        bpchar(1)    NULL     DEFAULT '0':: character varying,
    tenant_id       varchar(40)  NULL,
    CONSTRAINT flow_definition_pkey PRIMARY KEY (id)
);






















CREATE TABLE flow_node
(
    id              int8          NOT NULL,
    node_type       int2          NOT NULL,
    definition_id   int8          NOT NULL,
    node_code       varchar(100)  NOT NULL,
    node_name       varchar(100)  NULL,
    permission_flag varchar(200)  NULL,
    node_ratio      varchar(200)  NULL,
    coordinate      varchar(100)  NULL,
    any_node_skip   varchar(100)  NULL,
    listener_type   varchar(100)  NULL,
    listener_path   varchar(400)  NULL,
    form_custom     bpchar(1)     NULL DEFAULT 'N':: character varying,
    form_path       varchar(100)  NULL,
    "version"       varchar(20)   NOT NULL,
    create_time     timestamp    NULL,
    create_by       varchar(64)  NULL DEFAULT '':: character varying,
    update_time     timestamp    NULL,
    update_by       varchar(64)  NULL DEFAULT '':: character varying,
    ext             text         NULL,
    del_flag        bpchar(1)     NULL DEFAULT '0':: character varying,
    tenant_id       varchar(40)   NULL,
    CONSTRAINT flow_node_pkey PRIMARY KEY (id)
);

























CREATE TABLE flow_skip
(
    id             int8         NOT NULL,
    definition_id  int8         NOT NULL,
    now_node_code  varchar(100) NOT NULL,
    now_node_type  int2         NULL,
    next_node_code varchar(100) NOT NULL,
    next_node_type int2         NULL,
    skip_name      varchar(100) NULL,
    skip_type      varchar(40)  NULL,
    skip_condition varchar(200) NULL,
    coordinate     varchar(100) NULL,
    create_time    timestamp    NULL,
    create_by      varchar(64)  NULL DEFAULT '':: character varying,
    update_time    timestamp    NULL,
    update_by      varchar(64)  NULL DEFAULT '':: character varying,
    del_flag       bpchar(1)    NULL DEFAULT '0':: character varying,
    tenant_id      varchar(40)  NULL,
    CONSTRAINT flow_skip_pkey PRIMARY KEY (id)
);



















CREATE TABLE flow_instance
(
    id              int8         NOT NULL,
    definition_id   int8         NOT NULL,
    business_id     varchar(40)  NOT NULL,
    node_type       int2         NOT NULL,
    node_code       varchar(40)  NOT NULL,
    node_name       varchar(100) NULL,
    variable        text         NULL,
    flow_status     varchar(20)  NOT NULL,
    activity_status int2         NOT NULL DEFAULT 1,
    def_json        text         NULL,
    create_time     timestamp    NULL,
    create_by       varchar(64)  NULL DEFAULT '':: character varying,
    update_time     timestamp    NULL,
    update_by       varchar(64)  NULL DEFAULT '':: character varying,
    ext             varchar(500) NULL,
    del_flag        bpchar(1)    NULL     DEFAULT '0':: character varying,
    tenant_id       varchar(40)  NULL,
    CONSTRAINT flow_instance_pkey PRIMARY KEY (id)
);




















CREATE TABLE flow_task
(
    id            int8         NOT NULL,
    definition_id int8         NOT NULL,
    instance_id   int8         NOT NULL,
    node_code     varchar(100) NOT NULL,
    node_name     varchar(100) NULL,
    node_type     int2         NOT NULL,
    flow_status   varchar(20)  NOT NULL,
    form_custom   bpchar(1)    NULL DEFAULT 'N':: character varying,
    form_path     varchar(100) NULL,
    create_time   timestamp    NULL,
    create_by     varchar(64)  NULL DEFAULT '':: character varying,
    update_time   timestamp    NULL,
    update_by     varchar(64)  NULL DEFAULT '':: character varying,
    del_flag      bpchar(1)    NULL DEFAULT '0':: character varying,
    tenant_id     varchar(40)  NULL,
    CONSTRAINT flow_task_pkey PRIMARY KEY (id)
);


















CREATE TABLE flow_his_task
(
    id               int8         NOT NULL,
    definition_id    int8         NOT NULL,
    instance_id      int8         NOT NULL,
    task_id          int8         NOT NULL,
    node_code        varchar(100) NULL,
    node_name        varchar(100) NULL,
    node_type        int2         NULL,
    target_node_code varchar(200) NULL,
    target_node_name varchar(200) NULL,
    approver         varchar(40)  NULL,
    cooperate_type   int2         NOT NULL DEFAULT 0,
    collaborator     varchar(500)  NULL,
    skip_type        varchar(10)  NULL,
    flow_status      varchar(20)  NOT NULL,
    form_custom      bpchar(1)    NULL     DEFAULT 'N':: character varying,
    form_path        varchar(100) NULL,
    ext              text         NULL,
    message          varchar(500) NULL,
    variable         text         NULL,
    create_time      timestamp    NULL,
    update_time      timestamp    NULL,
    del_flag         bpchar(1)    NULL     DEFAULT '0':: character varying,
    tenant_id        varchar(40)  NULL,
    CONSTRAINT flow_his_task_pkey PRIMARY KEY (id)
);


























CREATE TABLE flow_user
(
    id           int8        NOT NULL,
    "type"       bpchar(1)   NOT NULL,
    processed_by varchar(80) NULL,
    associated   int8        NOT NULL,
    create_time  timestamp   NULL,
    create_by    varchar(64)  NULL     DEFAULT '':: character varying,
    update_time  timestamp   NULL,
    update_by    varchar(64)  NULL DEFAULT '':: character varying,
    del_flag     bpchar(1)   NULL DEFAULT '0':: character varying,
    tenant_id    varchar(40) NULL,
    CONSTRAINT flow_user_pk PRIMARY KEY (id)
);
CREATE INDEX user_processed_type ON flow_user USING btree (processed_by, type);
CREATE INDEX user_associated_idx ON FLOW_USER USING btree (associated);













-- ----------------------------
-- 流程分类表
-- ----------------------------
CREATE TABLE flow_category
(
    category_id   int8         NOT NULL,
    tenant_id     VARCHAR(20)  DEFAULT '000000',
    parent_id     int8         DEFAULT 0,
    ancestors     VARCHAR(500) DEFAULT '',
    category_name VARCHAR(30)  NOT NULL,
    order_num     INT          DEFAULT 0,
    del_flag      CHAR         DEFAULT '0'::bpchar,
    create_dept   int8,
    create_by     int8,
    create_time   TIMESTAMP,
    update_by     int8,
    update_time   TIMESTAMP,
    PRIMARY KEY (category_id)
);















INSERT INTO flow_category VALUES (100, '000000', 0, '0', 'OA审批', 0, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (101, '000000', 100, '0,100', '假勤管理', 0, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (102, '000000', 100, '0,100', '人事管理', 1, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (103, '000000', 101, '0,100,101', '请假', 0, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (104, '000000', 101, '0,100,101', '出差', 1, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (105, '000000', 101, '0,100,101', '加班', 2, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (106, '000000', 101, '0,100,101', '换班', 3, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (107, '000000', 101, '0,100,101', '外出', 4, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (108, '000000', 102, '0,100,102', '转正', 1, '0', 103, 1, now(), NULL, NULL);
INSERT INTO flow_category VALUES (109, '000000', 102, '0,100,102', '离职', 2, '0', 103, 1, now(), NULL, NULL);

-- ----------------------------
-- 流程spel表达式定义表
-- ----------------------------
CREATE TABLE flow_spel (
    id int8 NOT NULL,
    component_name VARCHAR(255),
    method_name VARCHAR(255),
    method_params VARCHAR(255),
    view_spel VARCHAR(255),
    remark VARCHAR(255),
    status CHAR(1) DEFAULT '0',
    del_flag CHAR(1) DEFAULT '0',
    create_dept int8,
    create_by int8,
    create_time TIMESTAMP,
    update_by int8,
    update_time TIMESTAMP,
    PRIMARY KEY (id)
);
















INSERT INTO flow_spel VALUES (1, 'spelRuleComponent', 'selectDeptLeaderById', 'initiatorDeptId', '#{@spelRuleComponent.selectDeptLeaderById(#initiatorDeptId)}', '根据部门id获取部门负责人', '0', '0', 103, 1, now(), 1, now());
INSERT INTO flow_spel VALUES (2, NULL, NULL, 'initiator', '${initiator}', '流程发起人', '0', '0', 103, 1, now(), 1, now());

-- ----------------------------
-- 流程实例业务扩展表
-- ----------------------------
CREATE TABLE flow_instance_biz_ext (
    id             int8,
    tenant_id      VARCHAR(20)   DEFAULT '000000',
    create_dept    int8,
    create_by      int8,
    create_time    TIMESTAMP,
    update_by      int8,
    update_time    TIMESTAMP,
    business_code  VARCHAR(255),
    business_title VARCHAR(1000),
    del_flag       CHAR(1)       DEFAULT '0',
    instance_id    int8,
    business_id    VARCHAR(255),
    PRIMARY KEY (id)
);















-- ----------------------------
-- 请假单信息
-- ----------------------------
CREATE TABLE test_leave
(
    id          int8         NOT NULL,
    tenant_id   VARCHAR(20)  DEFAULT '000000',
    apply_code  VARCHAR(50)  NOT NULL,
    leave_type  VARCHAR(255) NOT NULL,
    start_date  TIMESTAMP    NOT NULL,
    end_date    TIMESTAMP    NOT NULL,
    leave_days  int2          NOT NULL,
    remark      VARCHAR(255),
    status      VARCHAR(255),
    create_dept int8,
    create_by   int8,
    create_time TIMESTAMP,
    update_by   int8,
    update_time TIMESTAMP,
    PRIMARY KEY (id)
);

















INSERT INTO sys_menu VALUES ('11616', '工作流', '0', '6', 'workflow', '', '', '1', '0', 'M', '0', '0', '', 'workflow', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11618', '我的任务', '0', '7', 'task', '', '', '1', '0', 'M', '0', '0', '', 'my-task', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11619', '我的待办', '11618', '2', 'taskWaiting', 'workflow/task/taskWaiting', '', '1', '1', 'C', '0', '0', '', 'waiting', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11632', '我的已办', '11618', '3', 'taskFinish', 'workflow/task/taskFinish', '', '1', '1', 'C', '0', '0', '', 'finish', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11633', '我的抄送', '11618', '4', 'taskCopyList', 'workflow/task/taskCopyList', '', '1', '1', 'C', '0', '0', '', 'my-copy', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11620', '流程定义', '11616', '3', 'processDefinition', 'workflow/processDefinition/index', '', '1', '1', 'C', '0', '0', 'workflow:definition:list', 'process-definition', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11621', '流程实例', '11630', '1', 'processInstance', 'workflow/processInstance/index', '', '1', '1', 'C', '0', '0', 'workflow:instance:list', 'tree-table', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11622', '流程分类', '11616', '1', 'category', 'workflow/category/index', '', '1', '0', 'C', '0', '0', 'workflow:category:list', 'category', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11629', '我发起的', '11618', '1', 'myDocument', 'workflow/task/myDocument', '', '1', '1', 'C', '0', '0', 'workflow:instance:currentList', 'guide', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11630', '流程监控', '11616', '4', 'processMonitor', '', '', '1', '0', 'M', '0', '0', '', 'monitor', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11631', '待办任务', '11630', '2', 'allTaskWaiting', 'workflow/task/allTaskWaiting', '', '1', '1', 'C', '0', '0', '', 'waiting', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11700', '流程设计', '11616', '5', 'design/index',   'workflow/processDefinition/design', '', '1', '1', 'C', '1', '0', 'workflow:leave:edit', '#', 103, 1, now(), NULL, NULL, '/workflow/processDefinition');
INSERT INTO sys_menu VALUES ('11701', '请假申请', '11616', '6', 'leaveEdit/index', 'workflow/leave/leaveEdit', '', '1', '1', 'C', '1', '0', 'workflow:leave:edit', '#', 103, 1, now(), NULL, NULL, '');

INSERT INTO sys_menu VALUES ('11623', '流程分类查询', '11622', '1', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:query', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11624', '流程分类新增', '11622', '2', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:add', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11625', '流程分类修改', '11622', '3', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:edit', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11626', '流程分类删除', '11622', '4', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:remove', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11627', '流程分类导出', '11622', '5', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:export', '#', 103, 1, now(), NULL, NULL, '');

-- 流程实例管理相关按钮
INSERT INTO sys_menu VALUES ('11653', '流程实例查询', '11621', '1', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:instance:query', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11654', '流程变量查询', '11621', '2', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:instance:variableQuery', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11655', '流程变量修改', '11621', '3', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:instance:variable', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11656', '流程实例激活/挂起', '11621', '4', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:instance:active', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11657', '流程实例删除', '11621', '5', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:instance:remove', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11658', '流程实例作废', '11621', '6', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:instance:invalid', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11659', '流程实例撤销', '11621', '7', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:instance:cancel', '#', 103, 1, now(), NULL, NULL, '');

-- 流程定义管理相关按钮
INSERT INTO sys_menu VALUES ('11644', '流程定义查询', '11620', '1', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:query', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11645', '流程定义新增', '11620', '2', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:add', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11646', '流程定义修改', '11620', '3', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:edit', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11647', '流程定义删除', '11620', '4', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:remove', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11648', '流程定义导出', '11620', '5', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:export', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11649', '流程定义导入', '11620', '6', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:import', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11650', '流程定义发布/取消发布', '11620', '7', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:publish', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11651', '流程定义复制', '11620', '8', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:copy', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11652', '流程定义激活/挂起', '11620', '9', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:definition:active', '#', 103, 1, now(), NULL, NULL, '');

INSERT INTO sys_menu VALUES ('11801', '流程表达式', '11616', 2, 'spel', 'workflow/spel/index', '', 1, 0, 'C', '0', '0', 'workflow:spel:list', 'input', 103, 1, now(), 1, now(), '流程达式定义菜单');
INSERT INTO sys_menu VALUES ('11802', '流程spel表达式定义查询', '11801', 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:query', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11803', '流程spel表达式定义新增', '11801', 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:add', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11804', '流程spel表达式定义修改', '11801', 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:edit', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11805', '流程spel表达式定义删除', '11801', 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:remove', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11806', '流程spel表达式定义导出', '11801', 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:export', '#', 103, 1, now(), NULL, NULL, '');

INSERT INTO sys_menu VALUES ('11638', '请假申请', '5', '1', 'leave', 'workflow/leave/index', '', '1', '0', 'C', '0', '0', 'workflow:leave:list', '#', 103, 1, now(), NULL, NULL, '请假申请菜单');
INSERT INTO sys_menu VALUES ('11639', '请假申请查询', '11638', '1', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:query', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11640', '请假申请新增', '11638', '2', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:add', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11641', '请假申请修改', '11638', '3', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:edit', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11642', '请假申请删除', '11638', '4', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:remove', '#', 103, 1, now(), NULL, NULL, '');
INSERT INTO sys_menu VALUES ('11643', '请假申请导出', '11638', '5', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:export', '#', 103, 1, now(), NULL, NULL, '');

INSERT INTO sys_dict_type VALUES (13, '000000', '业务状态', 'wf_business_status', 103, 1, now(), NULL, NULL, '业务状态列表');
INSERT INTO sys_dict_type VALUES (14, '000000', '表单类型', 'wf_form_type', 103, 1, now(), NULL, NULL, '表单类型列表');
INSERT INTO sys_dict_type VALUES (15, '000000', '任务状态', 'wf_task_status', 103, 1, now(), NULL, NULL, '任务状态');
INSERT INTO sys_dict_data VALUES (39, '000000', 1, '已撤销', 'cancel', 'wf_business_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '已撤销');
INSERT INTO sys_dict_data VALUES (40, '000000', 2, '草稿', 'draft', 'wf_business_status', '', 'info', 'N', 103, 1, now(), NULL, NULL, '草稿');
INSERT INTO sys_dict_data VALUES (41, '000000', 3, '待审核', 'waiting', 'wf_business_status', '', 'primary', 'N', 103, 1, now(), NULL, NULL, '待审核');
INSERT INTO sys_dict_data VALUES (42, '000000', 4, '已完成', 'finish', 'wf_business_status', '', 'success', 'N', 103, 1, now(), NULL, NULL, '已完成');
INSERT INTO sys_dict_data VALUES (43, '000000', 5, '已作废', 'invalid', 'wf_business_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '已作废');
INSERT INTO sys_dict_data VALUES (44, '000000', 6, '已退回', 'back', 'wf_business_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '已退回');
INSERT INTO sys_dict_data VALUES (45, '000000', 7, '已终止', 'termination', 'wf_business_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '已终止');
INSERT INTO sys_dict_data VALUES (46, '000000', 1, '自定义表单', 'static', 'wf_form_type', '', 'success', 'N', 103, 1, now(), NULL, NULL, '自定义表单');
INSERT INTO sys_dict_data VALUES (47, '000000', 2, '动态表单', 'dynamic', 'wf_form_type', '', 'primary', 'N', 103, 1, now(), NULL, NULL, '动态表单');
INSERT INTO sys_dict_data VALUES (48, '000000', 1, '撤销', 'cancel', 'wf_task_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '撤销');
INSERT INTO sys_dict_data VALUES (49, '000000', 2, '通过', 'pass', 'wf_task_status', '', 'success', 'N', 103, 1, now(), NULL, NULL, '通过');
INSERT INTO sys_dict_data VALUES (50, '000000', 3, '待审核', 'waiting', 'wf_task_status', '', 'primary', 'N', 103, 1, now(), NULL, NULL, '待审核');
INSERT INTO sys_dict_data VALUES (51, '000000', 4, '作废', 'invalid', 'wf_task_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '作废');
INSERT INTO sys_dict_data VALUES (52, '000000', 5, '退回', 'back', 'wf_task_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '退回');
INSERT INTO sys_dict_data VALUES (53, '000000', 6, '终止', 'termination', 'wf_task_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '终止');
INSERT INTO sys_dict_data VALUES (54, '000000', 7, '转办', 'transfer', 'wf_task_status', '', 'primary', 'N', 103, 1, now(), NULL, NULL, '转办');
INSERT INTO sys_dict_data VALUES (55, '000000', 8, '委托', 'depute', 'wf_task_status', '', 'primary', 'N', 103, 1, now(), NULL, NULL, '委托');
INSERT INTO sys_dict_data VALUES (56, '000000', 9, '抄送', 'copy', 'wf_task_status', '', 'primary', 'N', 103, 1, now(), NULL, NULL, '抄送');
INSERT INTO sys_dict_data VALUES (57, '000000', 10, '加签', 'sign', 'wf_task_status', '', 'primary', 'N', 103, 1, now(), NULL, NULL, '加签');
INSERT INTO sys_dict_data VALUES (58, '000000', 11, '减签', 'sign_off', 'wf_task_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '减签');
INSERT INTO sys_dict_data VALUES (59, '000000', 11, '超时', 'timeout', 'wf_task_status', '', 'danger', 'N', 103, 1, now(), NULL, NULL, '超时');

