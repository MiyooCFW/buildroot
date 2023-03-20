FATRESIZE_VERSION = origin/hardcoded
FATRESIZE_SITE_METHOD = git
FATRESIZE_SITE = https://github.com/flabbergast/fatresize.git
FATRESIZE_DEPENDENCIES = parted

define FATRESIZE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D)
endef

define FATRESIZE_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/fatresize_hc $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))