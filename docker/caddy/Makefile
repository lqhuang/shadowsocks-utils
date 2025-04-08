CURR_MKFILE_DIR := $(patsubst %/, %, $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

include ${CURR_MKFILE_DIR}/.env

caddy:
	docker build \
		--pull \
		-t lqhuang/caddy:${CADDY_VERSION} \
		-f Dockerfile \
		--build-arg CADDY_VERSION=${CADDY_VERSION} \
		.

publish:
	docker push lqhuang/caddy:${CADDY_VERSION}
