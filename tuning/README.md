# Shadowsocks Tuning

## Optimize the shadowsocks server on Linux

First of all, upgrade your Linux kernel to 3.5 or later.

### Step 1, increase the maximum number of open file descriptors

To handle thousands of concurrent TCP connections, we should increase the limit
of file descriptors opened.

Edit the `limits.conf`

```shell
vi /etc/security/limits.conf
```

Add these two lines

```plain
* soft nofile 51200
* hard nofile 51200
```

Then, before you start the shadowsocks server, set the `ulimit` first

```shell
ulimit -n 51200
```

### step 2 - Tune the kernel parameters

The priciples of tuning parameters for shadowsocks are

1. Reuse ports and conections as soon as possible.
2. Enlarge the queues and buffers as large as possible.
3. Choose the TCP congestion algorithm for large latency and high throughput.

Here is an example `/etc/sysctl.conf` of our production servers:

```shell
sudo tee -a /etc/sysctl.d/20-ss-tuning.conf << EOF
# fs.file-max = 51200
fs.file-max = 8192

net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 4096

net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_mem = 25600 51200 102400
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_fastopen = 3
EOF
```

Of course, remember to execute `sysctl -p` to reload the config at runtime.

> TFO is enabled for client operations by setting bit 0 (with a value of "1" ).
> Bit 1 (value "2" ) enables TFO for server operations; setting both bits (with
> a value of "3" ) enables both modes.

## Enable TCP BBR

只要 Linux 发行版的 Kernel 即内核版本大于等于 4.9 即可开启，开启方法是通用的。

执行 `lsmod | grep bbr`，以检测 BBR 是否开启。

如果没有结果，则通过 `modprobe` 添加 `tcp_bbr` 选项

```shell
sudo modprobe tcp_bbr
```

或通过配置文件中设置进行加载

```shell
echo "tcp_bbr" | sudo tee -a /etc/modules-load.d/network-bbr.conf
```

通过以下方式确保系统中已经装载 `BBR` 模块

    lsmod | grep bbr

    >> sysctl net.ipv4.tcp_available_congestion_control
    >> net.ipv4.tcp_available_congestion_control = bbr cubic reno

修改系统变量：

```shell
sudo tee -a /etc/sysctl.d/20-network-bbr.conf << EOF
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
EOF
```

About choice of `fq` or
[`fq_codel`](https://www.bufferbloat.net/projects/codel/wiki/):

- `net.core.default_qdisc = fq_codel` - best general purpose qdisc
- `net.core.default_qdisc = fq` - for fat servers, `fq_codel` for routers.

保存生效

    sudo sysctl -p /etc/sysctl.conf.d/20-network-bbr.conf
    # or
    sudo sysctl --system

执行

    >> sysctl net.ipv4.tcp_congestion_control

如果结果是这样

    net.ipv4.tcp_congestion_control = bbr

就开启了。

## Enable TCP ECN

1. [Wikipedia: Explicit Congestion Notification](https://en.wikipedia.org/wiki/Explicit_Congestion_Notification)
2. [Sysctl Explorer: tcp_ecn](https://sysctl-explorer.net/net/ipv4/tcp_ecn)

## Reference

- [networking/ip-sysctl.txt](https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt)
