FROM alpine:latest

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL Description="Shadowsocks rust with v2ray plugin and privoxy"

ARG SHADOWSOCKS_RUST_VERSION
ARG V2RAY_PLUGIN_VERSION

ENV CONFIG_FILE /etc/shadowsocks-libev/config.json
ENV ARGS=

RUN set -ex \
    && mkdir -p /etc/shadowsocks-libev \
    && apk add --no-cache --virtual .build-deps tar xz

RUN apk add -U --no-cache libsodium curl privoxy \
    && sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' /etc/privoxy/config \
    && sed -i -e '/^accept-intercepted-requests/s/0/1/' /etc/privoxy/config \
    && echo 'forward-socks5 / localhost:1080 .' >> /etc/privoxy/config

RUN set -ex \
    && wget -cq -O /root/shadowsocks-rust.tar.xz https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SHADOWSOCKS_RUST_VERSION}/shadowsocks-${SHADOWSOCKS_RUST_VERSION}-stable.x86_64-unknown-linux-musl.tar.xz \
    && tar -xvJf /root/shadowsocks-rust.tar.xz -C /usr/local/bin \
    && rm -f /root/shadowsocks-rust.tar.xz

RUN set -ex \
    && wget -cq -O /root/v2ray-plugin.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar -xvzf /root/v2ray-plugin.tar.gz -C /usr/local/bin \
    && mv /usr/local/bin/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && rm -f /root/v2ray-plugin.tar.gz

RUN apk del .build-deps

expose 1080/tcp 1080/udp 8118/tcp

HEALTHCHECK --timeout=10s CMD curl -x http://localhost:8118 https://www.google.com/gen_204 || exit 1

CMD privoxy /etc/privoxy/config \
    && sslocal --local-addr 0.0.0.0:1080 -u tcp_and_udp -c ${CONFIG_FILE} ${ARGS}
