# syntax=docker/dockerfile:1
# 容器内 Maven 编译 + JRE 运行（无需宿主机安装 Maven）
# 依赖阿里云仓库：https://maven.aliyun.com/repository/public
# 需要 BuildKit（start.sh 已开启），二次构建可复用 Maven 缓存

FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /build

# 放到 conf，避免与 /root/.m2/repository 的 cache mount 冲突
COPY .mvn/settings.xml /usr/share/maven/conf/settings.xml

COPY . .

RUN --mount=type=cache,id=slion-m2,target=/root/.m2/repository \
    mvn -B \
      -s /usr/share/maven/conf/settings.xml \
      clean package \
      -Pprod \
      -DskipTests \
      -pl slion-admin -am

FROM bellsoft/liberica-openjdk-rocky:17.0.16-cds

LABEL maintainer="Slion" \
      org.opencontainers.image.title="slion-admin"

# 验证码依赖 AWT 字体；精简 JRE 镜像默认无字体，会导致 /auth/code 失败或超时
RUN set -eux; \
    if command -v microdnf >/dev/null 2>&1; then \
      microdnf install -y fontconfig dejavu-sans-fonts && microdnf clean all; \
    elif command -v dnf >/dev/null 2>&1; then \
      dnf install -y fontconfig dejavu-sans-fonts && dnf clean all; \
    elif command -v yum >/dev/null 2>&1; then \
      yum install -y fontconfig dejavu-sans-fonts && yum clean all; \
    else \
      echo "[WARN] no package manager; captcha may fail without fonts"; \
    fi; \
    mkdir -p /slion/server/logs /slion/server/temp

WORKDIR /slion/server

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai \
    JAVA_OPTS="" \
    JAVA_TOOL_OPTIONS="-Djava.awt.headless=true" \
    SPRING_PROFILES_ACTIVE=prod \
    SERVER_PORT=8080 \
    SPRING_SERVLET_MULTIPART_LOCATION=/slion/server/temp

EXPOSE 8080

COPY --from=builder /build/slion-admin/target/slion-admin.jar ./app.jar

SHELL ["/bin/bash", "-c"]

ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom \
           -Djava.awt.headless=true \
           -XX:+HeapDumpOnOutOfMemoryError -XX:+UseZGC ${JAVA_OPTS} \
           -jar app.jar
