ARG SHADOWSOCKS_LIBEV_VERSION
FROM shadowsocks/shadowsocks-libev:${SHADOWSOCKS_LIBEV_VERSION}

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL Description="Shadowsocks rust with v2ray plugin and privoxy"

ARG V2RAY_PLUGIN_VERSION

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV CONFIG_FILE /etc/shadowsocks-libev/config.json
ENV ARGS=

USER root

RUN set -ex \
    && mkdir -p /etc/shadowsocks-libev \
    && apk add --no-cache --virtual .build-deps tar xz \
    && wget -cq -O /root/v2ray-plugin.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar -xvzf /root/v2ray-plugin.tar.gz -C /usr/local/bin \
    && mv /usr/local/bin/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && rm -f /root/v2ray-plugin.tar.gz \
    && apk del .build-deps

USER nobody

expose ${SERVER_PORT}/tcp ${SERVER_PORT}/udp

CMD ssserver -b ${SERVER_ADDR} --fast-open --reuse-port --no-delay -u -c ${CONFIG_FILE} ${ARGS}
