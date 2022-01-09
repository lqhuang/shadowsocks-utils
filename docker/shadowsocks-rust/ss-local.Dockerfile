FROM alpine:latest

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL description="shadowsocks rust with major plugins"

ARG SHADOWSOCKS_RUST_VERSION
ARG V2RAY_PLUGIN_VERSION
ARG QTUN_PLUGIN_VERSION

ENV LOCAL_SERVER 0.0.0.0
ENV LOCAL_PORT 1080
ENV CONFIG_FILE /etc/shadowsocks-rust/config.json

USER root

RUN set -ex \
    && mkdir -p /etc/shadowsocks-rust \
    && apk add -U --no-cache curl \
    && apk add --no-cache --virtual .build-deps tar xz

RUN set -ex \
    && wget -cq -O /root/shadowsocks-rust.tar.xz https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SHADOWSOCKS_RUST_VERSION}/shadowsocks-${SHADOWSOCKS_RUST_VERSION}.x86_64-unknown-linux-musl.tar.xz \
    && tar -xvJf /root/shadowsocks-rust.tar.xz -C /usr/local/bin \
    && rm -f /root/shadowsocks-rust.tar.xz

RUN set -ex \
    && wget -cq -O /root/v2ray-plugin.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar -xvzf /root/v2ray-plugin.tar.gz -C /usr/local/bin \
    && mv /usr/local/bin/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && rm -f /root/v2ray-plugin.tar.gz

RUN set -ex \
    && wget -cq -O /root/qtun-plugin.tar.xz https://github.com/shadowsocks/qtun/releases/download/${QTUN_PLUGIN_VERSION}/qtun-${QTUN_PLUGIN_VERSION}.x86_64-unknown-linux-musl.tar.xz \
    && tar -xvJf /root/qtun-plugin.tar.xz -C /usr/local/bin \
    && rm -f /root/qtun-plugin.tar.xz

RUN apk del .build-deps

EXPOSE ${LOCAL_PORT}/tcp ${LOCAL_PORT}/udp

USER nobody

HEALTHCHECK --timeout=10s CMD curl -x http://localhost:${LOCAL_PORT} https://www.google.com/gen_204 || exit 1

# Inject ${VAR} as shell variable, so entrypoint needs to be wrapped with `sh`
ENTRYPOINT ["sh -c", "sslocal", "--tcp-no-delay"]

CMD ["--local-addr", "${LOCAL_SERVER}:${LOCAL_PORT}", "-c", "${CONFIG_FILE}"]
