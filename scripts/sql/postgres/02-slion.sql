create table sys_icon
(
    id          int8         not null,
    icon_name   varchar(255) not null,
    create_dept int8,
    create_by   int8,
    create_time timestamp,
    update_by   int8,
    update_time timestamp,
    del_flag    char default '0'::bpchar,
    constraint "pk_sys_icon" primary key (id)
);

comment on table sys_icon is '图标表';
comment on column sys_icon.id is '图标ID';
comment on column sys_icon.icon_name is '图标名称';
comment on column sys_icon.create_dept is '创建部门';
comment on column sys_icon.create_by is '创建者';
comment on column sys_icon.create_time is '创建时间';
comment on column sys_icon.update_by is '更新者';
comment on column sys_icon.update_time is '更新时间';
comment on column sys_icon.del_flag is '删除标识';

insert into sys_icon
values (1, '24-hours-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2, '24-hours-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (3, '4k-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (4, '4k-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (5, 'a-b', 103, 1, now(), null, null, '0');
insert into sys_icon
values (6, 'account-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (7, 'account-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (8, 'account-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (9, 'account-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (10, 'account-pin-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (11, 'account-pin-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (12, 'account-pin-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (13, 'account-pin-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (14, 'add-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (15, 'add-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (16, 'add-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (17, 'add-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (18, 'add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (19, 'add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (20, 'admin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (21, 'admin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (22, 'airplay-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (23, 'airplay-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (24, 'alarm-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (25, 'alarm-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (26, 'alarm-warning-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (27, 'alarm-warning-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (28, 'album-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (29, 'album-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (30, 'alert-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (31, 'alert-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (32, 'aliens-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (33, 'aliens-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (34, 'align-bottom', 103, 1, now(), null, null, '0');
insert into sys_icon
values (35, 'align-center', 103, 1, now(), null, null, '0');
insert into sys_icon
values (36, 'align-justify', 103, 1, now(), null, null, '0');
insert into sys_icon
values (37, 'align-left', 103, 1, now(), null, null, '0');
insert into sys_icon
values (38, 'align-right', 103, 1, now(), null, null, '0');
insert into sys_icon
values (39, 'align-top', 103, 1, now(), null, null, '0');
insert into sys_icon
values (40, 'align-vertically', 103, 1, now(), null, null, '0');
insert into sys_icon
values (41, 'alipay-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (42, 'alipay-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (43, 'amazon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (44, 'amazon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (45, 'anchor-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (46, 'anchor-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (47, 'ancient-gate-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (48, 'ancient-gate-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (49, 'ancient-pavilion-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (50, 'ancient-pavilion-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (51, 'android-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (52, 'android-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (53, 'angularjs-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (54, 'angularjs-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (55, 'anticlockwise-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (56, 'anticlockwise-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (57, 'anticlockwise-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (58, 'anticlockwise-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (59, 'app-store-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (60, 'app-store-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (61, 'apple-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (62, 'apple-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (63, 'apps-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (64, 'apps-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (65, 'apps-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (66, 'apps-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (67, 'archive-drawer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (68, 'archive-drawer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (69, 'archive-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (70, 'archive-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (71, 'arrow-down-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (72, 'arrow-down-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (73, 'arrow-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (74, 'arrow-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (75, 'arrow-down-s-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (76, 'arrow-down-s-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (77, 'arrow-drop-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (78, 'arrow-drop-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (79, 'arrow-drop-left-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (80, 'arrow-drop-left-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (81, 'arrow-drop-right-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (82, 'arrow-drop-right-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (83, 'arrow-drop-up-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (84, 'arrow-drop-up-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (85, 'arrow-go-back-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (86, 'arrow-go-back-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (87, 'arrow-go-forward-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (88, 'arrow-go-forward-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (89, 'arrow-left-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (90, 'arrow-left-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (91, 'arrow-left-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (92, 'arrow-left-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (93, 'arrow-left-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (94, 'arrow-left-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (95, 'arrow-left-right-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (96, 'arrow-left-right-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (97, 'arrow-left-s-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (98, 'arrow-left-s-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (99, 'arrow-left-up-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (100, 'arrow-left-up-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (101, 'arrow-right-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (102, 'arrow-right-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (103, 'arrow-right-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (104, 'arrow-right-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (105, 'arrow-right-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (106, 'arrow-right-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (107, 'arrow-right-s-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (108, 'arrow-right-s-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (109, 'arrow-right-up-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (110, 'arrow-right-up-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (111, 'arrow-up-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (112, 'arrow-up-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (113, 'arrow-up-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (114, 'arrow-up-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (115, 'arrow-up-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (116, 'arrow-up-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (117, 'arrow-up-s-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (118, 'arrow-up-s-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (119, 'artboard-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (120, 'artboard-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (121, 'artboard-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (122, 'artboard-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (123, 'article-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (124, 'article-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (125, 'aspect-ratio-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (126, 'aspect-ratio-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (127, 'asterisk', 103, 1, now(), null, null, '0');
insert into sys_icon
values (128, 'at-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (129, 'at-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (130, 'attachment-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (131, 'attachment-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (132, 'attachment-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (133, 'auction-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (134, 'auction-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (135, 'award-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (136, 'award-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (137, 'baidu-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (138, 'baidu-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (139, 'ball-pen-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (140, 'ball-pen-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (141, 'bank-card-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (142, 'bank-card-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (143, 'bank-card-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (144, 'bank-card-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (145, 'bank-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (146, 'bank-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (147, 'bar-chart-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (148, 'bar-chart-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (149, 'bar-chart-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (150, 'bar-chart-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (151, 'bar-chart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (152, 'bar-chart-grouped-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (153, 'bar-chart-grouped-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (154, 'bar-chart-horizontal-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (155, 'bar-chart-horizontal-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (156, 'bar-chart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (157, 'barcode-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (158, 'barcode-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (159, 'barcode-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (160, 'barcode-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (161, 'barricade-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (162, 'barricade-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (163, 'base-station-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (164, 'base-station-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (165, 'basketball-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (166, 'basketball-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (167, 'battery-2-charge-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (168, 'battery-2-charge-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (169, 'battery-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (170, 'battery-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (171, 'battery-charge-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (172, 'battery-charge-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (173, 'battery-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (174, 'battery-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (175, 'battery-low-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (176, 'battery-low-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (177, 'battery-saver-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (178, 'battery-saver-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (179, 'battery-share-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (180, 'battery-share-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (181, 'bear-smile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (182, 'bear-smile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (183, 'behance-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (184, 'behance-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (185, 'bell-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (186, 'bell-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (187, 'bike-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (188, 'bike-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (189, 'bilibili-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (190, 'bilibili-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (191, 'bill-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (192, 'bill-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (193, 'billiards-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (194, 'billiards-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (195, 'bit-coin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (196, 'bit-coin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (197, 'blaze-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (198, 'blaze-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (199, 'bluetooth-connect-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (200, 'bluetooth-connect-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (201, 'bluetooth-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (202, 'bluetooth-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (203, 'blur-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (204, 'blur-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (205, 'body-scan-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (206, 'body-scan-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (207, 'bold', 103, 1, now(), null, null, '0');
insert into sys_icon
values (208, 'book-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (209, 'book-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (210, 'book-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (211, 'book-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (212, 'book-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (213, 'book-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (214, 'book-mark-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (215, 'book-mark-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (216, 'book-open-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (217, 'book-open-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (218, 'book-read-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (219, 'book-read-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (220, 'booklet-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (221, 'booklet-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (222, 'bookmark-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (223, 'bookmark-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (224, 'bookmark-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (225, 'bookmark-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (226, 'bookmark-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (227, 'bookmark-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (228, 'boxing-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (229, 'boxing-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (230, 'braces-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (231, 'braces-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (232, 'brackets-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (233, 'brackets-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (234, 'briefcase-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (235, 'briefcase-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (236, 'briefcase-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (237, 'briefcase-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (238, 'briefcase-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (239, 'briefcase-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (240, 'briefcase-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (241, 'briefcase-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (242, 'briefcase-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (243, 'briefcase-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (244, 'bring-forward', 103, 1, now(), null, null, '0');
insert into sys_icon
values (245, 'bring-to-front', 103, 1, now(), null, null, '0');
insert into sys_icon
values (246, 'broadcast-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (247, 'broadcast-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (248, 'brush-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (249, 'brush-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (250, 'brush-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (251, 'brush-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (252, 'brush-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (253, 'brush-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (254, 'brush-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (255, 'brush-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (256, 'bubble-chart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (257, 'bubble-chart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (258, 'bug-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (259, 'bug-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (260, 'bug-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (261, 'bug-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (262, 'building-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (263, 'building-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (264, 'building-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (265, 'building-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (266, 'building-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (267, 'building-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (268, 'building-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (269, 'building-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (270, 'bus-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (271, 'bus-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (272, 'bus-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (273, 'bus-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (274, 'bus-wifi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (275, 'bus-wifi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (276, 'cactus-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (277, 'cactus-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (278, 'cake-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (279, 'cake-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (280, 'cake-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (281, 'cake-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (282, 'cake-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (283, 'cake-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (284, 'calculator-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (285, 'calculator-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (286, 'calendar-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (287, 'calendar-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (288, 'calendar-check-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (289, 'calendar-check-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (290, 'calendar-event-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (291, 'calendar-event-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (292, 'calendar-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (293, 'calendar-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (294, 'calendar-todo-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (295, 'calendar-todo-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (296, 'camera-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (297, 'camera-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (298, 'camera-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (299, 'camera-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (300, 'camera-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (301, 'camera-lens-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (302, 'camera-lens-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (303, 'camera-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (304, 'camera-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (305, 'camera-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (306, 'camera-switch-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (307, 'camera-switch-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (308, 'capsule-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (309, 'capsule-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (310, 'car-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (311, 'car-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (312, 'car-washing-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (313, 'car-washing-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (314, 'caravan-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (315, 'caravan-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (316, 'cast-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (317, 'cast-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (318, 'cellphone-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (319, 'cellphone-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (320, 'celsius-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (321, 'celsius-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (322, 'centos-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (323, 'centos-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (324, 'character-recognition-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (325, 'character-recognition-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (326, 'charging-pile-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (327, 'charging-pile-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (328, 'charging-pile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (329, 'charging-pile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (330, 'chat-1-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (331, 'chat-1-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (332, 'chat-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (333, 'chat-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (334, 'chat-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (335, 'chat-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (336, 'chat-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (337, 'chat-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (338, 'chat-check-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (339, 'chat-check-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (340, 'chat-delete-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (341, 'chat-delete-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (342, 'chat-download-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (343, 'chat-download-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (344, 'chat-follow-up-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (345, 'chat-follow-up-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (346, 'chat-forward-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (347, 'chat-forward-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (348, 'chat-heart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (349, 'chat-heart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (350, 'chat-history-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (351, 'chat-history-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (352, 'chat-new-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (353, 'chat-new-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (354, 'chat-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (355, 'chat-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (356, 'chat-poll-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (357, 'chat-poll-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (358, 'chat-private-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (359, 'chat-private-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (360, 'chat-quote-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (361, 'chat-quote-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (362, 'chat-settings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (363, 'chat-settings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (364, 'chat-smile-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (365, 'chat-smile-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (366, 'chat-smile-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (367, 'chat-smile-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (368, 'chat-smile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (369, 'chat-smile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (370, 'chat-upload-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (371, 'chat-upload-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (372, 'chat-voice-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (373, 'chat-voice-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (374, 'check-double-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (375, 'check-double-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (376, 'check-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (377, 'check-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (378, 'checkbox-blank-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (379, 'checkbox-blank-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (380, 'checkbox-blank-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (381, 'checkbox-blank-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (382, 'checkbox-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (383, 'checkbox-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (384, 'checkbox-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (385, 'checkbox-indeterminate-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (386, 'checkbox-indeterminate-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (387, 'checkbox-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (388, 'checkbox-multiple-blank-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (389, 'checkbox-multiple-blank-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (390, 'checkbox-multiple-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (391, 'checkbox-multiple-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (392, 'china-railway-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (393, 'china-railway-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (394, 'chrome-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (395, 'chrome-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (396, 'clapperboard-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (397, 'clapperboard-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (398, 'clipboard-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (399, 'clipboard-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (400, 'clockwise-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (401, 'clockwise-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (402, 'clockwise-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (403, 'clockwise-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (404, 'close-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (405, 'close-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (406, 'close-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (407, 'close-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (408, 'closed-captioning-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (409, 'closed-captioning-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (410, 'cloud-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (411, 'cloud-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (412, 'cloud-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (413, 'cloud-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (414, 'cloud-windy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (415, 'cloud-windy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (416, 'cloudy-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (417, 'cloudy-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (418, 'cloudy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (419, 'cloudy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (420, 'code-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (421, 'code-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (422, 'code-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (423, 'code-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (424, 'code-s-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (425, 'code-s-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (426, 'code-s-slash-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (427, 'code-s-slash-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (428, 'code-view', 103, 1, now(), null, null, '0');
insert into sys_icon
values (429, 'codepen-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (430, 'codepen-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (431, 'coin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (432, 'coin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (433, 'coins-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (434, 'coins-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (435, 'collage-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (436, 'collage-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (437, 'command-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (438, 'command-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (439, 'community-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (440, 'community-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (441, 'compass-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (442, 'compass-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (443, 'compass-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (444, 'compass-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (445, 'compass-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (446, 'compass-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (447, 'compass-discover-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (448, 'compass-discover-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (449, 'compass-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (450, 'compass-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (451, 'compasses-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (452, 'compasses-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (453, 'compasses-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (454, 'compasses-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (455, 'computer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (456, 'computer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (457, 'contacts-book-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (458, 'contacts-book-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (459, 'contacts-book-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (460, 'contacts-book-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (461, 'contacts-book-upload-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (462, 'contacts-book-upload-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (463, 'contacts-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (464, 'contacts-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (465, 'contrast-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (466, 'contrast-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (467, 'contrast-drop-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (468, 'contrast-drop-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (469, 'contrast-drop-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (470, 'contrast-drop-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (471, 'contrast-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (472, 'contrast-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (473, 'copper-coin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (474, 'copper-coin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (475, 'copper-diamond-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (476, 'copper-diamond-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (477, 'copyleft-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (478, 'copyleft-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (479, 'copyright-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (480, 'copyright-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (481, 'coreos-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (482, 'coreos-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (483, 'coupon-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (484, 'coupon-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (485, 'coupon-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (486, 'coupon-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (487, 'coupon-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (488, 'coupon-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (489, 'coupon-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (490, 'coupon-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (491, 'coupon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (492, 'coupon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (493, 'cpu-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (494, 'cpu-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (495, 'creative-commons-by-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (496, 'creative-commons-by-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (497, 'creative-commons-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (498, 'creative-commons-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (499, 'creative-commons-nc-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (500, 'creative-commons-nc-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (501, 'creative-commons-nd-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (502, 'creative-commons-nd-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (503, 'creative-commons-sa-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (504, 'creative-commons-sa-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (505, 'creative-commons-zero-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (506, 'creative-commons-zero-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (507, 'criminal-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (508, 'criminal-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (509, 'crop-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (510, 'crop-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (511, 'crop-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (512, 'crop-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (513, 'css3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (514, 'css3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (515, 'cup-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (516, 'cup-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (517, 'currency-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (518, 'currency-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (519, 'cursor-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (520, 'cursor-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (521, 'customer-service-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (522, 'customer-service-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (523, 'customer-service-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (524, 'customer-service-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (525, 'dashboard-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (526, 'dashboard-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (527, 'dashboard-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (528, 'dashboard-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (529, 'dashboard-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (530, 'dashboard-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (531, 'database-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (532, 'database-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (533, 'database-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (534, 'database-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (535, 'delete-back-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (536, 'delete-back-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (537, 'delete-back-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (538, 'delete-back-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (539, 'delete-bin-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (540, 'delete-bin-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (541, 'delete-bin-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (542, 'delete-bin-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (543, 'delete-bin-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (544, 'delete-bin-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (545, 'delete-bin-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (546, 'delete-bin-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (547, 'delete-bin-6-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (548, 'delete-bin-6-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (549, 'delete-bin-7-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (550, 'delete-bin-7-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (551, 'delete-bin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (552, 'delete-bin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (553, 'delete-column', 103, 1, now(), null, null, '0');
insert into sys_icon
values (554, 'delete-row', 103, 1, now(), null, null, '0');
insert into sys_icon
values (555, 'device-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (556, 'device-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (557, 'device-recover-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (558, 'device-recover-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (559, 'dingding-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (560, 'dingding-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (561, 'direction-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (562, 'direction-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (563, 'disc-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (564, 'disc-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (565, 'discord-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (566, 'discord-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (567, 'discuss-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (568, 'discuss-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (569, 'dislike-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (570, 'dislike-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (571, 'disqus-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (572, 'disqus-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (573, 'divide-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (574, 'divide-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (575, 'donut-chart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (576, 'donut-chart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (577, 'door-closed-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (578, 'door-closed-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (579, 'door-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (580, 'door-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (581, 'door-lock-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (582, 'door-lock-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (583, 'door-lock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (584, 'door-lock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (585, 'door-open-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (586, 'door-open-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (587, 'dossier-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (588, 'dossier-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (589, 'douban-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (590, 'douban-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (591, 'double-quotes-l', 103, 1, now(), null, null, '0');
insert into sys_icon
values (592, 'double-quotes-r', 103, 1, now(), null, null, '0');
insert into sys_icon
values (593, 'download-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (594, 'download-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (595, 'download-cloud-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (596, 'download-cloud-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (597, 'download-cloud-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (598, 'download-cloud-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (599, 'download-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (600, 'download-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (601, 'draft-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (602, 'draft-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (603, 'drag-drop-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (604, 'drag-drop-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (605, 'drag-move-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (606, 'drag-move-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (607, 'drag-move-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (608, 'drag-move-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (609, 'dribbble-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (610, 'dribbble-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (611, 'drive-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (612, 'drive-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (613, 'drizzle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (614, 'drizzle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (615, 'drop-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (616, 'drop-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (617, 'dropbox-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (618, 'dropbox-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (619, 'dual-sim-1-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (620, 'dual-sim-1-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (621, 'dual-sim-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (622, 'dual-sim-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (623, 'dv-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (624, 'dv-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (625, 'dvd-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (626, 'dvd-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (627, 'e-bike-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (628, 'e-bike-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (629, 'e-bike-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (630, 'e-bike-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (631, 'earth-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (632, 'earth-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (633, 'earthquake-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (634, 'earthquake-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (635, 'edge-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (636, 'edge-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (637, 'edit-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (638, 'edit-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (639, 'edit-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (640, 'edit-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (641, 'edit-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (642, 'edit-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (643, 'edit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (644, 'edit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (645, 'eject-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (646, 'eject-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (647, 'emotion-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (648, 'emotion-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (649, 'emotion-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (650, 'emotion-happy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (651, 'emotion-happy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (652, 'emotion-laugh-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (653, 'emotion-laugh-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (654, 'emotion-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (655, 'emotion-normal-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (656, 'emotion-normal-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (657, 'emotion-sad-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (658, 'emotion-sad-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (659, 'emotion-unhappy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (660, 'emotion-unhappy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (661, 'empathize-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (662, 'empathize-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (663, 'emphasis-cn', 103, 1, now(), null, null, '0');
insert into sys_icon
values (664, 'emphasis', 103, 1, now(), null, null, '0');
insert into sys_icon
values (665, 'english-input', 103, 1, now(), null, null, '0');
insert into sys_icon
values (666, 'equalizer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (667, 'equalizer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (668, 'eraser-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (669, 'eraser-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (670, 'error-warning-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (671, 'error-warning-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (672, 'evernote-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (673, 'evernote-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (674, 'exchange-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (675, 'exchange-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (676, 'exchange-cny-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (677, 'exchange-cny-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (678, 'exchange-dollar-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (679, 'exchange-dollar-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (680, 'exchange-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (681, 'exchange-funds-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (682, 'exchange-funds-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (683, 'exchange-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (684, 'external-link-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (685, 'external-link-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (686, 'eye-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (687, 'eye-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (688, 'eye-close-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (689, 'eye-close-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (690, 'eye-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (691, 'eye-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (692, 'eye-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (693, 'eye-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (694, 'facebook-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (695, 'facebook-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (696, 'facebook-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (697, 'facebook-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (698, 'facebook-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (699, 'facebook-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (700, 'fahrenheit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (701, 'fahrenheit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (702, 'feedback-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (703, 'feedback-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (704, 'file-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (705, 'file-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (706, 'file-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (707, 'file-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (708, 'file-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (709, 'file-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (710, 'file-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (711, 'file-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (712, 'file-chart-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (713, 'file-chart-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (714, 'file-chart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (715, 'file-chart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (716, 'file-cloud-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (717, 'file-cloud-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (718, 'file-code-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (719, 'file-code-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (720, 'file-copy-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (721, 'file-copy-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (722, 'file-copy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (723, 'file-copy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (724, 'file-damage-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (725, 'file-damage-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (726, 'file-download-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (727, 'file-download-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (728, 'file-edit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (729, 'file-edit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (730, 'file-excel-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (731, 'file-excel-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (732, 'file-excel-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (733, 'file-excel-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (734, 'file-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (735, 'file-forbid-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (736, 'file-forbid-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (737, 'file-gif-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (738, 'file-gif-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (739, 'file-history-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (740, 'file-history-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (741, 'file-hwp-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (742, 'file-hwp-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (743, 'file-info-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (744, 'file-info-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (745, 'file-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (746, 'file-list-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (747, 'file-list-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (748, 'file-list-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (749, 'file-list-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (750, 'file-list-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (751, 'file-list-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (752, 'file-lock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (753, 'file-lock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (754, 'file-mark-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (755, 'file-mark-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (756, 'file-music-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (757, 'file-music-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (758, 'file-paper-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (759, 'file-paper-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (760, 'file-paper-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (761, 'file-paper-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (762, 'file-pdf-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (763, 'file-pdf-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (764, 'file-ppt-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (765, 'file-ppt-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (766, 'file-ppt-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (767, 'file-ppt-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (768, 'file-reduce-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (769, 'file-reduce-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (770, 'file-search-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (771, 'file-search-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (772, 'file-settings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (773, 'file-settings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (774, 'file-shield-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (775, 'file-shield-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (776, 'file-shield-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (777, 'file-shield-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (778, 'file-shred-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (779, 'file-shred-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (780, 'file-text-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (781, 'file-text-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (782, 'file-transfer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (783, 'file-transfer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (784, 'file-unknow-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (785, 'file-unknow-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (786, 'file-upload-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (787, 'file-upload-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (788, 'file-user-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (789, 'file-user-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (790, 'file-warning-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (791, 'file-warning-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (792, 'file-word-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (793, 'file-word-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (794, 'file-word-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (795, 'file-word-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (796, 'file-zip-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (797, 'file-zip-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (798, 'film-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (799, 'film-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (800, 'filter-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (801, 'filter-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (802, 'filter-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (803, 'filter-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (804, 'filter-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (805, 'filter-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (806, 'filter-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (807, 'filter-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (808, 'find-replace-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (809, 'find-replace-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (810, 'finder-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (811, 'finder-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (812, 'fingerprint-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (813, 'fingerprint-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (814, 'fingerprint-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (815, 'fingerprint-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (816, 'fire-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (817, 'fire-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (818, 'firefox-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (819, 'firefox-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (820, 'first-aid-kit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (821, 'first-aid-kit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (822, 'flag-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (823, 'flag-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (824, 'flag-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (825, 'flag-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (826, 'flashlight-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (827, 'flashlight-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (828, 'flask-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (829, 'flask-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (830, 'flight-land-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (831, 'flight-land-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (832, 'flight-takeoff-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (833, 'flight-takeoff-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (834, 'flood-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (835, 'flood-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (836, 'flow-chart', 103, 1, now(), null, null, '0');
insert into sys_icon
values (837, 'flutter-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (838, 'flutter-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (839, 'focus-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (840, 'focus-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (841, 'focus-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (842, 'focus-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (843, 'focus-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (844, 'focus-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (845, 'foggy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (846, 'foggy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (847, 'folder-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (848, 'folder-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (849, 'folder-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (850, 'folder-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (851, 'folder-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (852, 'folder-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (853, 'folder-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (854, 'folder-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (855, 'folder-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (856, 'folder-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (857, 'folder-chart-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (858, 'folder-chart-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (859, 'folder-chart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (860, 'folder-chart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (861, 'folder-download-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (862, 'folder-download-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (863, 'folder-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (864, 'folder-forbid-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (865, 'folder-forbid-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (866, 'folder-history-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (867, 'folder-history-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (868, 'folder-info-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (869, 'folder-info-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (870, 'folder-keyhole-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (871, 'folder-keyhole-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (872, 'folder-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (873, 'folder-lock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (874, 'folder-lock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (875, 'folder-music-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (876, 'folder-music-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (877, 'folder-open-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (878, 'folder-open-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (879, 'folder-received-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (880, 'folder-received-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (881, 'folder-reduce-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (882, 'folder-reduce-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (883, 'folder-settings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (884, 'folder-settings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (885, 'folder-shared-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (886, 'folder-shared-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (887, 'folder-shield-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (888, 'folder-shield-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (889, 'folder-shield-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (890, 'folder-shield-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (891, 'folder-transfer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (892, 'folder-transfer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (893, 'folder-unknow-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (894, 'folder-unknow-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (895, 'folder-upload-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (896, 'folder-upload-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (897, 'folder-user-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (898, 'folder-user-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (899, 'folder-warning-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (900, 'folder-warning-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (901, 'folder-zip-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (902, 'folder-zip-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (903, 'folders-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (904, 'folders-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (905, 'font-color', 103, 1, now(), null, null, '0');
insert into sys_icon
values (906, 'font-size-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (907, 'font-size', 103, 1, now(), null, null, '0');
insert into sys_icon
values (908, 'football-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (909, 'football-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (910, 'footprint-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (911, 'footprint-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (912, 'forbid-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (913, 'forbid-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (914, 'forbid-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (915, 'forbid-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (916, 'format-clear', 103, 1, now(), null, null, '0');
insert into sys_icon
values (917, 'fridge-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (918, 'fridge-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (919, 'fullscreen-exit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (920, 'fullscreen-exit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (921, 'fullscreen-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (922, 'fullscreen-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (923, 'function-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (924, 'function-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (925, 'functions', 103, 1, now(), null, null, '0');
insert into sys_icon
values (926, 'funds-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (927, 'funds-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (928, 'funds-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (929, 'funds-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (930, 'gallery-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (931, 'gallery-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (932, 'gallery-upload-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (933, 'gallery-upload-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (934, 'game-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (935, 'game-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (936, 'gamepad-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (937, 'gamepad-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (938, 'gas-station-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (939, 'gas-station-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (940, 'gatsby-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (941, 'gatsby-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (942, 'genderless-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (943, 'genderless-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (944, 'ghost-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (945, 'ghost-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (946, 'ghost-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (947, 'ghost-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (948, 'ghost-smile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (949, 'ghost-smile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (950, 'gift-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (951, 'gift-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (952, 'gift-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (953, 'gift-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (954, 'git-branch-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (955, 'git-branch-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (956, 'git-commit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (957, 'git-commit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (958, 'git-merge-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (959, 'git-merge-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (960, 'git-pull-request-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (961, 'git-pull-request-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (962, 'git-repository-commits-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (963, 'git-repository-commits-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (964, 'git-repository-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (965, 'git-repository-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (966, 'git-repository-private-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (967, 'git-repository-private-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (968, 'github-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (969, 'github-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (970, 'gitlab-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (971, 'gitlab-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (972, 'global-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (973, 'global-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (974, 'globe-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (975, 'globe-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (976, 'goblet-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (977, 'goblet-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (978, 'google-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (979, 'google-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (980, 'google-play-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (981, 'google-play-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (982, 'government-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (983, 'government-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (984, 'gps-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (985, 'gps-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (986, 'gradienter-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (987, 'gradienter-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (988, 'grid-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (989, 'grid-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (990, 'group-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (991, 'group-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (992, 'group-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (993, 'group-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (994, 'guide-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (995, 'guide-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (996, 'h-1', 103, 1, now(), null, null, '0');
insert into sys_icon
values (997, 'h-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (998, 'h-3', 103, 1, now(), null, null, '0');
insert into sys_icon
values (999, 'h-4', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1000, 'h-5', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1001, 'h-6', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1002, 'hail-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1003, 'hail-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1004, 'hammer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1005, 'hammer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1006, 'hand-coin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1007, 'hand-coin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1008, 'hand-heart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1009, 'hand-heart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1010, 'hand-sanitizer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1011, 'hand-sanitizer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1012, 'handbag-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1013, 'handbag-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1014, 'hard-drive-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1015, 'hard-drive-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1016, 'hard-drive-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1017, 'hard-drive-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1018, 'hashtag', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1019, 'haze-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1020, 'haze-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1021, 'haze-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1022, 'haze-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1023, 'hd-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1024, 'hd-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1025, 'heading', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1026, 'headphone-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1027, 'headphone-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1028, 'health-book-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1029, 'health-book-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1030, 'heart-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1031, 'heart-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1032, 'heart-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1033, 'heart-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1034, 'heart-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1035, 'heart-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1036, 'heart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1037, 'heart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1038, 'heart-pulse-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1039, 'heart-pulse-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1040, 'hearts-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1041, 'hearts-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1042, 'heavy-showers-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1043, 'heavy-showers-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1044, 'history-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1045, 'history-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1046, 'home-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1047, 'home-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1048, 'home-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1049, 'home-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1050, 'home-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1051, 'home-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1052, 'home-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1053, 'home-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1054, 'home-6-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1055, 'home-6-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1056, 'home-7-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1057, 'home-7-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1058, 'home-8-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1059, 'home-8-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1060, 'home-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1061, 'home-gear-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1062, 'home-gear-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1063, 'home-heart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1064, 'home-heart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1065, 'home-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1066, 'home-smile-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1067, 'home-smile-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1068, 'home-smile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1069, 'home-smile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1070, 'home-wifi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1071, 'home-wifi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1072, 'honor-of-kings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1073, 'honor-of-kings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1074, 'honour-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1075, 'honour-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1076, 'hospital-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1077, 'hospital-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1078, 'hotel-bed-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1079, 'hotel-bed-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1080, 'hotel-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1081, 'hotel-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1082, 'hotspot-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1083, 'hotspot-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1084, 'hq-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1085, 'hq-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1086, 'html5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1087, 'html5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1088, 'ie-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1089, 'ie-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1090, 'image-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1091, 'image-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1092, 'image-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1093, 'image-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1094, 'image-edit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1095, 'image-edit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1096, 'image-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1097, 'image-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1098, 'inbox-archive-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1099, 'inbox-archive-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1100, 'inbox-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1101, 'inbox-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1102, 'inbox-unarchive-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1103, 'inbox-unarchive-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1104, 'increase-decrease-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1105, 'increase-decrease-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1106, 'indent-decrease', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1107, 'indent-increase', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1108, 'indeterminate-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1109, 'indeterminate-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1110, 'information-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1111, 'information-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1112, 'infrared-thermometer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1113, 'infrared-thermometer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1114, 'ink-bottle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1115, 'ink-bottle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1116, 'input-cursor-move', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1117, 'input-method-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1118, 'input-method-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1119, 'insert-column-left', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1120, 'insert-column-right', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1121, 'insert-row-bottom', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1122, 'insert-row-top', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1123, 'instagram-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1124, 'instagram-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1125, 'install-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1126, 'install-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1127, 'invision-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1128, 'invision-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1129, 'italic', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1130, 'kakao-talk-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1131, 'kakao-talk-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1132, 'key-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1133, 'key-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1134, 'key-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1135, 'key-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1136, 'keyboard-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1137, 'keyboard-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1138, 'keyboard-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1139, 'keyboard-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1140, 'keynote-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1141, 'keynote-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1142, 'knife-blood-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1143, 'knife-blood-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1144, 'knife-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1145, 'knife-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1146, 'landscape-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1147, 'landscape-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1148, 'layout-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1149, 'layout-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1150, 'layout-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1151, 'layout-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1152, 'layout-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1153, 'layout-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1154, 'layout-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1155, 'layout-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1156, 'layout-6-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1157, 'layout-6-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1158, 'layout-bottom-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1159, 'layout-bottom-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1160, 'layout-bottom-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1161, 'layout-bottom-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1162, 'layout-column-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1163, 'layout-column-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1164, 'layout-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1165, 'layout-grid-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1166, 'layout-grid-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1167, 'layout-left-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1168, 'layout-left-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1169, 'layout-left-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1170, 'layout-left-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1171, 'layout-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1172, 'layout-masonry-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1173, 'layout-masonry-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1174, 'layout-right-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1175, 'layout-right-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1176, 'layout-right-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1177, 'layout-right-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1178, 'layout-row-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1179, 'layout-row-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1180, 'layout-top-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1181, 'layout-top-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1182, 'layout-top-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1183, 'layout-top-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1184, 'leaf-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1185, 'leaf-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1186, 'lifebuoy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1187, 'lifebuoy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1188, 'lightbulb-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1189, 'lightbulb-flash-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1190, 'lightbulb-flash-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1191, 'lightbulb-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1192, 'line-chart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1193, 'line-chart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1194, 'line-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1195, 'line-height', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1196, 'line-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1197, 'link-m', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1198, 'link-unlink-m', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1199, 'link-unlink', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1200, 'link', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1201, 'linkedin-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1202, 'linkedin-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1203, 'linkedin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1204, 'linkedin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1205, 'links-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1206, 'links-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1207, 'list-check-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1208, 'list-check', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1209, 'list-ordered', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1210, 'list-settings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1211, 'list-settings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1212, 'list-unordered', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1213, 'live-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1214, 'live-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1215, 'loader-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1216, 'loader-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1217, 'loader-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1218, 'loader-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1219, 'loader-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1220, 'loader-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1221, 'loader-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1222, 'loader-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1223, 'loader-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1224, 'loader-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1225, 'lock-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1226, 'lock-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1227, 'lock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1228, 'lock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1229, 'lock-password-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1230, 'lock-password-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1231, 'lock-unlock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1232, 'lock-unlock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1233, 'login-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1234, 'login-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1235, 'login-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1236, 'login-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1237, 'logout-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1238, 'logout-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1239, 'logout-box-r-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1240, 'logout-box-r-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1241, 'logout-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1242, 'logout-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1243, 'logout-circle-r-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1244, 'logout-circle-r-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1245, 'luggage-cart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1246, 'luggage-cart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1247, 'luggage-deposit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1248, 'luggage-deposit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1249, 'lungs-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1250, 'lungs-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1251, 'mac-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1252, 'mac-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1253, 'macbook-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1254, 'macbook-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1255, 'magic-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1256, 'magic-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1257, 'mail-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1258, 'mail-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1259, 'mail-check-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1260, 'mail-check-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1261, 'mail-close-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1262, 'mail-close-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1263, 'mail-download-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1264, 'mail-download-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1265, 'mail-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1266, 'mail-forbid-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1267, 'mail-forbid-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1268, 'mail-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1269, 'mail-lock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1270, 'mail-lock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1271, 'mail-open-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1272, 'mail-open-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1273, 'mail-send-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1274, 'mail-send-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1275, 'mail-settings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1276, 'mail-settings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1277, 'mail-star-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1278, 'mail-star-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1279, 'mail-unread-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1280, 'mail-unread-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1281, 'mail-volume-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1282, 'mail-volume-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1283, 'map-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1284, 'map-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1285, 'map-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1286, 'map-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1287, 'map-pin-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1288, 'map-pin-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1289, 'map-pin-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1290, 'map-pin-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1291, 'map-pin-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1292, 'map-pin-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1293, 'map-pin-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1294, 'map-pin-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1295, 'map-pin-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1296, 'map-pin-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1297, 'map-pin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1298, 'map-pin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1299, 'map-pin-range-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1300, 'map-pin-range-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1301, 'map-pin-time-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1302, 'map-pin-time-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1303, 'map-pin-user-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1304, 'map-pin-user-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1305, 'mark-pen-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1306, 'mark-pen-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1307, 'markdown-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1308, 'markdown-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1309, 'markup-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1310, 'markup-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1311, 'mastercard-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1312, 'mastercard-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1313, 'mastodon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1314, 'mastodon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1315, 'medal-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1316, 'medal-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1317, 'medal-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1318, 'medal-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1319, 'medicine-bottle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1320, 'medicine-bottle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1321, 'medium-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1322, 'medium-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1323, 'men-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1324, 'men-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1325, 'mental-health-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1326, 'mental-health-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1327, 'menu-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1328, 'menu-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1329, 'menu-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1330, 'menu-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1331, 'menu-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1332, 'menu-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1333, 'menu-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1334, 'menu-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1335, 'menu-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1336, 'menu-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1337, 'menu-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1338, 'menu-fold-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1339, 'menu-fold-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1340, 'menu-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1341, 'menu-unfold-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1342, 'menu-unfold-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1343, 'merge-cells-horizontal', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1344, 'merge-cells-vertical', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1345, 'message-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1346, 'message-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1347, 'message-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1348, 'message-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1349, 'message-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1350, 'message-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1351, 'messenger-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1352, 'messenger-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1353, 'meteor-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1354, 'meteor-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1355, 'mic-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1356, 'mic-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1357, 'mic-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1358, 'mic-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1359, 'mic-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1360, 'mic-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1361, 'mickey-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1362, 'mickey-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1363, 'microscope-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1364, 'microscope-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1365, 'microsoft-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1366, 'microsoft-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1367, 'mind-map', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1368, 'mini-program-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1369, 'mini-program-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1370, 'mist-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1371, 'mist-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1372, 'money-cny-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1373, 'money-cny-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1374, 'money-cny-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1375, 'money-cny-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1376, 'money-dollar-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1377, 'money-dollar-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1378, 'money-dollar-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1379, 'money-dollar-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1380, 'money-euro-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1381, 'money-euro-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1382, 'money-euro-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1383, 'money-euro-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1384, 'money-pound-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1385, 'money-pound-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1386, 'money-pound-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1387, 'money-pound-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1388, 'moon-clear-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1389, 'moon-clear-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1390, 'moon-cloudy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1391, 'moon-cloudy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1392, 'moon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1393, 'moon-foggy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1394, 'moon-foggy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1395, 'moon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1396, 'more-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1397, 'more-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1398, 'more-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1399, 'more-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1400, 'motorbike-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1401, 'motorbike-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1402, 'mouse-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1403, 'mouse-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1404, 'movie-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1405, 'movie-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1406, 'movie-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1407, 'movie-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1408, 'music-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1409, 'music-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1410, 'music-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1411, 'music-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1412, 'mv-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1413, 'mv-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1414, 'navigation-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1415, 'navigation-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1416, 'netease-cloud-music-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1417, 'netease-cloud-music-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1418, 'netflix-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1419, 'netflix-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1420, 'newspaper-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1421, 'newspaper-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1422, 'node-tree', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1423, 'notification-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1424, 'notification-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1425, 'notification-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1426, 'notification-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1427, 'notification-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1428, 'notification-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1429, 'notification-badge-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1430, 'notification-badge-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1431, 'notification-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1432, 'notification-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1433, 'notification-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1434, 'notification-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1435, 'npmjs-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1436, 'npmjs-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1437, 'number-0', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1438, 'number-1', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1439, 'number-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1440, 'number-3', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1441, 'number-4', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1442, 'number-5', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1443, 'number-6', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1444, 'number-7', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1445, 'number-8', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1446, 'number-9', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1447, 'numbers-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1448, 'numbers-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1449, 'nurse-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1450, 'nurse-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1451, 'oil-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1452, 'oil-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1453, 'omega', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1454, 'open-arm-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1455, 'open-arm-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1456, 'open-source-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1457, 'open-source-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1458, 'opera-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1459, 'opera-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1460, 'order-play-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1461, 'order-play-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1462, 'organization-chart', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1463, 'outlet-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1464, 'outlet-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1465, 'outlet-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1466, 'outlet-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1467, 'page-separator', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1468, 'pages-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1469, 'pages-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1470, 'paint-brush-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1471, 'paint-brush-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1472, 'paint-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1473, 'paint-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1474, 'palette-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1475, 'palette-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1476, 'pantone-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1477, 'pantone-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1478, 'paragraph', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1479, 'parent-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1480, 'parent-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1481, 'parentheses-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1482, 'parentheses-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1483, 'parking-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1484, 'parking-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1485, 'parking-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1486, 'parking-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1487, 'passport-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1488, 'passport-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1489, 'patreon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1490, 'patreon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1491, 'pause-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1492, 'pause-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1493, 'pause-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1494, 'pause-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1495, 'pause-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1496, 'pause-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1497, 'paypal-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1498, 'paypal-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1499, 'pen-nib-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1500, 'pen-nib-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1501, 'pencil-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1502, 'pencil-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1503, 'pencil-ruler-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1504, 'pencil-ruler-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1505, 'pencil-ruler-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1506, 'pencil-ruler-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1507, 'percent-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1508, 'percent-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1509, 'phone-camera-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1510, 'phone-camera-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1511, 'phone-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1512, 'phone-find-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1513, 'phone-find-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1514, 'phone-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1515, 'phone-lock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1516, 'phone-lock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1517, 'picture-in-picture-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1518, 'picture-in-picture-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1519, 'picture-in-picture-exit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1520, 'picture-in-picture-exit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1521, 'picture-in-picture-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1522, 'picture-in-picture-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1523, 'pie-chart-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1524, 'pie-chart-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1525, 'pie-chart-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1526, 'pie-chart-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1527, 'pie-chart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1528, 'pie-chart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1529, 'pin-distance-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1530, 'pin-distance-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1531, 'ping-pong-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1532, 'ping-pong-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1533, 'pinterest-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1534, 'pinterest-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1535, 'pinyin-input', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1536, 'pixelfed-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1537, 'pixelfed-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1538, 'plane-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1539, 'plane-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1540, 'plant-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1541, 'plant-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1542, 'play-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1543, 'play-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1544, 'play-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1545, 'play-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1546, 'play-list-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1547, 'play-list-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1548, 'play-list-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1549, 'play-list-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1550, 'play-list-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1551, 'play-list-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1552, 'play-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1553, 'play-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1554, 'playstation-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1555, 'playstation-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1556, 'plug-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1557, 'plug-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1558, 'plug-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1559, 'plug-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1560, 'polaroid-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1561, 'polaroid-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1562, 'polaroid-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1563, 'polaroid-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1564, 'police-car-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1565, 'police-car-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1566, 'price-tag-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1567, 'price-tag-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1568, 'price-tag-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1569, 'price-tag-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1570, 'price-tag-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1571, 'price-tag-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1572, 'printer-cloud-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1573, 'printer-cloud-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1574, 'printer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1575, 'printer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1576, 'product-hunt-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1577, 'product-hunt-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1578, 'profile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1579, 'profile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1580, 'projector-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1581, 'projector-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1582, 'projector-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1583, 'projector-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1584, 'psychotherapy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1585, 'psychotherapy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1586, 'pulse-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1587, 'pulse-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1588, 'pushpin-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1589, 'pushpin-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1590, 'pushpin-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1591, 'pushpin-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1592, 'qq-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1593, 'qq-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1594, 'qr-code-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1595, 'qr-code-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1596, 'qr-scan-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1597, 'qr-scan-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1598, 'qr-scan-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1599, 'qr-scan-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1600, 'question-answer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1601, 'question-answer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1602, 'question-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1603, 'question-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1604, 'question-mark', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1605, 'questionnaire-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1606, 'questionnaire-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1607, 'quill-pen-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1608, 'quill-pen-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1609, 'radar-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1610, 'radar-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1611, 'radio-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1612, 'radio-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1613, 'radio-button-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1614, 'radio-button-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1615, 'radio-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1616, 'radio-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1617, 'rainbow-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1618, 'rainbow-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1619, 'rainy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1620, 'rainy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1621, 'reactjs-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1622, 'reactjs-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1623, 'record-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1624, 'record-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1625, 'record-mail-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1626, 'record-mail-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1627, 'recycle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1628, 'recycle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1629, 'red-packet-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1630, 'red-packet-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1631, 'reddit-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1632, 'reddit-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1633, 'refresh-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1634, 'refresh-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1635, 'refund-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1636, 'refund-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1637, 'refund-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1638, 'refund-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1639, 'registered-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1640, 'registered-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1641, 'remixicon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1642, 'remixicon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1643, 'remote-control-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1644, 'remote-control-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1645, 'remote-control-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1646, 'remote-control-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1647, 'repeat-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1648, 'repeat-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1649, 'repeat-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1650, 'repeat-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1651, 'repeat-one-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1652, 'repeat-one-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1653, 'reply-all-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1654, 'reply-all-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1655, 'reply-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1656, 'reply-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1657, 'reserved-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1658, 'reserved-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1659, 'rest-time-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1660, 'rest-time-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1661, 'restart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1662, 'restart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1663, 'restaurant-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1664, 'restaurant-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1665, 'restaurant-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1666, 'restaurant-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1667, 'rewind-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1668, 'rewind-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1669, 'rewind-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1670, 'rewind-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1671, 'rhythm-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1672, 'rhythm-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1673, 'riding-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1674, 'riding-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1675, 'road-map-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1676, 'road-map-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1677, 'roadster-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1678, 'roadster-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1679, 'robot-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1680, 'robot-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1681, 'rocket-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1682, 'rocket-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1683, 'rocket-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1684, 'rocket-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1685, 'rotate-lock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1686, 'rotate-lock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1687, 'rounded-corner', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1688, 'route-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1689, 'route-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1690, 'router-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1691, 'router-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1692, 'rss-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1693, 'rss-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1694, 'ruler-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1695, 'ruler-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1696, 'ruler-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1697, 'ruler-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1698, 'run-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1699, 'run-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1700, 'safari-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1701, 'safari-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1702, 'safe-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1703, 'safe-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1704, 'safe-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1705, 'safe-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1706, 'sailboat-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1707, 'sailboat-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1708, 'save-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1709, 'save-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1710, 'save-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1711, 'save-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1712, 'save-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1713, 'save-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1714, 'scales-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1715, 'scales-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1716, 'scales-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1717, 'scales-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1718, 'scales-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1719, 'scales-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1720, 'scan-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1721, 'scan-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1722, 'scan-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1723, 'scan-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1724, 'scissors-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1725, 'scissors-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1726, 'scissors-cut-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1727, 'scissors-cut-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1728, 'scissors-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1729, 'scissors-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1730, 'screenshot-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1731, 'screenshot-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1732, 'screenshot-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1733, 'screenshot-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1734, 'sd-card-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1735, 'sd-card-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1736, 'sd-card-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1737, 'sd-card-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1738, 'search-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1739, 'search-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1740, 'search-eye-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1741, 'search-eye-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1742, 'search-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1743, 'search-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1744, 'secure-payment-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1745, 'secure-payment-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1746, 'seedling-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1747, 'seedling-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1748, 'send-backward', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1749, 'send-plane-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1750, 'send-plane-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1751, 'send-plane-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1752, 'send-plane-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1753, 'send-to-back', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1754, 'sensor-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1755, 'sensor-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1756, 'separator', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1757, 'server-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1758, 'server-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1759, 'service-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1760, 'service-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1761, 'settings-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1762, 'settings-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1763, 'settings-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1764, 'settings-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1765, 'settings-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1766, 'settings-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1767, 'settings-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1768, 'settings-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1769, 'settings-6-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1770, 'settings-6-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1771, 'settings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1772, 'settings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1773, 'shape-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1774, 'shape-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1775, 'shape-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1776, 'shape-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1777, 'share-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1778, 'share-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1779, 'share-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1780, 'share-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1781, 'share-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1782, 'share-forward-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1783, 'share-forward-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1784, 'share-forward-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1785, 'share-forward-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1786, 'share-forward-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1787, 'share-forward-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1788, 'share-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1789, 'shield-check-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1790, 'shield-check-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1791, 'shield-cross-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1792, 'shield-cross-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1793, 'shield-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1794, 'shield-flash-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1795, 'shield-flash-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1796, 'shield-keyhole-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1797, 'shield-keyhole-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1798, 'shield-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1799, 'shield-star-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1800, 'shield-star-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1801, 'shield-user-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1802, 'shield-user-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1803, 'ship-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1804, 'ship-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1805, 'ship-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1806, 'ship-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1807, 'shirt-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1808, 'shirt-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1809, 'shopping-bag-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1810, 'shopping-bag-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1811, 'shopping-bag-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1812, 'shopping-bag-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1813, 'shopping-bag-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1814, 'shopping-bag-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1815, 'shopping-basket-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1816, 'shopping-basket-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1817, 'shopping-basket-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1818, 'shopping-basket-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1819, 'shopping-cart-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1820, 'shopping-cart-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1821, 'shopping-cart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1822, 'shopping-cart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1823, 'showers-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1824, 'showers-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1825, 'shuffle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1826, 'shuffle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1827, 'shut-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1828, 'shut-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1829, 'side-bar-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1830, 'side-bar-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1831, 'signal-tower-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1832, 'signal-tower-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1833, 'signal-wifi-1-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1834, 'signal-wifi-1-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1835, 'signal-wifi-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1836, 'signal-wifi-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1837, 'signal-wifi-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1838, 'signal-wifi-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1839, 'signal-wifi-error-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1840, 'signal-wifi-error-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1841, 'signal-wifi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1842, 'signal-wifi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1843, 'signal-wifi-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1844, 'signal-wifi-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1845, 'sim-card-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1846, 'sim-card-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1847, 'sim-card-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1848, 'sim-card-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1849, 'single-quotes-l', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1850, 'single-quotes-r', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1851, 'sip-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1852, 'sip-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1853, 'skip-back-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1854, 'skip-back-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1855, 'skip-back-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1856, 'skip-back-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1857, 'skip-forward-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1858, 'skip-forward-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1859, 'skip-forward-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1860, 'skip-forward-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1861, 'skull-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1862, 'skull-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1863, 'skull-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1864, 'skull-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1865, 'skype-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1866, 'skype-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1867, 'slack-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1868, 'slack-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1869, 'slice-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1870, 'slice-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1871, 'slideshow-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1872, 'slideshow-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1873, 'slideshow-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1874, 'slideshow-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1875, 'slideshow-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1876, 'slideshow-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1877, 'slideshow-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1878, 'slideshow-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1879, 'smartphone-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1880, 'smartphone-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1881, 'snapchat-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1882, 'snapchat-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1883, 'snowy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1884, 'snowy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1885, 'sort-asc', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1886, 'sort-desc', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1887, 'sound-module-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1888, 'sound-module-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1889, 'soundcloud-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1890, 'soundcloud-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1891, 'space-ship-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1892, 'space-ship-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1893, 'space', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1894, 'spam-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1895, 'spam-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1896, 'spam-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1897, 'spam-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1898, 'spam-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1899, 'spam-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1900, 'speaker-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1901, 'speaker-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1902, 'speaker-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1903, 'speaker-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1904, 'speaker-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1905, 'speaker-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1906, 'spectrum-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1907, 'spectrum-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1908, 'speed-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1909, 'speed-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1910, 'speed-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1911, 'speed-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1912, 'split-cells-horizontal', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1913, 'split-cells-vertical', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1914, 'spotify-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1915, 'spotify-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1916, 'spy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1917, 'spy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1918, 'stack-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1919, 'stack-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1920, 'stack-overflow-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1921, 'stack-overflow-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1922, 'stackshare-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1923, 'stackshare-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1924, 'star-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1925, 'star-half-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1926, 'star-half-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1927, 'star-half-s-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1928, 'star-half-s-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1929, 'star-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1930, 'star-s-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1931, 'star-s-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1932, 'star-smile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1933, 'star-smile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1934, 'steam-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1935, 'steam-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1936, 'steering-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1937, 'steering-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1938, 'steering-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1939, 'steering-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1940, 'stethoscope-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1941, 'stethoscope-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1942, 'sticky-note-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1943, 'sticky-note-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1944, 'sticky-note-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1945, 'sticky-note-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1946, 'stock-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1947, 'stock-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1948, 'stop-circle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1949, 'stop-circle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1950, 'stop-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1951, 'stop-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1952, 'stop-mini-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1953, 'stop-mini-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1954, 'store-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1955, 'store-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1956, 'store-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1957, 'store-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1958, 'store-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1959, 'store-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1960, 'strikethrough-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1961, 'strikethrough', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1962, 'subscript-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1963, 'subscript', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1964, 'subtract-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1965, 'subtract-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1966, 'subway-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1967, 'subway-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1968, 'subway-wifi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1969, 'subway-wifi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1970, 'suitcase-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1971, 'suitcase-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1972, 'suitcase-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1973, 'suitcase-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1974, 'suitcase-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1975, 'suitcase-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1976, 'sun-cloudy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1977, 'sun-cloudy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1978, 'sun-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1979, 'sun-foggy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1980, 'sun-foggy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1981, 'sun-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1982, 'superscript-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1983, 'superscript', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1984, 'surgical-mask-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1985, 'surgical-mask-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1986, 'surround-sound-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1987, 'surround-sound-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1988, 'survey-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1989, 'survey-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1990, 'swap-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1991, 'swap-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1992, 'swap-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1993, 'swap-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1994, 'switch-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1995, 'switch-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1996, 'sword-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1997, 'sword-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1998, 'syringe-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (1999, 'syringe-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2000, 't-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2001, 't-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2002, 't-shirt-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2003, 't-shirt-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2004, 't-shirt-air-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2005, 't-shirt-air-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2006, 't-shirt-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2007, 't-shirt-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2008, 'table-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2009, 'table-alt-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2010, 'table-alt-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2011, 'table-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2012, 'table-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2013, 'tablet-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2014, 'tablet-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2015, 'takeaway-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2016, 'takeaway-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2017, 'taobao-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2018, 'taobao-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2019, 'tape-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2020, 'tape-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2021, 'task-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2022, 'task-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2023, 'taxi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2024, 'taxi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2025, 'taxi-wifi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2026, 'taxi-wifi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2027, 'team-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2028, 'team-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2029, 'telegram-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2030, 'telegram-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2031, 'temp-cold-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2032, 'temp-cold-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2033, 'temp-hot-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2034, 'temp-hot-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2035, 'terminal-box-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2036, 'terminal-box-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2037, 'terminal-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2038, 'terminal-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2039, 'terminal-window-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2040, 'terminal-window-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2041, 'test-tube-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2042, 'test-tube-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2043, 'text-direction-l', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2044, 'text-direction-r', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2045, 'text-spacing', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2046, 'text-wrap', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2047, 'text', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2048, 'thermometer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2049, 'thermometer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2050, 'thumb-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2051, 'thumb-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2052, 'thumb-up-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2053, 'thumb-up-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2054, 'thunderstorms-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2055, 'thunderstorms-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2056, 'ticket-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2057, 'ticket-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2058, 'ticket-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2059, 'ticket-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2060, 'time-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2061, 'time-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2062, 'timer-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2063, 'timer-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2064, 'timer-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2065, 'timer-flash-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2066, 'timer-flash-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2067, 'timer-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2068, 'todo-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2069, 'todo-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2070, 'toggle-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2071, 'toggle-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2072, 'tools-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2073, 'tools-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2074, 'tornado-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2075, 'tornado-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2076, 'trademark-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2077, 'trademark-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2078, 'traffic-light-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2079, 'traffic-light-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2080, 'train-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2081, 'train-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2082, 'train-wifi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2083, 'train-wifi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2084, 'translate-2', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2085, 'translate', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2086, 'travesti-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2087, 'travesti-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2088, 'treasure-map-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2089, 'treasure-map-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2090, 'trello-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2091, 'trello-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2092, 'trophy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2093, 'trophy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2094, 'truck-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2095, 'truck-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2096, 'tumblr-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2097, 'tumblr-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2098, 'tv-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2099, 'tv-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2100, 'tv-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2101, 'tv-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2102, 'twitch-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2103, 'twitch-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2104, 'twitter-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2105, 'twitter-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2106, 'typhoon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2107, 'typhoon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2108, 'u-disk-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2109, 'u-disk-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2110, 'ubuntu-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2111, 'ubuntu-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2112, 'umbrella-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2113, 'umbrella-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2114, 'underline', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2115, 'uninstall-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2116, 'uninstall-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2117, 'unsplash-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2118, 'unsplash-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2119, 'upload-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2120, 'upload-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2121, 'upload-cloud-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2122, 'upload-cloud-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2123, 'upload-cloud-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2124, 'upload-cloud-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2125, 'upload-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2126, 'upload-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2127, 'usb-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2128, 'usb-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2129, 'user-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2130, 'user-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2131, 'user-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2132, 'user-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2133, 'user-4-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2134, 'user-4-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2135, 'user-5-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2136, 'user-5-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2137, 'user-6-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2138, 'user-6-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2139, 'user-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2140, 'user-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2141, 'user-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2142, 'user-follow-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2143, 'user-follow-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2144, 'user-heart-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2145, 'user-heart-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2146, 'user-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2147, 'user-location-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2148, 'user-location-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2149, 'user-received-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2150, 'user-received-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2151, 'user-received-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2152, 'user-received-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2153, 'user-search-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2154, 'user-search-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2155, 'user-settings-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2156, 'user-settings-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2157, 'user-shared-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2158, 'user-shared-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2159, 'user-shared-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2160, 'user-shared-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2161, 'user-smile-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2162, 'user-smile-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2163, 'user-star-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2164, 'user-star-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2165, 'user-unfollow-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2166, 'user-unfollow-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2167, 'user-voice-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2168, 'user-voice-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2169, 'video-add-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2170, 'video-add-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2171, 'video-chat-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2172, 'video-chat-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2173, 'video-download-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2174, 'video-download-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2175, 'video-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2176, 'video-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2177, 'video-upload-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2178, 'video-upload-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2179, 'vidicon-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2180, 'vidicon-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2181, 'vidicon-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2182, 'vidicon-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2183, 'vimeo-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2184, 'vimeo-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2185, 'vip-crown-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2186, 'vip-crown-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2187, 'vip-crown-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2188, 'vip-crown-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2189, 'vip-diamond-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2190, 'vip-diamond-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2191, 'vip-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2192, 'vip-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2193, 'virus-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2194, 'virus-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2195, 'visa-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2196, 'visa-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2197, 'voice-recognition-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2198, 'voice-recognition-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2199, 'voiceprint-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2200, 'voiceprint-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2201, 'volume-down-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2202, 'volume-down-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2203, 'volume-mute-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2204, 'volume-mute-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2205, 'volume-off-vibrate-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2206, 'volume-off-vibrate-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2207, 'volume-up-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2208, 'volume-up-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2209, 'volume-vibrate-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2210, 'volume-vibrate-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2211, 'vuejs-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2212, 'vuejs-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2213, 'walk-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2214, 'walk-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2215, 'wallet-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2216, 'wallet-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2217, 'wallet-3-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2218, 'wallet-3-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2219, 'wallet-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2220, 'wallet-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2221, 'water-flash-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2222, 'water-flash-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2223, 'webcam-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2224, 'webcam-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2225, 'wechat-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2226, 'wechat-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2227, 'wechat-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2228, 'wechat-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2229, 'wechat-pay-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2230, 'wechat-pay-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2231, 'weibo-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2232, 'weibo-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2233, 'whatsapp-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2234, 'whatsapp-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2235, 'wheelchair-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2236, 'wheelchair-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2237, 'wifi-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2238, 'wifi-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2239, 'wifi-off-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2240, 'wifi-off-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2241, 'window-2-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2242, 'window-2-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2243, 'window-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2244, 'window-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2245, 'windows-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2246, 'windows-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2247, 'windy-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2248, 'windy-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2249, 'wireless-charging-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2250, 'wireless-charging-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2251, 'women-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2252, 'women-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2253, 'wubi-input', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2254, 'xbox-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2255, 'xbox-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2256, 'xing-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2257, 'xing-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2258, 'youtube-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2259, 'youtube-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2260, 'zcool-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2261, 'zcool-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2262, 'zhihu-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2263, 'zhihu-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2264, 'zoom-in-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2265, 'zoom-in-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2266, 'zoom-out-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2267, 'zoom-out-line', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2268, 'zzz-fill', 103, 1, now(), null, null, '0');
insert into sys_icon
values (2269, 'zzz-line', 103, 1, now(), null, null, '0');

drop table if exists slion_project;
create table if not exists slion_project
(
    -- basic information
    project_id    int8,
    project_name  varchar(512) not null,
    up_project_id int8         not null default 0,
    tenant_id     varchar(20)  not null default '000000'::varchar,
    project_type  int4                  default 1,
    project_level int4                  default 1,
    -- address part
    country       int8                  default 0,
    province      int8                  default 0,
    city          int8                  default 0,
    area          int8                  default 0,
    street        int8                  default 0,
    address       varchar(512)          default null::varchar,
    lat           float                 default 0,
    lon           float                 default 0,
    -- owner
    linker_name   varchar(512)          default null::varchar,
    linker_mobile varchar(32)           default null::varchar,
    -- device
    project_state int4                  default 1,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_project_pk primary key (project_id)
);

comment on table slion_project is '项目数据表';
comment on column slion_project.project_id is '项目ID';
comment on column slion_project.project_name is '项目名称';
comment on column slion_project.up_project_id is '上级项目ID';
comment on column slion_project.tenant_id is '租户ID';
comment on column slion_project.project_type is '项目类型: 1.停车道闸场景 2.校园门禁场景';
comment on column slion_project.project_level is '项目级别';
comment on column slion_project.country is '国家ID';
comment on column slion_project.province is '省级ID';
comment on column slion_project.city is '城市ID';
comment on column slion_project.area is '区域ID';
comment on column slion_project.street is '街道ID';
comment on column slion_project.address is '详细地址';
comment on column slion_project.lat is '纬度';
comment on column slion_project.lon is '经度';
comment on column slion_project.linker_name is '联系人姓名';
comment on column slion_project.linker_mobile is '联系人电话';
comment on column slion_project.project_state is '项目状态: 1.施工中 2.部分离线 3.在线 4.报警 5.已拆除';
comment on column slion_project.create_dept is '创建部门';
comment on column slion_project.create_by is '创建者';
comment on column slion_project.create_time is '创建时间';
comment on column slion_project.update_by is '更新者';
comment on column slion_project.update_time is '更新时间';

create index idx_project_up_pid on slion_project(up_project_id);
create index idx_project_creator on slion_project(create_by);
create index idx_project_name on slion_project(project_name);
create index idx_project_tenant on slion_project(tenant_id);


drop table if exists slion_project_remark;
create table if not exists slion_project_remark
(
    -- basic information
    id    int8,
    project_id    int8              not null,
    remark        varchar(512)      not null,
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_proj_remark_pk primary key (id)
);

comment on table slion_project_remark is '项目备注信息表';
comment on column slion_project_remark.project_id is '项目ID';
comment on column slion_project_remark.remark is '备注信息';
comment on column slion_project_remark.create_dept is '创建部门';
comment on column slion_project_remark.create_by is '创建者';
comment on column slion_project_remark.create_time is '创建时间';
comment on column slion_project_remark.update_by is '更新者';
comment on column slion_project_remark.update_time is '更新时间';

create index idx_proj_remark_pid_uid on slion_project_remark(project_id,create_by);

drop table if exists slion_project_grant;
create table slion_project_grant(
    gid           int8,
    -- basic information
    project_id    int8,
    grant_type    int4         not null default 1::int4,
    grant_from    int8         not null default 0::int8,
    grant_to      int8         not null default 0::int8,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_project_grant_pk primary key (gid)
);

comment on table slion_project_grant is '项目授权信息表';
comment on column slion_project_grant.gid is '主键ID';
comment on column slion_project_grant.project_id is '项目ID';
comment on column slion_project_grant.grant_type is '授权类型: 1.授权给公司 2.授权给部门 3.授权给个人';
comment on column slion_project_grant.grant_from is '授权发起人';
comment on column slion_project_grant.grant_to is '授权接收对象';
comment on column slion_project_grant.create_dept is '创建部门';
comment on column slion_project_grant.create_by is '创建者';
comment on column slion_project_grant.create_time is '创建时间';
comment on column slion_project_grant.update_by is '更新者';
comment on column slion_project_grant.update_time is '更新时间';

create index idx_project_grant_to on slion_project_grant(grant_type,grant_to);
create index idx_project_grant_pid on slion_project_grant(project_id);

drop table if exists slion_device;
create table slion_device(
    id           int8,
    -- basic information
    device_sn       varchar(512)    not null default ''::varchar,
    device_type     int4            not null default 0::int4,
    os_type         int2            not null default 0::int2,
    os_name         varchar(32)     not null default ''::varchar,
    kernel_version  varchar(64)     not null default ''::varchar,
    os_version      varchar(64)     not null default ''::varchar,
    hostname        varchar(64)     not null default ''::varchar,
    username        varchar(256)    not null default ''::varchar,
    passwd          varchar(256)    not null default ''::varchar,
    -- device dynamic information
    uptime          int4            not null default 0::int4,
    load1           float4          not null default 0.0::float4,
    load5           float4          not null default 0.0::float4,
    load10          float4          not null default 0.0::float4,
    mem_total       int8            not null default 0::int8,
    mem_use         int8            not null default 0::int8,
    mem_free        int8            not null default 0::int8,
    disk_total      int8            not null default 0::int8,
    disk_use        int8            not null default 0::int8,
    disk_free       int8            not null default 0::int8,
    services        varchar(64)     not null default ''::varchar,
    status          int4            not null default 1::int4,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_device_pk primary key (id)
);

comment on table slion_device is '设备信息表';
comment on column slion_device.id is '主键ID';
comment on column slion_device.device_sn is '项目ID';
comment on column slion_device.device_type is '设备类型: 0.默认 1.校园场景 2.停车场景';
comment on column slion_device.os_type is '操作系统类型: 1.Linux 2.Windows';
comment on column slion_device.os_name is '操作系统名称: Centos, Ubuntu, Debian, SUSE, RedHat, Windows';
comment on column slion_device.os_version is '系统版本';
comment on column slion_device.kernel_version is '内核版本';
comment on column slion_device.uptime is '系统运行时间,单位:秒';
comment on column slion_device.load1 is '1分钟系统负载';
comment on column slion_device.load5 is '5分钟系统负载';
comment on column slion_device.load10 is '10分钟系统负载';
comment on column slion_device.mem_total is '总内存,单位:MB';
comment on column slion_device.mem_use is '使用内存,单位:MB';
comment on column slion_device.mem_free is '空闲内存,单位:MB';
comment on column slion_device.disk_total is '总存储,单位:MB';
comment on column slion_device.disk_use is '使用存储,单位:MB';
comment on column slion_device.disk_free is '空闲存储,单位:MB';
comment on column slion_device.services is '运行服务';
comment on column slion_device.status is '有效状态: 1.正常 2.报警 3.离线 4.弱网';
comment on column slion_device.create_dept is '创建部门';
comment on column slion_device.create_by is '创建者';
comment on column slion_device.create_time is '创建时间';
comment on column slion_device.update_by is '更新者';
comment on column slion_device.update_time is '更新时间';

create index idx_device_sn on slion_device(device_sn);


drop table if exists slion_device_network;
create table slion_device_network(
    id           int8,
    -- basic information
    device_id       int8                not null default 0::int8,
    net_name        varchar(32)         not null default ''::varchar,
    ip_address      varchar(32)         not null default ''::varchar,
    mac_address     varchar(32)         not null default ''::varchar,
    status          int4                not null default 1::int4,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_device_network_pk primary key (id)
);

comment on table slion_device_network is '设备网络表';
comment on column slion_device_network.id is '主键ID';
comment on column slion_device_network.device_id is '设备ID';
comment on column slion_device_network.net_name is '网口名称';
comment on column slion_device_network.ip_address is 'IP地址';
comment on column slion_device_network.mac_address is 'MAC地址';
comment on column slion_device_network.status is '通讯状态 1.正常 2.异常';
comment on column slion_device_network.create_dept is '创建部门';
comment on column slion_device_network.create_by is '创建者';
comment on column slion_device_network.create_time is '创建时间';
comment on column slion_device_network.update_by is '更新者';
comment on column slion_device_network.update_time is '更新时间';

create index idx_device_network_did on slion_device_network(device_id);
create index idx_device_network_mac on slion_device_network(mac_address);


drop table if exists slion_device_mac_import;
create table slion_device_mac_import(
    id           int8,
    -- basic information
    device_id       int8                not null default 0::int8,
    tenant_id       int8                not null default 0::int8,
    mac_address1    varchar(32)         not null default '0:0:0:0:0:0'::varchar,
    mac_address2    varchar(32)         not null default '0:0:0:0:0:0'::varchar,
    remark          varchar(256)        not null default ''::varchar,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_device_mac_imp_pk primary key (id)
);

comment on table slion_device_mac_import is '设备Mac数据导入表';
comment on column slion_device_mac_import.id is '主键ID';
comment on column slion_device_mac_import.device_id is '设备ID';
comment on column slion_device_mac_import.tenant_id is '租户ID';
comment on column slion_device_mac_import.mac_address1 is 'MAC地址1';
comment on column slion_device_mac_import.mac_address2 is 'MAC地址2';
comment on column slion_device_mac_import.remark is '备注信息';
comment on column slion_device_mac_import.create_dept is '创建部门';
comment on column slion_device_mac_import.create_by is '创建者';
comment on column slion_device_mac_import.create_time is '创建时间';
comment on column slion_device_mac_import.update_by is '更新者';
comment on column slion_device_mac_import.update_time is '更新时间';

create index idx_device_mac_import_mac1 on slion_device_mac_import(mac_address1);
create index idx_device_mac_import_mac2 on slion_device_mac_import(mac_address2);


drop table if exists slion_device_frp;
create table slion_device_frp(
    id           int8,
    -- basic information
    device_id           int8                not null default 0::int8,
    frp_config          jsonb               not null default '{}'::jsonb,
    biz_key             varchar             not null default ''::varchar,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_device_frp_pk primary key (id)
);

comment on table slion_device_frp is '设备Mac数据导入表';
comment on column slion_device_frp.id is '主键ID';
comment on column slion_device_frp.device_id is '设备ID';
comment on column slion_device_frp.frp_config is 'FRP Client配置参数,以json进行参数存储';
comment on column slion_device_frp.biz_key is '业务Key';
comment on column slion_device_frp.create_dept is '创建部门';
comment on column slion_device_frp.create_by is '创建者';
comment on column slion_device_frp.create_time is '创建时间';
comment on column slion_device_frp.update_by is '更新者';
comment on column slion_device_frp.update_time is '更新时间';

create index slion_device_frp_device on slion_device_frp(device_id);


drop table if exists slion_device_order;
create table slion_device_order(
    id           int8,
    -- basic information
    device_id           int8            not null default 0::int8,
    tenant_id           int8            not null default 0::int8,
    order_no            varchar(32)     not null default ''::varchar,
    order_type          int2            not null default 0::int2,
    send_time           timestamp       default current_timestamp,
    recv_time           timestamp,
    command             varchar(512)    not null default ''::varchar,
    process             int2            not null default 0::int2,
    response            jsonb           not null default '{}'::jsonb,
    status              int2            not null default 0::int2,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_device_order_pk primary key (id)
);

comment on table slion_device_order is '设备指令信息表';
comment on column slion_device_order.id is '主键ID';
comment on column slion_device_order.device_id is '设备ID';
comment on column slion_device_order.tenant_id is '租户ID';
comment on column slion_device_order.order_no is '指令OrderNo';
comment on column slion_device_order.order_type is '指令类型: 1.本地指令 2.服务升级 3.修改本地参数';
comment on column slion_device_order.send_time is '指令发送时间';
comment on column slion_device_order.recv_time is '指令接收时间';
comment on column slion_device_order.command is '指令内容';
comment on column slion_device_order.process is '指令执行进度,主要用于服务升级进度显示';
comment on column slion_device_order.status is '指令执行状态: 1.未触发 2.进行中 3.执行成功 4.执行失败';
comment on column slion_device_order.create_dept is '创建部门';
comment on column slion_device_order.create_by is '创建者';
comment on column slion_device_order.create_time is '创建时间';
comment on column slion_device_order.update_by is '更新者';
comment on column slion_device_order.update_time is '更新时间';


drop table if exists slion_frp_hosts;
create table slion_frp_hosts(
    id           int8,
    -- basic information
    device_id           int8            not null default 0::int8,
    tenant_id           int8            not null default 0::int8,
    host_name           varchar(256)    not null default ''::varchar,
    protocol            varchar(16)     not null default ''::varchar,
    host                varchar(64)     not null default ''::varchar,
    port                int4            not null default 80::int4,
    remote_port         int4            not null default 0::int4,
    biz_key             varchar(32)     unique not null,
    view_key            varchar(32)     unique not null,
    use_encryption      bool            not null default false::bool,
    use_compression     bool            not null default false::bool,
    plugin_user         varchar(128)    not null default ''::varchar,
    plugin_pwd          varchar(128)    not null default ''::varchar,
    status              int2            not null default 0::int2,
    -- common keys
    create_dept   int8,
    create_by     int8,
    create_time   timestamp             default current_timestamp,
    update_by     int8,
    update_time   timestamp,
    constraint slion_frp_hosts_pk primary key (id)
);

comment on table slion_frp_hosts is 'FRP服务配置表';
comment on column slion_frp_hosts.id is '主键ID';
comment on column slion_frp_hosts.device_id is '设备ID';
comment on column slion_frp_hosts.tenant_id is '租户ID';
comment on column slion_frp_hosts.host_name is '主机名称';
comment on column slion_frp_hosts.protocol is '服务主机协议';
comment on column slion_frp_hosts.host is '服务主机IP';
comment on column slion_frp_hosts.port is '端口号:默认80';
comment on column slion_frp_hosts.remote_port is '远程端口号';
comment on column slion_frp_hosts.biz_key is '服务链路业务Key';
comment on column slion_frp_hosts.view_key is '服务链路访问Key';
comment on column slion_frp_hosts.use_encryption is '是否加密';
comment on column slion_frp_hosts.use_compression is '是否压缩';
comment on column slion_frp_hosts.plugin_user is '用户名';
comment on column slion_frp_hosts.plugin_pwd is '访问密码';
comment on column slion_frp_hosts.status is '服务状态: 0.异常 1.正常';
comment on column slion_frp_hosts.create_dept is '创建部门';
comment on column slion_frp_hosts.create_by is '创建者';
comment on column slion_frp_hosts.create_time is '创建时间';
comment on column slion_frp_hosts.update_by is '更新者';
comment on column slion_frp_hosts.update_time is '更新时间';
