CADDY_VERSION=2.8.4

caddy:
	docker build \
		--pull \
		-t lqhuang/caddy:caddy-${CADDY_VERSION} \
		-t lqhuang/caddy:caddy-latest \
		-f Dockerfile \
		--build-arg CADDY_VERSION=${CADDY_VERSION} \
		.

publish:
	docker push lqhuang/caddy:caddy-${CADDY_VERSION}
	docker push lqhuang/caddy:caddy-latest
