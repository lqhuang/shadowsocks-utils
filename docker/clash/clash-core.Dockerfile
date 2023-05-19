ARG YACD_VERSION
ARG CLASH_CORE_VERSION

FROM haishanh/yacd:${YACD_VERSION} AS ui

FROM dreamacro/clash:${CLASH_CORE_VERSION}

COPY --from=ui /usr/share/nginx/html /root/.config/clash/ui
