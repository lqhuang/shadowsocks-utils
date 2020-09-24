
SHADOWSOCKS_LIBEV_VERSION=v3.3.5
V2RAY_PLUGIN_VERSION=v1.3.1
PROXY=none


all: ss-local-v2ray ss-server-v2ray

ss-local-v2ray:
	docker build \
		-t lqhuang/shadowsocks-libev:ss-local-${SHADOWSOCKS_LIBEV_VERSION}-v2ray-plugin-${V2RAY_PLUGIN_VERSION} \
		-t lqhuang/shadowsocks-libev:ss-local-v2ray-latest \
		-f ss-local.Dockerfile \
		--build-arg SHADOWSOCKS_LIBEV_VERSION=${SHADOWSOCKS_LIBEV_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		.
		# --build-arg HTTPS_PROXY=${PROXY} \
		# --build-arg HTTP_PROXY=${PROXY} \

ss-server-v2ray:
	docker build \
		-t lqhuang/shadowsocks-libev:ss-server-${SHADOWSOCKS_LIBEV_VERSION}-v2ray-plugin-${V2RAY_PLUGIN_VERSION} \
		-t lqhuang/shadowsocks-libev:ss-server-v2ray-latest \
		-f ss-server.Dockerfile \
		--build-arg SHADOWSOCKS_LIBEV_VERSION=${SHADOWSOCKS_LIBEV_VERSION} \
		--build-arg V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION} \
		.
		# --build-arg HTTPS_PROXY=${PROXY} \
		# --build-arg HTTP_PROXY=${PROXY} \
