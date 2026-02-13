rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-argon-mod
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#rm -rf feeds/luci/applications/luci-app-argon-config
#git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/luci/bin/config_generate

sed -i "s/hostname='LEDE'/hostname='OpenWrt'/g" package/base-files/luci/bin/config_generate

sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='LEDE'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

rm -rf feeds/packages/net/curl
git clone https://github.com/sbwml/feeds_packages_net_curl feeds/packages/net/curl

# 修改内核版本
#sed -i 's/KERNEL_PATCHVER:=6.6/KERNEL_PATCHVER:=6.12/g' target/linux/x86/Makefile

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
