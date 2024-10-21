IPK_GNGEO_VERSION = v20210731-m1
IPK_GNGEO_SITE = https://github.com/Apaczer/gngeo/releases/download/$(IPK_GNGEO_VERSION)
IPK_GNGEO_SOURCE = gngeo.ipk
IPK_GNGEO_INSTALL_TARGET = YES
IPK_GNGEO_LICENSE = GPL-2.0, Custom
#IPK_GNGEO_LICENSE_FILES = COPYING

define IPK_GNGEO_EXTRACT_CMDS
	cd $(@D) && ar x $(DL_DIR)/ipk-gngeo/$(IPK_GNGEO_SOURCE)
endef

define IPK_GNGEO_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/main
	tar -xzf $(@D)/data.tar.gz --strip-components=2 -C $(BINARIES_DIR)/main
endef

$(eval $(generic-package))
