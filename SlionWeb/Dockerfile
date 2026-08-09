# syntax=docker/dockerfile:1
# 容器内 npm 编译前端，无需宿主机安装 Node/pnpm/cnpm
# 使用 Node 22 + bookworm-slim（glibc）+ npmmirror

FROM node:22-bookworm-slim AS build

WORKDIR /app

# 开启安装日志，避免看起来“卡住”；走国内源
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

COPY . .

ARG VUE_APP_SECRET_KEY=preview
ARG VUE_APP_BASE_URL=/prod-api
ARG VUE_APP_CLIENT_ID=e5cd7e4891bf95d1d19206ce24a7b32e
ENV VUE_APP_SECRET_KEY=${VUE_APP_SECRET_KEY} \
    VUE_APP_BASE_URL=${VUE_APP_BASE_URL} \
    VUE_APP_CLIENT_ID=${VUE_APP_CLIENT_ID} \
    NODE_OPTIONS=--max_old_space_size=4096

RUN echo "[slion-web] npm run build start..." && \
    npm run build && \
    echo "[slion-web] npm run build done"

FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=5 \
  CMD wget -qO- http://127.0.0.1/ || exit 1
