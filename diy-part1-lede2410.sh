#git checkout 874fee50ebb86b7acea5b57e2ba794a9897b6355

sed -i '$a src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' feeds.conf.default
#sed -i '$a src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main' feeds.conf.default
sed -i '$a src-git helloworld https://github.com/fw876/helloworld.git;master' feeds.conf.default
sed -i '$a src-git momo https://github.com/nikkinikki-org/OpenWrt-momo.git;main' feeds.conf.default
#sed -i '$a src-git mihomo https://github.com/nikkinikki-org/OpenWrt-nikki.git;main' feeds.conf.default

# add vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git
#mv lua-maxminddb package/lean/
#git clone https://github.com/jerrykuku/luci-app-vssr.git
#git clone https://github.com/Mattaclp/luci-app-vssr.git
#mv luci-app-vssr package/lean/
# add luci-app-amlogic
#git clone https://github.com/ophub/luci-app-amlogic.git  package-temp/luci-app-amlogic
#mv -f package-temp/luci-app-amlogic/luci-app-amlogic package/lean/
#rm -rf package-temp
