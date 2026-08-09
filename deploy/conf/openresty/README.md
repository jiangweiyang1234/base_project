# OpenResty 同域反代（Web + Admin + OAuth）

样例：[`slion.conf`](./slion.conf)

同一域名下：

| 路径 | 后端 | 说明 |
|---|---|---|
| `/` | `127.0.0.1:280` | 管理后台前端 |
| `/prod-api/` | `127.0.0.1:28080/` | 管理端 API（剥前缀） |
| `/oauth2/`、`/open-api/`、`/.well-known/`、`/userinfo` | `127.0.0.1:28080` | OAuth2 / 开放 API |

`oauth2.issuer` 请配置为该域名根地址，例如 `https://test-slion.example.com`。

## 部署

```bash
cp deploy/conf/openresty/slion.conf /usr/local/openresty/nginx/conf/vhost/slion.conf
# 修改 server_name 后：
openresty -t && openresty -s reload
```

## 开启 OAuth2

`deploy/.env`：

```env
OAUTH2_ENABLED=true
OAUTH2_ISSUER=https://test-slion.example.com
```

客户端 AppKey/AppSecret 在管理后台「系统管理 → 开放应用」维护，不再依赖统一 yaml 密钥。

## 联调

```bash
# 使用后台创建的 AppKey / AppSecret
curl -u 'AppKey:AppSecret' \
  -d 'grant_type=client_credentials&scope=open.api' \
  https://test-slion.example.com/oauth2/token

curl -H "Authorization: Bearer <token>" \
  https://test-slion.example.com/open-api/ping
```
