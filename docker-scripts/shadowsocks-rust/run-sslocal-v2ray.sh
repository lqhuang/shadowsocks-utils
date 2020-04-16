#!/bin/sh

docker run -d \
    --restart always \
    --name sslocal \
    --hostname sslocal \
    -p 8118:8118 \
    -p 1080:1080 \
    -v ${PWD}/config.json:/etc/shadowsocks-libev/config.json \
    -v /dev/urandom:/dev/random \
    lqhuang/shadowsocks-rust:sslocal-v2ray
