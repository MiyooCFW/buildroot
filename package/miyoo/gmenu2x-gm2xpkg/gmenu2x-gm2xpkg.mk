################################################################################
#
# GMenu2X's "gm2xpkg" script
#
################################################################################

# Not a BR2_PACKAGE_FOO_VERSION
GM2XPKG_VERSION = master


GMENU2X_GM2XPKG_EXTRA_DOWNLOADS = https://raw.githubusercontent.com/MiyooCFW/gmenu2x/$(GM2XPKG_VERSION)/tools/gm2xpkg.sh
GMENU2X_GM2XPKG_INSTALL_STAGING = YES
GMENU2X_GM2XPKG_INSTALL_TARGET = NO
GMENU2X_GM2XPKG_LICENSE = GPL-2.0
GMENU2X_GM2XPKG_LICENSE_FILES = COPYING

# Install GMenu2X PacKaGer to staging for development
define GMENU2X_GM2XPKG_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(GMENU2X_GM2XPKG_DL_DIR)/gm2xpkg.sh $(STAGING_DIR)/usr/bin/gm2xpkg
endef

$(eval $(generic-package))
