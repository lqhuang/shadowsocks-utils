CURR_MKFILE_DIR := $(patsubst %/, %, $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

include ${CURR_MKFILE_DIR}/default.env

TAG := $(subst +,_,${OC_DEV_VERSION})

build:
	docker build \
		--pull \
		-f Containerfile \
		-t ghcr.io/lqhuang/openconnect:${ALPINE_OC_VERSION} \
		-t docker.io/lqhuang/openconnect:${ALPINE_OC_VERSION} \
		--build-arg ALPINE_OC_VERSION=${ALPINE_OC_VERSION} \
		.

build-dev:
	@echo Given `tag` is ${TAG}
	@echo Given `OC_DEV_VERSION` is ${OC_DEV_VERSION}
	docker build \
		--pull \
		-f Containerfile.dev \
		-t ghcr.io/lqhuang/openconnect-dev:${TAG} \
		-t docker.io/lqhuang/openconnect-dev:${TAG} \
		--build-arg OC_DEV_VERSION=${OC_DEV_VERSION} \
		.

# publish:
# 	docker push lqhuang/caddy:${CADDY_VERSION}
# 	docker push ghcr.io/lqhuang/caddy:${CADDY_VERSION}
