# linuxjoymap release 0.5.5
JOYMAP_VERSION = 705bf560ae926a367f00adf9723581313c4e2c7c
JOYMAP_SITE_METHOD = git
JOYMAP_SITE = https://git.code.sf.net/p/linuxjoymap/git
define JOYMAP_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D) -f Makefile
    "$(TARGET_CC)" $(@D)/tools/input_info.c -o $(@D)/tools/input_info
endef

define JOYMAP_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/loadmap $(TARGET_DIR)/usr/bin
        $(INSTALL) -D -m 0755 $(@D)/tools/input_info $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))