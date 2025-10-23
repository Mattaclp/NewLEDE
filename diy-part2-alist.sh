#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='LEDE'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

rm -rf feeds/packages/net/curl
git clone https://github.com/sbwml/feeds_packages_net_curl feeds/packages/net/curl

#rm -rf feeds/packages/net/smartdns feeds/luci/applications/luci-app-smartdns
#git clone --depth=1 -b master https://github.com/pymumu/openwrt-smartdns package/lean/smartdns
#git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns feeds/luci/applications/luci-app-smartdns

rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/dns2tcp
rm -rf feeds/packages/net/dnsproxy
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/trojan
rm -rf feeds/packages/net/v2raya
rm -rf feeds/packages/net/shadowsocks-libev
rm -rf feeds/packages/net/tcping
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/microsocks
rm -rf feeds/packages/net/sing-box
rm -rf feeds/packages/net/xray-core
cp -r feeds/passwall_packages/microsocks feeds/packages/net/
cp -r feeds/passwall_packages/chinadns-ng feeds/packages/net/
cp -r feeds/passwall_packages/dns2socks feeds/packages/net/
cp -r feeds/helloworld/dns2tcp feeds/packages/net/
cp -r feeds/helloworld/dnsproxy feeds/packages/net/
cp -r feeds/helloworld/mosdns feeds/packages/net/
cp -r feeds/helloworld/trojan feeds/packages/net/
cp -r feeds/helloworld/v2raya feeds/packages/net/
cp -r feeds/helloworld/shadowsocks-libev feeds/packages/net/
cp -r feeds/helloworld/tcping feeds/packages/net/
cp -r feeds/passwall_packages/v2ray-geodata feeds/packages/net/
cp -r feeds/passwall_packages/sing-box feeds/packages/net/
cp -r feeds/passwall_packages/xray-core feeds/packages/net/
rm -rf feeds/helloworld/chinadns-ng
cp -r feeds/passwall_packages/chinadns-ng feeds/helloworld/
#rm -rf feeds/helloworld/xray*
#cp -r feeds/passwall_packages/xray* feeds/helloworld/
#rm -rf feeds/passwall_packages/xray-core
#cp -r feeds/helloworld/xray-core feeds/passwall_packages/
rm -rf feeds/helloworld/xray-plugin/
cp -r feeds/passwall_packages/xray-plugin feeds/helloworld/
rm -rf feeds/helloworld/naiveproxy
cp -r feeds/passwall_packages/naiveproxy feeds/helloworld/

rm -rf feeds/helloworld/gn/Makefile
wget https://github.com/Mattaclp/NewLEDE/raw/refs/heads/main/gn/gnMakefile
mv gnMakefile feeds/helloworld/gn/Makefile


#luci-app-alist
rm -rf feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/trunk feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

# Add shadowsocks-rust 1.15.0-alpha.4
#rm -rf package/helloworld/shadowsocks-rust
#svn co  https://github.com/Mattaclp/NewLEDE/trunk/shadowsocks-rust package/helloworld/shadowsocks-rust

# Add NanoHatOLED weather support (tested not work, need to fix)
#rm -rf feeds/NanoHatOLED/nanohatoled/files/NanoHatOLED/bakebit_nanohat_oled.py
#wget -O Zpix.ttf https://github.com/vinewx/NanoHatOLED/raw/weather/nanohatoled/files/NanoHatOLED/Zpix.ttf
#wget -O bakebit_nanohat_oled.py https://github.com/vinewx/NanoHatOLED/raw/weather/nanohatoled/files/NanoHatOLED/bakebit_nanohat_oled.py
#sed -i 's/101010100/101210401/g' bakebit_nanohat_oled.py
#mv Zpix.ttf feeds/NanoHatOLED/nanohatoled/files/NanoHatOLED/
#mv bakebit_nanohat_oled.py feeds/NanoHatOLED/nanohatoled/files/NanoHatOLED/

# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-argon-mod
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# hysteria
rm -rf feeds/helloworld/hysteria
cp -r feeds/passwall_packages/hysteria feeds/helloworld/

# Fix transmission
rm -rf feeds/packages/net/transmission/files/transmission.init
wget https://github.com/Mattaclp/NewLEDE/raw/main/transmission.init
mv transmission.init feeds/packages/net/transmission/files/

rm -rf staging_dir

# Modify Default Theme
#sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/argon' package/lean/default-settings/files/zzz-default-settings

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
#sed -i '/uci commit system/i\uci set system.@system[0].hostname='LEUNG'' package/lean/default-settings/files/zzz-default-settings

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 修改内核版本
#sed -i 's/KERNEL_PATCHVER:=6.12/KERNEL_PATCHVER:=5.15/g' target/linux/x86/Makefile
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=5.10/g' target/linux/x86/Makefile
#sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=6.1/g' target/linux/rockchip/Makefile
