#!/usr/bin/env bash
# 启动前修复 bind mount 数据目录权限，再交给 apache/kafka 官方入口脚本。
# apache/kafka 镜像内进程默认以 UID/GID 1000 (appuser) 运行。
set -euo pipefail

KAFKA_DATA_DIR="${KAFKA_LOG_DIRS:-/var/lib/kafka/data}"

mkdir -p "${KAFKA_DATA_DIR}"

if [[ "$(id -u)" -eq 0 ]]; then
  chown -R 1000:1000 "${KAFKA_DATA_DIR}"
  chmod 755 "${KAFKA_DATA_DIR}"
  if command -v runuser >/dev/null 2>&1; then
    exec runuser -u 1000 -- /etc/kafka/docker/run "$@"
  fi
  if command -v gosu >/dev/null 2>&1; then
    exec gosu 1000:1000 /etc/kafka/docker/run "$@"
  fi
  exec su -s /bin/bash appuser -c 'exec /etc/kafka/docker/run'
fi

exec /etc/kafka/docker/run "$@"
