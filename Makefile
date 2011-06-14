include $(TOPDIR)/rules.mk

PKG_NAME:=scheme48
PKG_VERSION:=1.8
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://s48.org/$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_VARS += CONFIG_SITE=$(CURDIR)/config.site

define Package/scheme48
	TITLE:=Scheme 48
	SECTION:=lang
	CATEGORY:=Languages
	URL:=http://s48.org/
endef

define Package/scheme48/description
Scheme 48 is an implementation of Scheme written by Richard Kelsey and Jonathan Rees.
It is based on a byte-code interpreter and is designed to be used as a testbed for
experiments in implementation techniques and as an expository tool.
endef

define Package/scheme48/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
endef

$(eval $(call BuildPackage,scheme48))
