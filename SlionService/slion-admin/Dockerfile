# syntax=docker/dockerfile:1
# Slion Admin 多阶段构建：容器内 Maven 编译 + JRE 运行
# 注意：docker compose --build 使用的是镜像内的 Maven，不会调用宿主机已安装的 Maven。
#
# 【方式 A】容器内编译（默认，服务器无需本机 Maven）：
#   docker compose -f scripts/docker/docker-compose.slion-prod.yml build slion-admin
#
# 【方式 B】宿主机 Maven 预编译 + 仅打运行时镜像：
#   mvn clean package -Pprod -DskipTests -pl slion-admin -am
#   docker compose -f ... -f docker-compose.slion-prod.host-mvn.yml up -d --build
#
# 本地单独构建（在项目根目录）：
#   docker build -f slion-admin/Dockerfile -t slion/slion-admin:1.0.0 .

# ---------- 阶段 1：Maven 编译 ----------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /build

# 阿里云 Maven 仓库（加速国内依赖拉取）
COPY .mvn/settings.xml /root/.m2/settings.xml

# 复制工程源码（.dockerignore 已排除 target/）
COPY . .

# 生产 profile 打包 slion-admin 及其依赖模块
RUN mvn -B -s /root/.m2/settings.xml clean package -Pprod -DskipTests -pl slion-admin -am

# ---------- 阶段 2：运行时镜像 ----------
FROM bellsoft/liberica-openjdk-rocky:17.0.16-cds

LABEL maintainer="Slion" \
      org.opencontainers.image.title="slion-admin" \
      org.opencontainers.image.description="Slion Service Admin"

RUN mkdir -p /slion/server/logs /slion/server/temp

WORKDIR /slion/server

# 运行时基础默认值；数据库/Redis/Kafka 等连接信息由 docker-compose 环境变量注入
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai \
    JAVA_OPTS="" \
    SPRING_PROFILES_ACTIVE=prod \
    SERVER_PORT=8080 \
    SPRING_SERVLET_MULTIPART_LOCATION=/slion/server/temp

EXPOSE 8080
EXPOSE 9031

COPY --from=builder /build/slion-admin/target/slion-admin.jar ./app.jar

SHELL ["/bin/bash", "-c"]

ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom \
           -XX:+HeapDumpOnOutOfMemoryError -XX:+UseZGC ${JAVA_OPTS} \
           -jar app.jar
