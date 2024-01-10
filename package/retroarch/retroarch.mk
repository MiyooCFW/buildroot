RETROARCH_VERSION = 35e140ae0840b702a166ab5f1e35be32d065d6b5
RETROARCH_SITE = $(call github,libretro,RetroArch,$(RETROARCH_VERSION))
RETROARCH_LICENSE = GPL-3.0
RETROARCH_LICENSE_FILES = COPYING
RETROARCH_DEPENDENCIES = host-pkgconf sdl sdl_image sdl_mixer sdl_sound sdl_ttf freetype
RETROARCH_LIBRETRO_PLATFORM = miyoo
define RETROARCH_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" -C $(@D) -f Makefile.miyoo
	$(TARGET_STRIP) --strip-unneeded $(@D)/retroarch
endef

define RETROARCH_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/emus/retroarch"
	$(INSTALL) -D -m 0755 $(@D)/retroarch "${BINARIES_DIR}/emus/retroarch"
	mkdir -p "${BINARIES_DIR}/retroarch/filters/audio"
	mkdir -p "${BINARIES_DIR}/retroarch/filters/video"
	$(INSTALL) -D -m 0644 $(@D)/libretro-common/audio/dsp_filters/*.dsp "${BINARIES_DIR}/retroarch/filters/audio"
	$(INSTALL) -D -m 0644 $(@D)/gfx/video_filters/*.filt "${BINARIES_DIR}/retroarch/filters/video"
endef

$(eval $(generic-package))