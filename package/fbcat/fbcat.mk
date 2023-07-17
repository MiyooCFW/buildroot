################################################################################
#
# fbcat
#
################################################################################

FBCAT_VERSION = 0.5.2 
FBCAT_SITE = $(call github,jwilk,fbcat,$(FBCAT_VERSION))

define FBCAT_BUILD_CMDS
    $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) fbcat
endef

define FBCAT_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/fbcat $(TARGET_DIR)/usr/bin/fbcat
endef

$(eval $(generic-package))
