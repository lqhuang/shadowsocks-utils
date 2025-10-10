CURR_MKFILE_DIR := $(patsubst %/, %, $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

include ${CURR_MKFILE_DIR}/.env

build:
	docker build \
		--pull \
		-t ghcr.io/lqhuang/caddy:${CADDY_VERSION} \
		-t lqhuang/caddy:${CADDY_VERSION} \
		-f Dockerfile \
		--build-arg CADDY_VERSION=${CADDY_VERSION} \
		.

publish:
	docker push lqhuang/caddy:${CADDY_VERSION}
	docker push ghcr.io/lqhuang/caddy:${CADDY_VERSION}
