# shadowsocks-libev-manager service

Official shadowsocks-libev only contains several systemd service files for `local`, `server`, `redir`, `tunnel`, but `manager`.

Of course, I totally understand why there is no default service for `ss-manager`. `ss-manager` introduce an extra port to lisen for the communication between `ss-manager` and `ss-server`. We have to decide a port while setting default service file, so I guess it's not elegant enough.

Generally, **IT'S TOO DIFFICULT TO DECIDE WHICHT PORT TO USE.** LOL.

## Usage

Copy `ss-manager` service file to the location of systemd unit-files:

    sudo cp shadowsocks-libev-manager@.service /lib/systemd/system/shadowsocks-libev-manager@.service
    sudo systemctl daemon-reload

Enable `shadowsocks-libev-manager` service with your custom configuration located in `/etc/shadowsocks-libev/custom-config.json`:

    sudo systemctl enable shadowsocks-libev-manager@custom-config
    sudo systemctl start shadowsocks-libev-manager@custom-config.service

Check your log:

    systemctl status shadowsocks-libev-manager@custom-config.service

That's all.

Sure, you could definitely use `ss-manager` with `tmux` or `screen` instead of systemd service:

    ss-manager --manager 127.0.0.1:2333 --executable /usr/bin/ss-server -c multi-user.json -u -v
