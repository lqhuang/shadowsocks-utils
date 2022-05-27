RELEASE_VERSION=2022.05.22
SHADOWSOCKS_RUST_VERSION=v1.14.0
V2RAY_PLUGIN_VERSION=v1.3.1
QTUN_PLUGIN_VERSION=v0.2.0


all: ss-local ss-server

ss-local:
	docker build \
		--pull \
		-t lqhuang/shadowsocks-rust:ss-local-${RELEASE_VERSION} \
		-t lqhuang/shadowsocks-rust:ss-local-latest \
		-f ss-local.Dockerfile \
		--build-arg SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		--build-arg QTUN_PLUGIN_VERSION=${QTUN_PLUGIN_VERSION} \
		.

ss-server:
	docker build \
		--pull \
		-t lqhuang/shadowsocks-rust:ss-server-${RELEASE_VERSION} \
		-t lqhuang/shadowsocks-rust:ss-server-latest \
		-f ss-server.Dockerfile \
		--build-arg SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		--build-arg QTUN_PLUGIN_VERSION=${QTUN_PLUGIN_VERSION} \
		.

publish:
	docker push lqhuang/shadowsocks-rust:ss-server-${RELEASE_VERSION}
	docker push lqhuang/shadowsocks-rust:ss-local-${RELEASE_VERSION}
	docker push lqhuang/shadowsocks-rust:ss-server-latest
	docker push lqhuang/shadowsocks-rust:ss-local-latest
