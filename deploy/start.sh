#!/usr/bin/env bash
# Slion 测试/生产一键部署：在 Docker 内完成 Maven/pnpm 编译并启动全部服务
# 宿主机只需安装 Docker（无需 Maven / Node / pnpm）
#
# 用法：
#   ./deploy/start.sh
#   ./deploy/start.sh --with-kafka
#   ./deploy/start.sh --dev          # 仅 postgres + redis
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

COMPOSE_FILE="docker-compose.yml"
COMPOSE_DEV_FILE="docker-compose.dev.yml"
COMPOSE_KAFKA_FILE="docker-compose.kafka.yml"
ENV_FILE=".env"

MODE="prod"
WITH_KAFKA=0
EXTRA_ARGS=()

usage() {
  cat <<'EOF'
用法: ./deploy/start.sh [选项] [-- compose额外参数]

选项:
  --dev           仅启动开发基础设施（postgres + redis）
  --with-kafka    生产全栈同时启动 Kafka
  -h, --help      显示帮助

说明:
  后端在镜像内用 Maven（阿里云仓库）编译，前端在镜像内用 npm（npmmirror）编译。
  宿主机不需要安装 Maven / Node / pnpm / cnpm。
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dev) MODE="dev"; shift ;;
    --with-kafka) WITH_KAFKA=1; shift ;;
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
  echo "[INFO] 未找到 .env，从 .env.example 复制..."
  cp .env.example .env
fi

# 勿 source .env（docker-compose 环境文件含空格值时会当命令执行）
# 仅安全读取展示用端口
env_get() {
  local key="$1" default="$2" line value
  line="$(grep -E "^${key}=" "$ENV_FILE" 2>/dev/null | tail -n1 || true)"
  if [[ -z "$line" ]]; then
    printf '%s' "$default"
    return
  fi
  value="${line#*=}"
  value="${value%\"}"
  value="${value#\"}"
  value="${value%\'}"
  value="${value#\'}"
  printf '%s' "${value:-$default}"
}

WEB_PORT="$(env_get SLION_WEB_HOST_PORT 280)"
API_PORT="$(env_get SLION_ADMIN_HOST_PORT 28080)"

# set -u 下空数组展开会报 unbound variable，用兼容写法

run_compose() {
  # 将额外参数按原样追加；无额外参数时不展开空数组
  if ((${#EXTRA_ARGS[@]} > 0)); then
    docker compose "$@" "${EXTRA_ARGS[@]}"
  else
    docker compose "$@"
  fi
}

# 启用 BuildKit，使 Dockerfile 中 Maven/pnpm cache mount 生效
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

if [[ "$MODE" == "dev" ]]; then
  echo "=========================================="
  echo " Slion 开发基础设施部署"
  echo " Compose : $COMPOSE_DEV_FILE"
  echo " Network : slion-service-net"
  echo "=========================================="
  run_compose -f "$COMPOSE_DEV_FILE" --env-file "$ENV_FILE" up -d
  echo
  echo "[OK] 开发栈已启动（postgres / redis）。"
  exit 0
fi

echo "=========================================="
echo " Slion 环境部署（Docker 内编译）"
echo " Compose : $COMPOSE_FILE"
echo " Network : slion-service-net"
echo " Web     : http://<服务器IP>:${WEB_PORT}"
echo " API     : http://<服务器IP>:${API_PORT}"
echo " Maven   : https://maven.aliyun.com/repository/public"
echo "=========================================="

echo "[INFO] 拉取/构建并启动全部服务（首次需下载依赖，之后会走构建缓存）..."
if [[ "$WITH_KAFKA" -eq 1 ]]; then
  run_compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d --build
  docker compose -f "$COMPOSE_FILE" -f "$COMPOSE_KAFKA_FILE" --env-file "$ENV_FILE" up -d
else
  run_compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d --build
fi

echo
echo "[INFO] 当前容器状态："
docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" ps

echo
echo "[OK] 部署完成。"
echo "     Web  : http://<服务器IP>:${WEB_PORT}"
echo "     API  : http://<服务器IP>:${API_PORT}"
echo "     停止服务：./stop.sh"
echo "     查看日志：docker compose -f docker-compose.yml --env-file .env logs -f"
