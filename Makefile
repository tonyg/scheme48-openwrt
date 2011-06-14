include $(TOPDIR)/rules.mk

PKG_NAME:=scheme48
PKG_VERSION:=1.8
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://s48.org/$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

HOST_PATCH_DIR := ./patches-host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

CONFIGURE_VARS += CONFIG_SITE=$(CURDIR)/config.site
MAKE_FLAGS += HOST_VM=$(HOST_BUILD_DIR)/scheme48vm

# The ubuntu I'm building on likes to use a stack protector, which
# causes issues with building some of the .so files. I'm not sure what
# the underlying cause is, I'm simply switching off the stack
# protector here.
HOST_CONFIGURE_ARGS += CFLAGS=-fno-stack-protector

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
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/share
	$(CP) $(PKG_INSTALL_DIR)/usr/share/* $(1)/usr/share/
endef

compile: host-install

$(eval $(call HostBuild))
$(eval $(call BuildPackage,scheme48))
