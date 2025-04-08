CURR_MKFILE_DIR := $(patsubst %/, %, $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

include ${CURR_MKFILE_DIR}/.env

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
