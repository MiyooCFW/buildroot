RETROARCH_VERSION = 1.16.0.3
RETROARCH_SITE = $(call github,libretro,RetroArch,v$(RETROARCH_VERSION))
RETROARCH_LICENSE = GPL-3.0
RETROARCH_LICENSE_FILES = COPYING
RETROARCH_DEPENDENCIES = host-pkgconf sdl sdl_image sdl_mixer sdl_sound sdl_ttf freetype
define RETROARCH_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" -C $(@D) -f Makefile.miyoo
    $(TARGET_STRIP) --strip-unneeded $(@D)/retroarch
endef

define RETROARCH_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/retroarch $(TARGET_DIR)/usr/bin
    mkdir -p "${BINARIES_DIR}/retroarch/filters/audio"
    mkdir -p "${BINARIES_DIR}/retroarch/filters/video"
    $(INSTALL) -D -m 0644 $(@D)/libretro-common/audio/dsp_filters/*.dsp "${BINARIES_DIR}/retroarch/filters/audio"
    $(INSTALL) -D -m 0644 $(@D)/gfx/video_filters/*.filt "${BINARIES_DIR}/retroarch/filters/video"
endef

$(eval $(generic-package))