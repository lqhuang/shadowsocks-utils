
NAIVEPROXY_VERSION=v98.0.4758.80-2
PROXY=none

all: naiveproxy

naiveproxy:
	docker build \
		-t lqhuang/naiveproxy:naiveproxy-${NAIVEPROXY_VERSION} \
		-t lqhuang/naiveproxy:naiveproxy-latest \
		-f Dockerfile \
		--build-arg NAIVEPROXY_VERSION=${NAIVEPROXY_VERSION} \
		.
		# --build-arg HTTPS_PROXY=${PROXY} \
		# --build-arg HTTP_PROXY=${PROXY} \

publish:
	docker push lqhuang/naiveproxy:naiveproxy-${NAIVEPROXY_VERSION}
	docker push lqhuang/naiveproxy:naiveproxy-latest
