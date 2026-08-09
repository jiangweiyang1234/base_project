# syntax=docker/dockerfile:1
# 容器内 npm 编译前端（与 SlionEhr 一致），无需宿主机安装 Node/pnpm/cnpm
#
# 使用 bookworm-slim（glibc），避免 alpine/musl 下 imagemin 原生包问题。
# 依赖走 npmmirror 国内源，加速安装。

FROM node:20-bookworm-slim AS build

WORKDIR /app

# node 官方 slim 已含 ca-certificates，不再 apt-get

ENV npm_config_registry=https://registry.npmmirror.com \
    npm_config_fund=false \
    npm_config_audit=false \
    npm_config_progress=false \
    npm_config_build_from_source=false

COPY package.json .npmrc ./
COPY vab-icons ./vab-icons

# 使用 npm + 国内镜像；缓存挂载加速二次构建
RUN --mount=type=cache,id=slion-web-npm,target=/root/.npm \
    npm install --registry=https://registry.npmmirror.com

COPY . .

ARG VUE_APP_SECRET_KEY=preview
ARG VUE_APP_BASE_URL=/prod-api
ARG VUE_APP_CLIENT_ID=e5cd7e4891bf95d1d19206ce24a7b32e
ENV VUE_APP_SECRET_KEY=${VUE_APP_SECRET_KEY} \
    VUE_APP_BASE_URL=${VUE_APP_BASE_URL} \
    VUE_APP_CLIENT_ID=${VUE_APP_CLIENT_ID} \
    NODE_OPTIONS=--max_old_space_size=4096

RUN npm run build

FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=5 \
  CMD wget -qO- http://127.0.0.1/ || exit 1
