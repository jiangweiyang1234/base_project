-- OSS 公网访问：经 OpenResty /oss/ 反代到 MinIO
-- URL 形态：https://{域名}/oss/{bucket}/yyyy/MM/dd/xxx.ext
-- 执行后必须重启 slion-admin（刷新 Redis 中 OSS 配置缓存）
--
-- 关键：
--   endpoint  = 容器内 MinIO 地址（S3 API，必须是 HTTP）
--   is_https  = 仅控制连 endpoint 时用 http 还是 https；MinIO 容器内为明文，必须为 N
--   domain    = 浏览器访问前缀（可带 https://，与 OpenResty /oss/ 对齐）
--
-- 请按实际域名修改下方 domain（需与 openresty server_name 一致，且已配置 location /oss/）

UPDATE sys_oss_config
SET endpoint = 'minio:9000',
    -- 带协议的完整对外前缀；不要末尾斜杠
    domain = 'https://slion.hxsoft.net/oss',
    -- 切勿设为 Y：否则 SDK 会用 https://minio:9000 上传，触发 NotSslRecordException
    is_https = 'N',
    update_time = now()
WHERE config_key IN ('minio', 'image');

-- 修正已入库的回显地址（仅替换本机 MinIO 直链）
UPDATE sys_oss
SET url = replace(url, 'http://127.0.0.1:9000/', 'https://slion.hxsoft.net/oss/'),
    update_time = now()
WHERE url LIKE 'http://127.0.0.1:9000/%';

UPDATE sys_oss
SET url = replace(url, 'http://localhost:9000/', 'https://slion.hxsoft.net/oss/'),
    update_time = now()
WHERE url LIKE 'http://localhost:9000/%';

-- ---------------------------------------------------------------------------
-- 若要把桶名从 ruoyi 改成 slion（可选，需先建桶再改配置）：
--   docker compose exec minio mc alias set local http://127.0.0.1:9000 ruoyi ruoyi123
--   docker compose exec minio mc mb -p local/slion
--   docker compose exec minio mc anonymous set download local/slion
--   UPDATE sys_oss_config SET bucket_name = 'slion', update_time = now() WHERE config_key = 'minio';
--   重启 slion-admin
-- 注意：已上传到 ruoyi 桶的历史文件不会自动迁移
-- ---------------------------------------------------------------------------
