IPK_DRPOCKETSNES_VERSION = 7.2.3
IPK_DRPOCKETSNES_SITE = https://github.com/Apaczer/DrPocketSNES/releases/download/$(IPK_DRPOCKETSNES_VERSION)
IPK_DRPOCKETSNES_SOURCE = drpocketsnes.ipk
IPK_DRPOCKETSNES_INSTALL_TARGET = YES
IPK_DRPOCKETSNES_LICENSE = Custom
#IPK_DRPOCKETSNES_LICENSE_FILES = COPYRIGHT

define IPK_DRPOCKETSNES_EXTRACT_CMDS
	cd $(@D) && ar x $(DL_DIR)/ipk-drpocketsnes/$(IPK_DRPOCKETSNES_SOURCE)
endef

define IPK_DRPOCKETSNES_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/main
	tar -xzf $(@D)/data.tar.gz --strip-components=2 -C $(BINARIES_DIR)/main
endef

$(eval $(generic-package))
