# Privxoy config for proxy forward

Wiki: https://wiki.archlinux.org/index.php/Privoxy


## Generate gfwlist.action file for privoxy

`bash gfwlist2privoxy.sh 127.0.0.1:1080`，注意将 `127.0.0.1:1080` 替换为为所要求的 socks5 地址

`echo 'actionsfile gfwlist.action' >> /etc/privoxy/config`，应用 `gfwlist.action` 配置文件
