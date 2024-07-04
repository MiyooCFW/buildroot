################################################################################
#
# GMenu2X's "gm2xpkg" script
#
################################################################################

GMENU2X_GM2XPKG_VERSION = $(call qstrip,$(GMENU2X_VERSION))
GMENU2X_GM2XPKG_SITE_METHOD = $(call qstrip,$(GMENU2X_SITE_METHOD))
GMENU2X_GM2XPKG_SITE = $(call qstrip,$(GMENU2X_SITE))
GMENU2X_GM2XPKG_INSTALL_STAGING = YES
GMENU2X_GM2XPKG_INSTALL_TARGET = NO

# Install GMenu2X PacKaGer to staging for development
define GMENU2X_GM2XPKG_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/tools/gm2xpkg.sh $(STAGING_DIR)/usr/bin/gm2xpkg
endef

$(eval $(generic-package))
