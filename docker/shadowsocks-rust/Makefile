
SHADOWSOCKS_RUST_VERSION=v1.11.1
V2RAY_PLUGIN_VERSION=v1.3.1
PROXY=none

all: ss-local-v2ray ss-server-v2ray

ss-local-v2ray:
	docker build \
		-t lqhuang/shadowsocks-rust:ss-local-${SHADOWSOCKS_RUST_VERSION}-v2ray-plugin-${V2RAY_PLUGIN_VERSION} \
		-t lqhuang/shadowsocks-rust:ss-local-v2ray-latest \
		-f ss-local.Dockerfile \
		--build-arg SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		.
		# --build-arg HTTPS_PROXY=${PROXY} \
		# --build-arg HTTP_PROXY=${PROXY} \

ss-server-v2ray:
	docker build \
		-t lqhuang/shadowsocks-rust:ss-server-${SHADOWSOCKS_RUST_VERSION}-v2ray-plugin-${V2RAY_PLUGIN_VERSION} \
		-t lqhuang/shadowsocks-rust:ss-server-v2ray-latest \
		-f ss-server.Dockerfile \
		--build-arg SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		.
		# --build-arg HTTPS_PROXY=${PROXY} \
		# --build-arg HTTP_PROXY=${PROXY} \
