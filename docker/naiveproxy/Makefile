NAIVEPROXY_VERSION=v101.0.4951.41-1

naiveproxy:
	docker build \
		--pull \
		-t lqhuang/naiveproxy:naiveproxy-${NAIVEPROXY_VERSION} \
		-t lqhuang/naiveproxy:naiveproxy-latest \
		-f Dockerfile \
		--build-arg NAIVEPROXY_VERSION=${NAIVEPROXY_VERSION} \
		.

publish
	docker push lqhuang/naiveproxy:naiveproxy-${NAIVEPROXY_VERSION}
	docker push lqhuang/naiveproxy:naiveproxy-latest
