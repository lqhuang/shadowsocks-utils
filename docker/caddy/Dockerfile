ARG CADDY_VERSION=2

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN echo "Check env: CADDY_VERSION=${CADDY_VERSION}" && \
    GOARCH=$TARGETARCH xcaddy build ${CADDY_VERSION} \
    --with github.com/mholt/caddy-webdav \
    --with github.com/mholt/caddy-l4 \
    --with github.com/mholt/caddy-ratelimit \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
