# 移除重复软件包
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-passwall2
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-argon-mod
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#rm -rf feeds/luci/applications/luci-app-argon-config
#git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#rm -rf feeds/packages/net/smartdns feeds/luci/applications/luci-app-smartdns
#git clone --depth=1 -b master https://github.com/pymumu/openwrt-smartdns package/lean/smartdns
#git clone --depth=1 -b master https://github.com/pymumu/luci-app-smartdns feeds/luci/applications/luci-app-smartdns

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/luci2/bin/config_generate

sed -i "s/hostname='LEDE'/hostname='OpenWrt'/g" package/base-files/luci2/bin/config_generate

rm -rf feeds/packages/net/curl
git clone https://github.com/sbwml/feeds_packages_net_curl feeds/packages/net/curl

# 修改内核版本
#sed -i 's/KERNEL_PATCHVER:=6.6/KERNEL_PATCHVER:=6.12/g' target/linux/x86/Makefile

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

rm -rf feeds/helloworld/hysteria
cp -r feeds/passwall_packages/hysteria feeds/helloworld/

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../
  cd .. && rm -rf $repodir
}

git_sparse_clone dev https://github.com/vernesong/OpenClash luci-app-openclash
cp -rf luci-app-openclash package

mkdir bin
mkdir bin/packages
cp -r package/luci-app-openclash bin/packages/
zip -r luci-app-openclash.zip bin/packages/luci-app-openclash
cp -r luci-app-openclash.zip bin/packages/luci-app-openclash.zip
