################################################################################
#
# linuxjoymap
#
################################################################################

JOYMAP_VERSION = 0.5.5
JOYMAP_SOURCE = joymap-$(JOYMAP_VERSION).tar.gz
JOYMAP_SITE = http://downloads.sourceforge.net/project/linuxjoymap
JOYMAP_LICENSE = GPL-2.0
JOYMAP_LICENSE_FILES = COPYING

define JOYMAP_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D)
	"$(TARGET_CC)" $(@D)/tools/input_info.c -o $(@D)/tools/input_info
endef

define JOYMAP_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/loadmap $(TARGET_DIR)/usr/bin
        $(INSTALL) -D -m 0755 $(@D)/tools/input_info $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
