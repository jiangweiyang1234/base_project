-- 修复：is_https=Y 会导致 SDK 以 HTTPS 连接容器内 minio:9000（明文 HTTP），出现 NotSslRecordException
-- 公网 https 写在 domain 即可；连 MinIO 上传必须 is_https=N
-- 执行后重启 slion-admin

UPDATE sys_oss_config
SET is_https = 'N',
    endpoint = 'minio:9000',
    domain = COALESCE(NULLIF(domain, ''), 'https://slion.hxsoft.net/oss'),
    update_time = now()
WHERE config_key IN ('minio', 'image');
