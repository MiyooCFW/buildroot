IPK_GAMBATTE_VERSION = 1.0
IPK_GAMBATTE_SITE = https://github.com/tiopex/gambatte-dms/releases/download/$(IPK_GAMBATTE_VERSION)
IPK_GAMBATTE_SOURCE = gambatte.ipk
IPK_GAMBATTE_INSTALL_TARGET = YES

define IPK_GAMBATTE_EXTRACT_CMDS
    cd $(@D) && ar x $(DL_DIR)/ipk-gambatte/$(IPK_GAMBATTE_SOURCE)
endef

define IPK_GAMBATTE_INSTALL_TARGET_CMDS
    mkdir -p $(BINARIES_DIR)/main
    tar -xzf $(@D)/data.tar.gz --strip-components=2 -C $(BINARIES_DIR)/main
endef

$(eval $(generic-package))