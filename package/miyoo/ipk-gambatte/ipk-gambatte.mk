IPK_GAMBATTE_VERSION = 1.0
IPK_GAMBATTE_SITE = https://github.com/tiopex/gambatte-dms/releases/download/$(IPK_GAMBATTE_VERSION)
IPK_GAMBATTE_SOURCE = gambatte.ipk
IPK_GAMBATTE_INSTALL_TARGET = YES
IPK_GAMBATTE_LICENSE = GPL-2.0
#IPK_GAMBATTE_LICENSE_FILES = COPYING

define IPK_GAMBATTE_EXTRACT_CMDS
    cd $(@D) && cp $(DL_DIR)/ipk-gambatte/$(IPK_GAMBATTE_SOURCE) .
endef

define IPK_GAMBATTE_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/main/ipk
	$(INSTALL) -D -m 0666 $(@D)/$(IPK_GAMBATTE_SOURCE) $(BINARIES_DIR)/main/ipk
endef

$(eval $(generic-package))
