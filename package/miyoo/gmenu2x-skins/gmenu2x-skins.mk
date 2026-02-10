################################################################################
#
# GMenu2X skins
#
################################################################################

GMENU2X_SKINS_VERSION = origin/main
GMENU2X_SKINS_SITE_METHOD = git
GMENU2X_SKINS_SITE = https://github.com/MiyooCFW/gmenu2x-skins.git
GMENU2X_SKINS_LICENSE = Custom
GMENU2X_SKINS_LICENSE_FILES = Default/LICENSE_skin.txt

# Nothing to build; only assets to install to target
define GMENU2X_SKINS_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/gmenu2x/skins
	cp -r $(@D)/* $(BINARIES_DIR)/gmenu2x/skins
endef

$(eval $(generic-package))
