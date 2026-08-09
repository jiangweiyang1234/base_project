#!/usr/bin/env bash
# Slion 一键部署脚本
# 用法：
#   ./deploy/start.sh                 # 生产全栈（postgres + redis + admin + web）
#   ./deploy/start.sh --dev           # 仅开发基础设施
#   ./deploy/start.sh --with-kafka    # 全栈 + Kafka
#   ./deploy/start.sh --skip-web      # 跳过前端构建
#   ./deploy/start.sh --no-build      # 不重新构建镜像（沿用已有）
#   ./deploy/start.sh --host-mvn      # 宿主机 Maven（阿里云仓库）预编译后再构建镜像
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"
ENV_EXAMPLE="${SCRIPT_DIR}/.env.example"
MAVEN_SETTINGS="${ROOT_DIR}/SlionService/.mvn/settings.xml"
COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.yml"
COMPOSE_DEV_FILE="${SCRIPT_DIR}/docker-compose.dev.yml"
COMPOSE_KAFKA_FILE="${SCRIPT_DIR}/docker-compose.kafka.yml"

MODE="prod"
WITH_KAFKA=0
SKIP_WEB=0
NO_BUILD=0
HOST_MVN=0

usage() {
  cat <<'EOF'
用法: ./deploy/start.sh [选项]

选项:
  --dev           仅启动开发基础设施（postgres + redis）
  --with-kafka    生产全栈同时启动 Kafka
  --skip-web      跳过前端 pnpm build（要求已有 SlionWeb/dist）
  --no-build      不执行 docker compose build / 前端构建
  --host-mvn      使用宿主机 Maven + 阿里云仓库预编译（默认走镜像内 Maven）
  -h, --help      显示帮助
EOF
}

log() { echo -e "\033[1;32m[start]\033[0m $*"; }
warn() { echo -e "\033[1;33m[warn]\033[0m $*"; }
err() { echo -e "\033[1;31m[error]\033[0m $*" >&2; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dev) MODE="dev"; shift ;;
    --with-kafka) WITH_KAFKA=1; shift ;;
    --skip-web) SKIP_WEB=1; shift ;;
    --no-build) NO_BUILD=1; shift ;;
    --host-mvn) HOST_MVN=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) err "未知参数: $1"; usage; exit 1 ;;
  esac
done

if ! command -v docker >/dev/null 2>&1; then
  err "未找到 docker，请先安装 Docker"
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  err "未找到 docker compose 插件，请升级 Docker"
  exit 1
fi

if [[ ! -f "${ENV_FILE}" ]]; then
  if [[ -f "${ENV_EXAMPLE}" ]]; then
    cp "${ENV_EXAMPLE}" "${ENV_FILE}"
    warn "已从 .env.example 生成 deploy/.env，请按需修改密钥"
  else
    err "缺少 ${ENV_FILE} 与 ${ENV_EXAMPLE}"
    exit 1
  fi
fi

# shellcheck disable=SC1090
set -a
# 读取端口提示用（允许 .env 中无 export）
# shellcheck source=/dev/null
source "${ENV_FILE}" 2>/dev/null || true
set +a

compose() {
  docker compose --env-file "${ENV_FILE}" "$@"
}

ensure_maven_settings() {
  if [[ ! -f "${MAVEN_SETTINGS}" ]]; then
    err "缺少 Maven 配置: ${MAVEN_SETTINGS}"
    exit 1
  fi
  log "Maven 仓库: https://maven.aliyun.com/repository/public"
}

build_frontend() {
  if [[ "${SKIP_WEB}" -eq 1 ]]; then
    warn "已跳过前端构建"
    return
  fi
  if [[ ! -d "${ROOT_DIR}/SlionWeb" ]]; then
    warn "未找到 SlionWeb，跳过前端构建"
    return
  fi
  if [[ -d "${ROOT_DIR}/SlionWeb/dist" ]] && [[ -n "$(ls -A "${ROOT_DIR}/SlionWeb/dist" 2>/dev/null || true)" ]]; then
    log "检测到已有 SlionWeb/dist，跳过前端构建"
    return
  fi
  if ! command -v pnpm >/dev/null 2>&1; then
    warn "未安装 pnpm 且 dist 不存在，web 容器可能无法提供静态资源"
    return
  fi
  log "构建前端 SlionWeb ..."
  (
    cd "${ROOT_DIR}/SlionWeb"
    pnpm install --frozen-lockfile 2>/dev/null || pnpm install
    pnpm run build
  )
}

host_maven_package() {
  if ! command -v mvn >/dev/null 2>&1; then
    err "指定了 --host-mvn 但未安装 Maven"
    exit 1
  fi
  ensure_maven_settings
  log "使用宿主机 Maven + 阿里云仓库打包 slion-admin ..."
  (
    cd "${ROOT_DIR}/SlionService"
    mvn -B -s "${MAVEN_SETTINGS}" clean package -Pprod -DskipTests -pl slion-admin -am
  )
}

start_dev() {
  log "启动开发基础设施（网络: slion-service-net）..."
  compose -f "${COMPOSE_DEV_FILE}" up -d
  log "开发栈已启动：postgres / redis"
  log "本地后端可连接 localhost:${SLION_PG_HOST_PORT:-5432} / localhost:${SLION_REDIS_HOST_PORT:-6379}"
}

start_prod() {
  ensure_maven_settings
  local files=(-f "${COMPOSE_FILE}")

  if [[ "${NO_BUILD}" -eq 0 ]]; then
    build_frontend
    if [[ "${HOST_MVN}" -eq 1 ]]; then
      host_maven_package
      # 宿主机已产出 jar 时，用 runtime Dockerfile 快速打运行镜像
      log "使用已编译 jar 构建运行时镜像 ..."
      docker build -f "${ROOT_DIR}/SlionService/slion-admin/Dockerfile.runtime" \
        -t slion/slion-admin:1.0.0 \
        "${ROOT_DIR}/SlionService/slion-admin"
      log "启动生产全栈（网络: slion-service-net）..."
      if [[ "${WITH_KAFKA}" -eq 1 ]]; then
        compose "${files[@]}" -f "${COMPOSE_KAFKA_FILE}" up -d
      else
        compose "${files[@]}" up -d
      fi
    else
      log "构建并启动生产全栈（镜像内 Maven + 阿里云仓库，网络: slion-service-net）..."
      if [[ "${WITH_KAFKA}" -eq 1 ]]; then
        # 先起主栈（创建网络），再挂 Kafka
        compose "${files[@]}" up -d --build
        compose "${files[@]}" -f "${COMPOSE_KAFKA_FILE}" up -d
      else
        compose "${files[@]}" up -d --build
      fi
    fi
  else
    log "跳过构建，直接启动生产全栈..."
    if [[ "${WITH_KAFKA}" -eq 1 ]]; then
      compose "${files[@]}" up -d
      compose "${files[@]}" -f "${COMPOSE_KAFKA_FILE}" up -d
    else
      compose "${files[@]}" up -d
    fi
  fi

  log "服务已启动"
  log "  Admin API : http://localhost:${SLION_ADMIN_HOST_PORT:-8080}"
  log "  Web       : http://localhost:${SLION_WEB_HOST_PORT:-80}"
  if [[ "${WITH_KAFKA}" -eq 1 ]]; then
    log "  Kafka     : localhost:${SLION_KAFKA_HOST_PORT:-9092}"
  fi
  log "查看状态: docker compose -f deploy/docker-compose.yml --env-file deploy/.env ps"
}

case "${MODE}" in
  dev) start_dev ;;
  prod) start_prod ;;
  *) err "未知模式: ${MODE}"; exit 1 ;;
esac
