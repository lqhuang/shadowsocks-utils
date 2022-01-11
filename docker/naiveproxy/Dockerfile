FROM alpine:latest

LABEL maintainer="lqhuang <lqhuang@outlook.com>"
LABEL description="naiveproxy"

ARG NAIVEPROXY_VERSION

ENV LOCAL_SERVER 0.0.0.0
ENV LOCAL_PORT 1080
ENV CONFIG_FILE /etc/naiveproxy/config.json

USER root

RUN set -ex \
    && mkdir -p /etc/naiveproxy \
    && apk add -U --no-cache nss \
    && apk add --no-cache --virtual .build-deps tar xz

RUN set -ex \
    && wget -cq -O /root/naiveproxy.tar.xz https://github.com/klzgrad/naiveproxy/releases/download/${NAIVEPROXY_VERSION}/naiveproxy-${NAIVEPROXY_VERSION}-openwrt-x86_64.tar.xz \
    && tar --strip-components=1 -C /usr/local/bin -xvJf /root/naiveproxy.tar.xz \
    && rm -f /root/naiveproxy.tar.xz

RUN apk del .build-deps

EXPOSE ${LOCAL_PORT}/tcp ${LOCAL_PORT}/udp

USER nobody

ENTRYPOINT ["naive"]
