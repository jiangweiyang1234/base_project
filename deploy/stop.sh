#!/usr/bin/env bash
# 停止并移除部署容器（默认保留数据卷）
# 用法：
#   ./deploy/stop.sh
#   ./deploy/stop.sh --dev
#   ./deploy/stop.sh --with-kafka
#   ./deploy/stop.sh --volumes
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

COMPOSE_FILE="docker-compose.yml"
COMPOSE_DEV_FILE="docker-compose.dev.yml"
COMPOSE_KAFKA_FILE="docker-compose.kafka.yml"
ENV_FILE=".env"

MODE="prod"
WITH_KAFKA=0
REMOVE_VOLUMES=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dev) MODE="dev"; shift ;;
    --with-kafka) WITH_KAFKA=1; shift ;;
    --volumes|-v) REMOVE_VOLUMES=1; shift ;;
    -h|--help)
      echo "用法: ./stop.sh [--dev] [--with-kafka] [--volumes]"
      exit 0
      ;;
    *) echo "[ERROR] 未知参数: $1"; exit 1 ;;
  esac
done

if [[ ! -f "$ENV_FILE" ]]; then
  ENV_FILE=".env.example"
fi

DOWN_ARGS=(down)
if [[ "$REMOVE_VOLUMES" -eq 1 ]]; then
  echo "[WARN] 将同时删除数据卷（数据库/Redis 数据会清空）"
  DOWN_ARGS+=(-v)
fi

if [[ "$MODE" == "dev" ]]; then
  echo "[INFO] 停止开发基础设施..."
  docker compose -f "$COMPOSE_DEV_FILE" --env-file "$ENV_FILE" "${DOWN_ARGS[@]}"
else
  echo "[INFO] 停止 Slion 环境..."
  if [[ "$WITH_KAFKA" -eq 1 ]]; then
    docker compose -f "$COMPOSE_FILE" -f "$COMPOSE_KAFKA_FILE" --env-file "$ENV_FILE" "${DOWN_ARGS[@]}" || true
  fi
  docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" "${DOWN_ARGS[@]}"
fi

if [[ "$REMOVE_VOLUMES" -ne 1 ]]; then
  echo "[INFO] 数据卷已保留。如需清空数据请执行：./stop.sh --volumes"
fi

echo "[OK] 已停止。"
