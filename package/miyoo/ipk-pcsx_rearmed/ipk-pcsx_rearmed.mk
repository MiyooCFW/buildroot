IPK_PCSX_REARMED_VERSION = 1.0
IPK_PCSX_REARMED_SITE = https://github.com/tiopex/pcsx_rearmed/releases/download/$(IPK_PCSX_REARMED_VERSION)
IPK_PCSX_REARMED_SOURCE = pcsx.ipk
IPK_PCSX_REARMED_INSTALL_TARGET = YES
IPK_PCSX_REARMED_LICENSE = GPL-2.0
IPK_PCSX_REARMED_LICENSE_FILES = COPYING

define IPK_PCSX_REARMED_EXTRACT_CMDS
	cd $(@D) && ar x $(DL_DIR)/ipk-pcsx_rearmed/$(IPK_PCSX_REARMED_SOURCE)
endef

define IPK_PCSX_REARMED_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/main
	tar -xzf $(@D)/data.tar.gz --strip-components=2 -C $(BINARIES_DIR)/main
endef

$(eval $(generic-package))
