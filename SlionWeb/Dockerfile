# syntax=docker/dockerfile:1
# 容器内 pnpm 编译前端，无需宿主机安装 Node/pnpm
FROM node:20-alpine AS build

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@9.15.9 --activate

# 国内 npm 镜像加速
ENV PNPM_HOME=/pnpm
ENV PATH=$PNPM_HOME:$PATH
ENV npm_config_registry=https://registry.npmmirror.com

COPY package.json .npmrc ./
COPY pnpm-lock.yaml* ./
COPY vab-icons ./vab-icons

RUN --mount=type=cache,id=slion-web-pnpm,target=/pnpm/store \
    pnpm config set store-dir /pnpm/store && \
    pnpm install --no-frozen-lockfile

COPY . .

# 授权密钥可通过 build-arg 注入；缺省使用 preview（测试环境）
ARG VUE_APP_SECRET_KEY=preview
ARG VUE_APP_BASE_URL=/prod-api
ARG VUE_APP_CLIENT_ID=e5cd7e4891bf95d1d19206ce24a7b32e
ENV VUE_APP_SECRET_KEY=${VUE_APP_SECRET_KEY} \
    VUE_APP_BASE_URL=${VUE_APP_BASE_URL} \
    VUE_APP_CLIENT_ID=${VUE_APP_CLIENT_ID} \
    NODE_OPTIONS=--max_old_space_size=4096

RUN pnpm run build

# Nginx 托管静态资源并反代后端
FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=5 \
  CMD wget -qO- http://127.0.0.1/ || exit 1
