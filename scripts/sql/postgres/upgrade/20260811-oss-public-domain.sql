-- OSS 公网访问：经 OpenResty /oss/ 反代到 MinIO
-- URL 形态：https://{域名}/oss/{bucket}/yyyy/MM/dd/xxx.ext
-- 执行后必须重启 slion-admin（刷新 Redis 中 OSS 配置缓存）
--
-- 请按实际域名修改下方 domain（需与 openresty server_name 一致，且已配置 location /oss/）

UPDATE sys_oss_config
SET endpoint = 'minio:9000',
    -- 带协议的完整对外前缀；不要末尾斜杠
    domain = 'https://slion.hxsoft.net/oss',
    is_https = 'Y',
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
--   1) docker compose 里 MINIO_BUCKET=slion 后重建 minio-init
--      或：docker exec -it slion-minio mc alias set local http://127.0.0.1:9000 ruoyi ruoyi123
--          docker exec -it slion-minio mc mb -p local/slion
--          docker exec -it slion-minio mc anonymous set download local/slion
--   2) 执行：
-- UPDATE sys_oss_config SET bucket_name = 'slion', update_time = now() WHERE config_key = 'minio';
--   3) 重启 slion-admin
-- 注意：已上传到 ruoyi 桶的历史文件不会自动迁移，需重新上传或 mc cp
-- ---------------------------------------------------------------------------
