NAIVEPROXY_VERSION=v101.0.4951.41-1
CADDY_VERSION=2.5.1

all: naiveproxy caddy

naiveproxy:
	docker build \
		--pull \
		-t lqhuang/naiveproxy:naiveproxy-${NAIVEPROXY_VERSION} \
		-t lqhuang/naiveproxy:naiveproxy-latest \
		-f Dockerfile \
		--build-arg NAIVEPROXY_VERSION=${NAIVEPROXY_VERSION} \
		.

caddy:
	docker build \
		--pull \
		-t lqhuang/naiveproxy:caddy-forwardproxy-${CADDY_VERSION} \
		-t lqhuang/naiveproxy:caddy-forwardproxy-latest \
		-f Dockerfile.caddy \
		--build-arg CADDY_VERSION=${CADDY_VERSION} \
		.

publish: publish-naiveproxy publish-caddy

publish-naiveproxy:
	docker push lqhuang/naiveproxy:naiveproxy-${NAIVEPROXY_VERSION}
	docker push lqhuang/naiveproxy:naiveproxy-latest

publish-caddy:
	docker push lqhuang/naiveproxy:caddy-forwardproxy-${CADDY_VERSION}
	docker push lqhuang/naiveproxy:caddy-forwardproxy-latest
