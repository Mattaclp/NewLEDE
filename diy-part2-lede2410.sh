# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-argon-mod
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#rm -rf feeds/luci/applications/luci-app-argon-config
#git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
rm -rf feeds/packages/net/smartdns feeds/luci/applications/luci-app-smartdns
git clone --depth=1 -b master https://github.com/pymumu/openwrt-smartdns package/lean/smartdns
git clone --depth=1 -b master https://github.com/pymumu/luci-app-smartdns package/lean/luci-app-smartdns

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate

sed -i "s/hostname='LEDE'/hostname='OpenWrt'/g" ./package/base-files/files/bin/config_generate
