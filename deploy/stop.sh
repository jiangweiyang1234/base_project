#!/usr/bin/env bash
# Slion 一键关闭脚本
# 用法：
#   ./deploy/stop.sh                 # 关闭生产全栈
#   ./deploy/stop.sh --dev           # 关闭开发基础设施
#   ./deploy/stop.sh --with-kafka    # 关闭含 Kafka 的生产栈
#   ./deploy/stop.sh --all           # 关闭生产 + 开发栈
#   ./deploy/stop.sh --volumes       # 同时删除数据卷（危险）
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"
ENV_EXAMPLE="${SCRIPT_DIR}/.env.example"
COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.yml"
COMPOSE_DEV_FILE="${SCRIPT_DIR}/docker-compose.dev.yml"
COMPOSE_KAFKA_FILE="${SCRIPT_DIR}/docker-compose.kafka.yml"

MODE="prod"
WITH_KAFKA=0
REMOVE_VOLUMES=0
STOP_ALL=0

usage() {
  cat <<'EOF'
用法: ./deploy/stop.sh [选项]

选项:
  --dev           关闭开发基础设施
  --with-kafka    关闭含 Kafka 覆盖文件的生产栈
  --all           关闭生产栈与开发栈
  --volumes       同时删除匿名/命名数据卷（会清空数据库等，谨慎）
  -h, --help      显示帮助
EOF
}

log() { echo -e "\033[1;32m[stop]\033[0m $*"; }
warn() { echo -e "\033[1;33m[warn]\033[0m $*"; }
err() { echo -e "\033[1;31m[error]\033[0m $*" >&2; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dev) MODE="dev"; shift ;;
    --with-kafka) WITH_KAFKA=1; shift ;;
    --all) STOP_ALL=1; shift ;;
    --volumes) REMOVE_VOLUMES=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) err "未知参数: $1"; usage; exit 1 ;;
  esac
done

if ! command -v docker >/dev/null 2>&1; then
  err "未找到 docker"
  exit 1
fi

if [[ ! -f "${ENV_FILE}" ]]; then
  if [[ -f "${ENV_EXAMPLE}" ]]; then
    ENV_FILE="${ENV_EXAMPLE}"
    warn "未找到 deploy/.env，改用 .env.example 仅用于 compose 解析"
  else
    err "缺少环境文件"
    exit 1
  fi
fi

compose() {
  docker compose --env-file "${ENV_FILE}" "$@"
}

down_args=(down)
if [[ "${REMOVE_VOLUMES}" -eq 1 ]]; then
  down_args+=(--volumes)
  warn "将删除数据卷，数据库/Redis 数据会被清空"
fi

stop_prod() {
  local files=(-f "${COMPOSE_FILE}")
  if [[ "${WITH_KAFKA}" -eq 1 ]]; then
    files+=(-f "${COMPOSE_KAFKA_FILE}")
  fi
  log "关闭生产栈..."
  compose "${files[@]}" "${down_args[@]}"
}

stop_dev() {
  log "关闭开发基础设施..."
  compose -f "${COMPOSE_DEV_FILE}" "${down_args[@]}"
}

if [[ "${STOP_ALL}" -eq 1 ]]; then
  stop_prod || true
  # 生产若曾带 kafka 再尝试带覆盖文件关闭一次，避免残留
  compose -f "${COMPOSE_FILE}" -f "${COMPOSE_KAFKA_FILE}" "${down_args[@]}" 2>/dev/null || true
  stop_dev || true
else
  case "${MODE}" in
    dev) stop_dev ;;
    prod) stop_prod ;;
    *) err "未知模式: ${MODE}"; exit 1 ;;
  esac
fi

log "服务已关闭（网络名: slion-service-net）"
log "查看残留容器: docker ps -a --filter name=slion-"
