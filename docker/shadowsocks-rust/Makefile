
SHADOWSOCKS_RUST_VERSION=v1.8.10
V2RAY_PLUGIN_VERSION=v1.3.0
PROXY=none

ss-local-v2ray:
	docker build \
		-t lqhuang/shadowsocks-rust:sslocal-${SHADOWSOCKS_RUST_VERSION}-v2ray-plugin-${V2RAY_PLUGIN_VERSION} \
		-t lqhuang/shadowsocks-rust:sslocal-v2ray-latest \
		-f ss-local.Dockerfile \
		--build-arg SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		.
		# --build-arg HTTPS_PROXY=${PROXY} \
		# --build-arg HTTP_PROXY=${PROXY} \

ss-server-v2ray:
	docker build \
		-t lqhuang/shadowsocks-rust:ssserver-${SHADOWSOCKS_RUST_VERSION}-v2ray-plugin-${V2RAY_PLUGIN_VERSION} \
		-t lqhuang/shadowsocks-rust:ssserver-v2ray-latest \
		-f ss-server.Dockerfile \
		--build-arg SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		.
		# --build-arg HTTPS_PROXY=${PROXY} \
		# --build-arg HTTP_PROXY=${PROXY} \
