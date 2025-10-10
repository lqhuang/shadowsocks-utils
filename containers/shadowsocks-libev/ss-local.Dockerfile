ARG SHADOWSOCKS_LIBEV_VERSION
FROM shadowsocks/shadowsocks-libev:${SHADOWSOCKS_LIBEV_VERSION}

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL description="shadowsocks libev with major plugins and privoxy."

ARG V2RAY_PLUGIN_VERSION
ARG QTUN_PLUGIN_VERSION

ENV LOCAL_SERVER 0.0.0.0
ENV LOCAL_PORT 1080
ENV CONFIG_FILE /etc/shadowsocks-libev/config.json

USER root

RUN set -ex \
    && mkdir -p /etc/shadowsocks-libev \
    && apk add -U --no-cache curl privoxy \
    && apk add --no-cache --virtual .build-deps tar xz \
    && sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' /etc/privoxy/config \
    && sed -i -e '/^accept-intercepted-requests/s/0/1/' /etc/privoxy/config \
    && echo 'forward-socks5 / localhost:${LOCAL_PORT} .' >> /etc/privoxy/config

RUN set -ex \
    && wget -cq -O /root/v2ray-plugin.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar -xvzf /root/v2ray-plugin.tar.gz -C /usr/local/bin \
    && mv /usr/local/bin/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && rm -f /root/v2ray-plugin.tar.gz \

RUN set -ex \
    && wget -cq -O /root/qtun-plugin.tar.xz https://github.com/shadowsocks/qtun/releases/download/${QTUN_PLUGIN_VERSION}/qtun-${QTUN_PLUGIN_VERSION}.x86_64-unknown-linux-musl.tar.xz \
    && tar -xvJf /root/qtun-plugin.tar.xz -C /usr/local/bin \
    && rm -f /root/qtun-plugin.tar.xz

RUN apk del .build-deps

EXPOSE ${LOCAL_PORT}/tcp ${LOCAL_PORT}/udp 8118/tcp

USER nobody

HEALTHCHECK --timeout=10s CMD curl -x http://localhost:8118 https://www.google.com/gen_204 || exit 1

# Keep this execution as shell command
# 1. Use shell to combine two services with `&&`.
# 2. Inject ${VAR} as shell variable, so entrypoint needs to be wrapped with `sh`
ENTRYPOINT ["sh", "-c", "privoxy", "/etc/privoxy/config", "&&", "ss-local", "--reuse-port", "--no-delay"]

CMD ["-b", "${LOCAL_SERVER}", "-l", "${LOCAL_PORT}", "-c", "${CONFIG_FILE}"]
