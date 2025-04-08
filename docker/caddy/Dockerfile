ARG CADDY_VERSION=2

FROM --platform=$BUILDPLATFORM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN GOOS=$TARGETOS GOARCH=$TARGETARCH xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-webdav \
    --with github.com/mholt/caddy-l4 \
    --with github.com/mholt/caddy-ratelimit \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/imgk/caddy-trojan \
    --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
    # --with github.com/caddy-dns/route53 \

FROM --platform=$TARGETPLATFORM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
