include $(TOPDIR)/rules.mk

PKG_NAME:=xray-core
PKG_VERSION:=1.3.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/XTLS/Xray-core/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=5b860144c470c3f7c6b71ffdf0c3830980f1f6ce431fbe6bf10249c1f0e991a7

#PKG_SOURCE_URL:=https://github.com/XTLS/xray-core.git
#PKG_MIRROR_HASH:=19f3017d8279acc28d242d18689b95a39ca00a286e72329552d114f04a861ecb
#PKG_SOURCE_VERSION:=c345d4818efa763b07961d6c132afe1cf91845de
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=
PKG_LICENSE:=MPL-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_CONFIG_DEPENDS:= \
	CONFIG_XRAY_CORE_PROVIDE_V2RAY_CORE \
	CONFIG_XRAY_CORE_COMPRESS_GOPROXY \
	CONFIG_XRAY_CORE_COMPRESS_UPX \

PKG_BUILD_DIR:=$(BUILD_DIR)/xray-core-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/xtls/xray-core
GO_PKG_BUILD_PKG:=github.com/xtls/xray-core/main
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:= \
	$(GO_PKG)/core.build=OpenWrt \
	$(GO_PKG)/core.version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/xray/template
  TITLE:=A platform for building proxies to bypass network restrictions
  SECTION:=net
  CATEGORY:=Network
  URL:=https://xtls.github.io
endef

define Package/xray-core
  $(call Package/xray/template)
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
  PROVIDES:=v2ray-core
endef

define Package/xray-example
  $(call Package/xray/template)
  TITLE+= (example configs)
  DEPENDS:=xray-core
  PKGARCH:=all
endef

define Package/xray-geodata
  $(call Package/xray/template)
  TITLE+= (geodata files)
  DEPENDS:=xray-core
  PKGARCH:=all
endef

define Package/xray/description
  Xray, Penetrates Everything. Also the best v2ray-core, with XTLS support. Fully compatible configuration.
  It secures your network connections and thus protects your privacy.
endef

define Package/xray-core/description
  $(call Package/xray/description)
endef

define Package/xray-example/description
  $(call Package/xray/description)

  This includes example configuration files for xray-core.
endef

define Package/xray-geodata/description
  $(call Package/xray/description)

  This includes GEO datas used for xray-core.
endef

define Package/xray-core/config
menu "Xray-core Configuration"
	depends on PACKAGE_xray-core

config XRAY_CORE_PROVIDE_V2RAY_CORE
	bool "Provide V2Ray binary using XRay"
	default y

config XRAY_CORE_COMPRESS_GOPROXY
	bool "Compiling with GOPROXY proxy"
	default n

config XRAY_CORE_COMPRESS_UPX
	bool "Compress executable files with UPX"
	default y
endmenu
endef

define Package/xray-core/conffiles
/etc/xray/
/etc/config/xray
endef

GEOIP_VER:=202103012212
GEOIP_FILE:=geoip.dat.$(GEOIP_VER)

define Download/geoip
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOIP_VER)/
  URL_FILE:=geoip.dat
  FILE:=$(GEOIP_FILE)
  HASH:=55921367a26422a9acd96c3aa8a3395363f1f92fec5230f46b49406d999f88f6
endef

GEOSITE_VER:=202103012212
GEOSITE_FILE:=geosite.dat.$(GEOSITE_VER)

define Download/geosite
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOSITE_VER)/
  URL_FILE:=geosite.dat
  FILE:=$(GEOSITE_FILE)
  HASH:=848c2455275452c32b341430a1185dcabfe7af3ff44f2226b22e3c50f034657b
endef

ifneq ($(CONFIG_XRAY_CORE_COMPRESS_GOPROXY),)
	export GO111MODULE=on
	export GOPROXY=https://goproxy.io
endif

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_xray-geodata),)
	$(call Download,geoip)
	$(call Download,geosite)
endif
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
ifneq ($(CONFIG_XRAY_CORE_COMPRESS_UPX),)
	$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/main
endif
endef

define Package/xray-core/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/main $(1)/usr/bin/xray
ifneq ($(CONFIG_XRAY_CORE_PROVIDE_V2RAY_CORE),)
	$(LN) xray $(1)/usr/bin/v2ray
endif

	$(INSTALL_DIR) $(1)/etc/xray/
	$(INSTALL_CONF) $(CURDIR)/files/config.json.example $(1)/etc/xray/

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(CURDIR)/files/xray.conf $(1)/etc/config/xray
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) $(CURDIR)/files/xray.init $(1)/etc/init.d/xray

	$(INSTALL_DIR) $(1)/etc/capabilities/
	$(INSTALL_DATA) $(CURDIR)/files/xray.capabilities $(1)/etc/capabilities/xray.json
endef

define Package/xray-example/install
	$(INSTALL_DIR) $(1)/etc/xray/
	$(INSTALL_CONF) $(CURDIR)/files/vpoint_socks_vmess.json $(1)/etc/xray/
	$(INSTALL_CONF) $(CURDIR)/files/vpoint_vmess_freedom.json $(1)/etc/xray/
endef

define Package/xray-geodata/install
	$(INSTALL_DIR) $(1)/usr/share/xray/
	$(INSTALL_DATA) $(DL_DIR)/$(GEOIP_FILE) $(1)/usr/share/xray/geoip.dat
	$(INSTALL_DATA) $(DL_DIR)/$(GEOSITE_FILE) $(1)/usr/share/xray/geosite.dat
endef

$(eval $(call BuildPackage,xray-core))
$(eval $(call BuildPackage,xray-example))
$(eval $(call BuildPackage,xray-geodata))
