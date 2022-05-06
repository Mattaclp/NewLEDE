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

# Modify Default Theme
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/argon' package/lean/default-settings/files/zzz-default-settings

# change Lean packages
rm -rf feeds/packages/lang/golang
svn co https://github.com/coolsnowwolf/packages/trunk/lang/golang feeds/packages/lang/golang
rm -rf feeds/packages/utils/containerd
svn co https://github.com/coolsnowwolf/packages/trunk/utils/containerd feeds/packages/utils/containerd
rm -rf feeds/packages/utils/libnetwork
svn co https://github.com/coolsnowwolf/packages/trunk/utils/libnetwork feeds/packages/utils/libnetwork
rm -rf feeds/packages/utils/runc
svn co https://github.com/coolsnowwolf/packages/trunk/utils/runc feeds/packages/utils/runc
rm -rf feeds/packages/utils/docker-ce
svn co https://github.com/coolsnowwolf/packages/trunk/utils/docker-ce feeds/packages/utils/docker-ce
rm -rf package/lean/luci-app-docker
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-docker package/lean/luci-app-docker
rm -rf feeds/packages/utils/lvm2
svn co https://github.com/coolsnowwolf/packages/trunk/utils/lvm2 feeds/packages/utils/lvm2
rm -rf package/network/utils/iproute2
svn co https://github.com/coolsnowwolf/lede/trunk/package/network/utils/iproute2 package/network/utils/iproute2

rm -rf feeds/immortalwrtluci/themes/luci-theme-argon*

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
#sed -i '/uci commit system/i\uci set system.@system[0].hostname='LEUNG'' package/lean/default-settings/files/zzz-default-settings

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 修改内核版本
sed -i 's/KERNEL_PATCHVER:=4.19/KERNEL_PATCHVER:=4.14/g' target/linux/sunxi/Makefile
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' target/linux/x86/Makefile
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' target/linux/x86/Makefile
