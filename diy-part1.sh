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

# change qBittorrent 4.2.5
sed -i 's/4428ed710cfbcc48e75c4cdb014b803ea3f67311f55f4cba0d148987986bd6c8/1dac52d6fe4b0c44dba04fcfc41f519c57a69cb30580255edca95c87053a4324/g' package/lean/qBittorrent/Makefile
sed -i 's/4.3.1/4.2.5/g' package/lean/qBittorrent/Makefile
sed -i 's/+qt5-core +qt5-network +qt5-sql +qt5-xml +rblibtorrent/+qt5-core +qt5-network +qt5-xml +rblibtorrent/g' package/lean/qBittorrent/Makefile
sed -i 's/1.2.11/1.2.7/g' package/lean/rblibtorrent/Makefile
sed -i 's/PKG_RELEASE=1/PKG_RELEASE=2/g' package/lean/rblibtorrent/Makefile
sed -i 's/471e772cb7038f1bf5f44c32a09eb42fbb80ee99/8e710151c80e655ee0513ca37c367f75a448c6bd/g' package/lean/rblibtorrent/Makefile

# add filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-filebrowser package/lean/luci-app-filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/filebrowser package/lean/filebrowser

# add Adguardhome
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-adguardhome package/lean/luci-app-adguardhome
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/AdGuardHome package/lean/AdGuardHome

# set ARM to aarch64_generic
rm -rf target/linux/armvirt/64/target.mk
wget https://github.com/Mattaclp/NewLEDE/raw/main/aarch64_generic/target.mk
mv target.mk target/linux/armvirt/64/

# change Xray-core
#sed -i 's/PKG_VERSION:=1.1.4/PKG_VERSION:=1.1.5/g' package/lean/xray/Makefile
#sed -i 's/9a44864648f09728507af22c362ff34901c3ad2c51ca254975f0774ff8d52f93/36b6fe0b7908e98d18944f115dabd452812268e5c4c8fe76251120d956cca4a1/g' package/lean/xray/Makefile

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# add passwall
sed -i '$a src-git diy1 https://github.com/xiaorouji/openwrt-passwall.git;main' feeds.conf.default

# add diskman
rm -rf package/lean/luci-app-diskman
rm -rf package/lean/parted
svn co https://github.com/lisaac/luci-app-diskman/trunk/applications/luci-app-diskman package/lean/luci-app-diskman
git clone https://github.com/lisaac/luci-app-diskman.git
mkdir -p package/lean/parted && cp -i luci-app-diskman/Parted.Makefile package/lean/parted/Makefile

# add diskman
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-diskman package/lean/luci-app-diskman
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/parted package/lean/parted

# add koolproxyR
git clone https://github.com/Beginner-Go/luci-app-koolproxyR
mv luci-app-koolproxyR package/lean/

# Add Mattraks helloworld
#sed -i '$a src-git helloworld https://github.com/Mattraks/helloworld' feeds.conf.default

git clone -b master https://github.com/vernesong/OpenClash.git package/lean/luci-app-openclash  #openclash出国软件
git clone https://github.com/frainzy1477/luci-app-clash.git package/lean/luci-app-clash  #clash出国软件

# Add po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd

# Add Beginner-Go packages
#svn co https://github.com/Beginner-Go/my-packages/trunk/luci-app-control-webrestriction package/lean/luci-app-control-webrestriction
#svn co https://github.com/Beginner-Go/my-packages/trunk/luci-app-control-weburl package/lean/luci-app-control-weburl
#svn co https://github.com/Beginner-Go/my-packages/trunk/luci-app-eqos package/lean/luci-app-eqos

# Add openclash
# echo "src-git openclash https://github.com/vernesong/OpenClash;master" >> feeds.conf.default

# Add clash
# git clone -b master https://github.com/frainzy1477/luci-app-clash.git package/lean/luci-app-clash
