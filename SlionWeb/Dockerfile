# syntax=docker/dockerfile:1
# 容器内 npm 编译前端，无需宿主机安装 Node/pnpm/cnpm
# 使用 Node 22 + bookworm-slim（glibc）+ npmmirror
#
# 重要：不要在镜像里 ENV VUE_APP_SECRET_KEY=preview，
# Vue CLI 不会用 .env.local 覆盖已存在的环境变量，会导致打包被 vue.config.js 拦截且无 dist。
#
# 基础镜像走国内代理（与 deploy/docker-compose 中 postgres/redis 一致），避免直连 Docker Hub 卡住

FROM docker.1ms.run/library/node:22-bookworm-slim AS build

WORKDIR /app

ENV npm_config_registry=https://registry.npmmirror.com \
    npm_config_fund=false \
    npm_config_audit=false \
    npm_config_progress=true \
    npm_config_fetch_retries=5 \
    npm_config_fetch_retry_mintimeout=20000 \
    npm_config_fetch_retry_maxtimeout=120000 \
    npm_config_build_from_source=false \
    npm_config_legacy_peer_deps=true

COPY package.json .npmrc ./
COPY vab-icons ./vab-icons

RUN --mount=type=cache,id=slion-web-npm-node22,target=/root/.npm \
    echo "[slion-web] npm install start (may take several minutes on first build)..." && \
    npm install --registry=https://registry.npmmirror.com --legacy-peer-deps --no-audit --no-fund && \
    echo "[slion-web] npm install done"

# 含 .env / .env.local / .env.production，供 Vue CLI 读取授权与接口前缀
COPY . .

# 仅覆盖构建期需要的非密钥变量；密钥以仓库内 .env.local 为准
ARG VUE_APP_BASE_URL=/prod-api
ARG VUE_APP_CLIENT_ID=e5cd7e4891bf95d1d19206ce24a7b32e
ARG VUE_APP_RSA_PUBLIC_KEY=
ENV VUE_APP_BASE_URL=${VUE_APP_BASE_URL} \
    VUE_APP_CLIENT_ID=${VUE_APP_CLIENT_ID} \
    VUE_APP_ENCRYPT=true \
    VUE_APP_RSA_PUBLIC_KEY=${VUE_APP_RSA_PUBLIC_KEY} \
    NODE_OPTIONS=--max_old_space_size=4096

# 持久化 Webpack filesystem cache：源码小改时二次构建可明显低于 100s
# （首次全量仍约 1～2 分钟，取决于 CPU；需 BuildKit）
RUN --mount=type=cache,id=slion-web-webpack-cache,target=/app/node_modules/.cache \
    echo "[slion-web] npm run build start..." && \
    npm run build && \
    test -d /app/dist && test -n "$(ls -A /app/dist)" && \
    echo "[slion-web] npm run build done, dist ready"

FROM docker.1ms.run/library/nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=5 \
  CMD wget -qO- http://127.0.0.1/ || exit 1
