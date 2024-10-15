COMMANDER_VERSION = 52f9a6a1e06d48471c3f116f37ffad26f7c33262
COMMANDER_SITE_METHOD = git
COMMANDER_SITE = https://github.com/Apaczer/commander
COMMANDER_DEPENDENCIES = sdl sdl_image sdl_ttf sdl_gfx

RESDIR = /usr/share/commander

define COMMANDER_BUILD_CMDS
    $(MAKE) CXX="$(TARGET_CXX)" RESDIR="$(RESDIR)" -C $(@D) -f Makefile.miyoo
endef

define COMMANDER_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/output/commander $(TARGET_DIR)/usr/bin
        cp -R $(@D)/res $(TARGET_DIR)/usr/share/commander
endef

$(eval $(generic-package))
