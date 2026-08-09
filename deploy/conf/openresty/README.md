# OpenResty 宿主机反代

样例文件：[`slion.conf`](./slion.conf)

## 部署步骤

1. 复制到 OpenResty vhost 目录（路径按环境调整）：
   ```bash
   cp deploy/conf/openresty/slion.conf /usr/local/openresty/nginx/conf/vhost/slion.conf
   ```
2. 修改 `server_name`（及可选 SSL 证书路径）。
3. 确认 `http {}` 中有 WebSocket `map`（见 `slion.conf` 头部注释）。
4. 校验并重载：
   ```bash
   openresty -t && openresty -s reload
   ```

## 开启 OAuth2 开放 API

在 `deploy/.env` 中设置（`issuer` 必须与对外访问根地址一致）：

```env
OAUTH2_ENABLED=true
OAUTH2_ISSUER=https://test-slion.example.com
OAUTH2_CLIENT_ID=slion-open-api
OAUTH2_CLIENT_SECRET=请换成强密码
```

然后重建/重启 admin：

```bash
./deploy/start.sh
```

## 联调示例

```bash
# 换 token
curl -u 'slion-open-api:你的secret' \
  -d 'grant_type=client_credentials&scope=open.api' \
  https://test-slion.example.com/oauth2/token

# 调开放接口
curl -H "Authorization: Bearer <access_token>" \
  https://test-slion.example.com/open-api/ping
```
