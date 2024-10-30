IPK_GPSP_VERSION = 1.2.3
IPK_GPSP_SITE = https://github.com/Apaczer/gpsp/releases/download/$(IPK_GPSP_VERSION)
IPK_GPSP_SOURCE = gpsp.ipk
IPK_GPSP_INSTALL_TARGET = YES
IPK_GPSP_LICENSE = GPL-2.0
#IPK_GPSP_LICENSE_FILES = COPYING.DOC

define IPK_GPSP_EXTRACT_CMDS
    cd $(@D) && cp $(DL_DIR)/ipk-gpsp/$(IPK_GPSP_SOURCE) .
endef

define IPK_GPSP_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/main/pkgs
	$(INSTALL) -D -m 0666 $(@D)/$(IPK_GPSP_SOURCE) $(BINARIES_DIR)/main/pkgs
endef

$(eval $(generic-package))
