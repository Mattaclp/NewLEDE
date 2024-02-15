#!/bin/bash

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

# curl/8.5.0 - fix passwall `time_pretransfer` check
rm -rf feeds/packages/net/curl
git clone https://github.com/sbwml/feeds_packages_net_curl feeds/packages/net/curl

# Disable IPV6 ula prefix
# sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# Check file system during boot
# uci set fstab.@global[0].check_fs=1
# uci commit fstab

exit 0
