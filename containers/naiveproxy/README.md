# Dockerfile for naiveproxy

## Common issues

Notice info: release build `naiveproxy-${VERSION}-linux-x64.tar.xz` can not run
under `alpine`, This build is compiled under `glibc`.
`naiveproxy-${VERSION}-openwrt-x86_64.tar.xz` is more suitable for `alpine`,
which `openwrt` and `alpine` are all compatible for `musl`. Also, dependency lib
`nss` and `libgcc` are must required, so try to install them manually with
`apk`.

> OpenWrt uses a different `libc` from Ubuntu (`musl`). The error means s
> working ELF interpreter is not found. The `-linux-x64` builds are built for
> Ubuntus, not OpenWrt.
>
> - https://github.com/klzgrad/naiveproxy/issues/37
> - https://github.com/klzgrad/naiveproxy/issues/50

## References

1. [Github - klzgrad/naiveproxy](https://github.com/klzgrad/naiveproxy)
