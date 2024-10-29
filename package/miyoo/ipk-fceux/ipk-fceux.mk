IPK_FCEUX_VERSION = 2.6.6.m2
IPK_FCEUX_SITE = https://github.com/Apaczer/fceux-for-miyoo/releases/download/$(IPK_FCEUX_VERSION)
IPK_FCEUX_SOURCE = fceux.ipk
IPK_FCEUX_INSTALL_TARGET = YES
IPK_FCEUX_LICENSE = GPL-2.0
#IPK_FCEUX_LICENSE_FILES = COPYING

define IPK_FCEUX_EXTRACT_CMDS
    cd $(@D) && cp $(DL_DIR)/ipk-fceux/$(IPK_FCEUX_SOURCE) .
endef

define IPK_FCEUX_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/main/ipk/
	$(INSTALL) -D -m 0666 $(@D)/$(IPK_FCEUX_SOURCE) $(BINARIES_DIR)/main/ipk
endef

$(eval $(generic-package))
