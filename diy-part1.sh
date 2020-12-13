#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# add argon theme
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
rm -rf package/lean/luci-theme-argon && mv luci-theme-argon package/lean/

# add argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git
mv luci-app-argon-config package/lean/

# add vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git
mv lua-maxminddb package/lean/
git clone https://github.com/jerrykuku/luci-app-vssr.git
mv luci-app-vssr package/lean/

# add JD
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git
mv luci-app-jd-dailybonus package/lean/

# add filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-filebrowser package/lean/luci-app-filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/filebrowser package/lean/filebrowser

# add Adguardhome
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-adguardhome package/lean/luci-app-adguardhome
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/AdGuardHome package/lean/AdGuardHome

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# add passwall
sed -i '$a src-git diy1 https://github.com/xiaorouji/openwrt-passwall.git;main' feeds.conf.default

# add diskman
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-diskman package/lean/luci-app-diskman
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/parted package/lean/parted

# add koolproxyR
git clone https://github.com/Beginner-Go/luci-app-koolproxyR
mv luci-app-koolproxyR package/lean/

# Add Mattraks helloworld
#sed -i '$a src-git helloworld https://github.com/Mattraks/helloworld' feeds.conf.default

git clone -b master https://github.com/vernesong/OpenClash.git package/leung/luci-app-openclash  #openclash出国软件
git clone https://github.com/frainzy1477/luci-app-clash.git package/leung/luci-app-clash  #clash出国软件

# Add openclash
# echo "src-git openclash https://github.com/vernesong/OpenClash;master" >> feeds.conf.default

# Add clash
# git clone -b master https://github.com/frainzy1477/luci-app-clash.git package/lean/luci-app-clash
