ARG SHADOWSOCKS_LIBEV_VERSION
FROM shadowsocks/shadowsocks-libev:${SHADOWSOCKS_LIBEV_VERSION}

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL Description="Shadowsocks libev with v2ray plugin and privoxy"

ARG V2RAY_PLUGIN_VERSION

ENV LOCAL_SERVER 0.0.0.0
ENV LOCAL_PORT 1080
ENV CONFIG_FILE /etc/shadowsocks-libev/config.json
ENV ARGS=

USER root

RUN apk add -U --no-cache curl privoxy \
    && sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' /etc/privoxy/config \
    && sed -i -e '/^accept-intercepted-requests/s/0/1/' /etc/privoxy/config \
    && echo 'forward-socks5 / localhost:1080 .' >> /etc/privoxy/config

RUN set -ex \
    && mkdir -p /etc/shadowsocks-libev \
    && apk add --no-cache --virtual .build-deps tar xz \
    && wget -cq -O /root/v2ray-plugin.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar -xvzf /root/v2ray-plugin.tar.gz -C /usr/local/bin \
    && mv /usr/local/bin/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && rm -f /root/v2ray-plugin.tar.gz \
    && apk del .build-deps

expose ${LOCAL_PORT}/tcp ${LOCAL_PORT}/udp 8118/tcp

HEALTHCHECK --timeout=10s CMD curl -x http://localhost:8118 https://www.google.com/gen_204 || exit 1

CMD privoxy /etc/privoxy/config \
    && ss-local -b ${LOCAL_SERVER} --fast-open --reuse-port --no-delay -u -c ${CONFIG_FILE} ${ARGS}
