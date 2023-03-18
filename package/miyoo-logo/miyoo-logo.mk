MIYOO_LOGO_VERSION = origin/master
MIYOO_LOGO_SITE_METHOD = git
MIYOO_LOGO_SITE = https://github.com/MiyooCFW/logo.git
MIYOO_LOGO_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_sound sdl_ttf mpg123
define MIYOO_LOGO_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D) -f Makefile.miyoo
endef

define MIYOO_LOGO_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/boot-logo $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))