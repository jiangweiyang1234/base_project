#!/usr/bin/env bash
# 查看 API（slion-admin）容器日志
# 用法：
#   ./deploy/log.sh
#   ./deploy/log.sh -n 300
#   ./deploy/log.sh --tail 500 --no-follow
#   ./deploy/log.sh --since 10m
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

COMPOSE_FILE="docker-compose.yml"
ENV_FILE=".env"
SERVICE="slion-admin"
TAIL_LINES=200
FOLLOW=1
SINCE=""
EXTRA_ARGS=()

usage() {
  cat <<'EOF'
用法: ./deploy/log.sh [选项]

选项:
  -n, --tail <N>   显示最近 N 行（默认 200）
  --no-follow      只打印一次，不持续跟踪
  --since <时间>   仅显示某时间之后的日志，如 10m / 1h / 2026-01-01T00:00:00
  -h, --help       显示帮助

说明:
  默认跟踪 API 容器 slion-admin 的标准输出日志（Ctrl+C 退出）。
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--tail)
      TAIL_LINES="${2:-}"
      if [[ -z "$TAIL_LINES" ]]; then
        echo "[ERROR] --tail 需要指定行数"
        exit 1
      fi
      shift 2
      ;;
    --no-follow) FOLLOW=0; shift ;;
    --since)
      SINCE="${2:-}"
      if [[ -z "$SINCE" ]]; then
        echo "[ERROR] --since 需要指定时间"
        exit 1
      fi
      shift 2
      ;;
    -h|--help) usage; exit 0 ;;
    --) shift; EXTRA_ARGS+=("$@"); break ;;
    *) EXTRA_ARGS+=("$1"); shift ;;
  esac
done

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] 未找到 docker，请先安装 Docker。"
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "[ERROR] 未找到 docker compose 插件，请升级 Docker。"
  exit 1
fi

if [[ ! -f "$ENV_FILE" ]]; then
  ENV_FILE=".env.example"
fi

LOG_ARGS=(logs --tail "$TAIL_LINES")
if [[ "$FOLLOW" -eq 1 ]]; then
  LOG_ARGS+=(-f)
fi
if [[ -n "$SINCE" ]]; then
  LOG_ARGS+=(--since "$SINCE")
fi

echo "[INFO] 查看 API 日志（服务: ${SERVICE}）..."
if ((${#EXTRA_ARGS[@]} > 0)); then
  docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" "${LOG_ARGS[@]}" "$SERVICE" "${EXTRA_ARGS[@]}"
else
  docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" "${LOG_ARGS[@]}" "$SERVICE"
fi
