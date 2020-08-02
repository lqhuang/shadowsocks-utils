FROM alpine:latest

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL Description="Shadowsocks rust with v2ray plugin and privoxy"

ARG SHADOWSOCKS_RUST_VERSION
ARG V2RAY_PLUGIN_VERSION

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV CONFIG_FILE /etc/shadowsocks-libev/config.json
ENV ARGS=

USER root

RUN set -ex \
    && mkdir -p /etc/shadowsocks-libev \
    && apk add --no-cache --virtual .build-deps tar xz

RUN set -ex \
    && apk add --update --no-cache libsodium \
    && wget -cq -O /root/shadowsocks-rust.tar.xz https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SHADOWSOCKS_RUST_VERSION}/shadowsocks-${SHADOWSOCKS_RUST_VERSION}.x86_64-unknown-linux-musl.tar.xz \
    && tar -xvJf /root/shadowsocks-rust.tar.xz -C /usr/local/bin \
    && rm -f /root/shadowsocks-rust.tar.xz

RUN set -ex \
    && wget -cq -O /root/v2ray-plugin.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar -xvzf /root/v2ray-plugin.tar.gz -C /usr/local/bin \
    && mv /usr/local/bin/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && rm -f /root/v2ray-plugin.tar.gz

RUN apk del .build-deps

USER nobody

expose ${SERVER_PORT}/tcp ${SERVER_PORT}/udp

CMD ssserver --server-addr ${SERVER_ADDR}:${SERVER_PORT} -u tcp_and_udp -c ${CONFIG_FILE} ${ARGS}
