-- OSS / MinIO：容器网络内用 minio:9000 上传；浏览器访问用 domain（宿主机映射端口）
-- 执行后需重启 slion-admin，以便重新加载 Redis 中的 OSS 配置缓存

UPDATE sys_oss_config
SET endpoint = 'minio:9000',
    domain = '127.0.0.1:9000',
    is_https = 'N',
    access_key = COALESCE(NULLIF(access_key, ''), 'ruoyi'),
    secret_key = COALESCE(NULLIF(secret_key, ''), 'ruoyi123'),
    bucket_name = COALESCE(NULLIF(bucket_name, ''), 'ruoyi'),
    update_time = now()
WHERE config_key IN ('minio', 'image')
  AND (endpoint IS NULL OR endpoint = '' OR endpoint LIKE '127.0.0.1%' OR endpoint LIKE 'localhost%');
