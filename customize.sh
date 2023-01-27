git clone https://github.com/sbwml/luci-app-alist.git package/luci-app-alist
rm -rf feeds/packages/lang/golang
svn export https://github.com/sbwml/packages_lang_golang/trunk feeds/packages/lang/golang
