ST_SDL_VERSION = rev.2.1
ST_SDL_SITE_METHOD = git
ST_SDL_SITE = https://github.com/Apaczer/miyoo_st-sdl
ST_SDL_DEPENDENCIES = sdl
define ST_SDL_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D) -f Makefile.miyoo
endef

define ST_SDL_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/st $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
