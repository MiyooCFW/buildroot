IPK_GPSP_VERSION = 1.2.3
IPK_GPSP_SITE = https://github.com/Apaczer/gpsp/releases/download/$(IPK_GPSP_VERSION)
IPK_GPSP_SOURCE = gpsp.ipk
IPK_GPSP_INSTALL_TARGET = YES

define IPK_GPSP_EXTRACT_CMDS
    cd $(@D) && ar x $(DL_DIR)/ipk-gpsp/$(IPK_GPSP_SOURCE)
endef

define IPK_GPSP_INSTALL_TARGET_CMDS
    mkdir -p $(BINARIES_DIR)/main
    tar -xzf $(@D)/data.tar.gz --strip-components=2 -C $(BINARIES_DIR)/main
endef

$(eval $(generic-package))