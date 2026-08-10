-- 桶名改为 slion（与 .env MINIO_BUCKET 对齐）
-- 注意：仅改库表不够，必须先在 MinIO 中创建同名桶，否则上传会 NoSuchBucket
-- 建桶：
--   docker exec slion-minio mc alias set local http://127.0.0.1:9000 ruoyi ruoyi123
--   docker exec slion-minio mc mb -p local/slion
--   docker exec slion-minio mc anonymous set download local/slion
-- 执行本 SQL 后重启 slion-admin

UPDATE sys_oss_config
SET bucket_name = 'slion',
    update_time = now()
WHERE config_key IN ('minio', 'image');
