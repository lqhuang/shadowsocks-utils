FROM alpine:latest

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL description="shadowsocks rust with major plugins"

ARG SHADOWSOCKS_RUST_VERSION
ARG V2RAY_PLUGIN_VERSION
ARG QTUN_PLUGIN_VERSION

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV CONFIG_FILE /etc/shadowsocks-rust/config.json

USER root

RUN set -ex \
    && mkdir -p /etc/shadowsocks-rust \
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

USER nobody

EXPOSE ${SERVER_PORT}/tcp ${SERVER_PORT}/udp

ENTRYPOINT ["ssserver", "--tcp-no-delay"]

CMD ["--server-addr", "${SERVER_ADDR}:${SERVER_PORT}", "-c", "${CONFIG_FILE}"]
