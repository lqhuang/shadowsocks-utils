
NAIVEPROXY_VERSION=v99.0.4844.51-1
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
