echo "src-git mihomo https://github.com/morytyann/OpenWrt-mihomo.git;main" >> "feeds.conf.default"

# add vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git
mv lua-maxminddb package/lean/
#git clone https://github.com/jerrykuku/luci-app-vssr.git
git clone https://github.com/Mattaclp/luci-app-vssr.git
mv luci-app-vssr package/lean/

