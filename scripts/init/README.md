# 初始化脚本说明

## 目录

- `scripts/sql/postgres/`：PostgreSQL 方言（权威源）
  - `biz.sql`：系统/RBAC/租户等核心表
  - `slion.sql`：业务扩展表
  - `workflow.sql`：Warm-Flow 工作流表
  - `job.sql`：SnailJob 表
  - `oauth.sql`：OAuth2 客户端扩展（可选）
- `scripts/sql/mysql/`：MySQL 方言（与 Postgres 对等维护）

## 推荐初始化顺序（Postgres）

```bash
psql -U postgres -d slion -f scripts/sql/postgres/biz.sql
psql -U postgres -d slion -f scripts/sql/postgres/slion.sql
# 按需
psql -U postgres -d slion -f scripts/sql/postgres/workflow.sql
psql -U postgres -d slion -f scripts/sql/postgres/oauth.sql
psql -U postgres -d slion -f scripts/sql/postgres/job.sql
```

## Docker 部署

见仓库根目录 `deploy/`：

```bash
cp deploy/.env.example deploy/.env
docker compose -f deploy/docker-compose.dev.yml --env-file deploy/.env up -d
```

## 安全提醒

1. 初始化后立即修改默认管理员密码
2. 生产环境通过环境变量注入 `SLION_JWT_SECRET`、数据库与 Redis 凭据
3. 生产关闭 `springdoc`、收窄 Actuator、关闭 p6spy
