JOYMAP_VERSION = origin/master
JOYMAP_SITE_METHOD = git
JOYMAP_SITE = https://git.code.sf.net/p/linuxjoymap/git
define JOYMAP_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D) -f Makefile
endef

define JOYMAP_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/loadmap $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))