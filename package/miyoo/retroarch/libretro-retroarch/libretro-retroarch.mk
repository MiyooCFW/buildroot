LIBRETRO_RETROARCH_VERSION = e4221d4456fb1ef21f0aecd7c5d5c8ae65fde26f
LIBRETRO_RETROARCH_SITE = https://github.com/libretro/RetroArch/archive/$(LIBRETRO_RETROARCH_VERSION)
LIBRETRO_RETROARCH_SOURCE = libretro-retroarch-$(LIBRETRO_RETROARCH_VERSION).tar.gz
LIBRETRO_RETROARCH_LICENSE = GPL-3.0
LIBRETRO_RETROARCH_LICENSE_FILES = COPYING
LIBRETRO_RETROARCH_DEPENDENCIES = host-pkgconf sdl sdl_image sdl_mixer sdl_sound sdl_ttf freetype
RETROARCH_LIBRETRO_PLATFORM = miyoo

# bug in uClibc doesn't allow to use IPv6 (?) so let us defer to IPv4
ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC)$(BR2_TOOLCHAIN_EXTERNAL_UCLIBC),y)
define LIBRETRO_RETROARCH_POST_PATCH_USE_SOCKET_LEGACY
	$(SED) "s|HAVE_SOCKET_LEGACY = 0|HAVE_SOCKET_LEGACY = 1|g" $(@D)/Makefile.miyoo
endef
endif

LIBRETRO_RETROARCH_POST_PATCH_HOOKS += LIBRETRO_RETROARCH_POST_PATCH_USE_SOCKET_LEGACY

define LIBRETRO_RETROARCH_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" -C $(@D) -f Makefile.miyoo
	$(TARGET_STRIP) --strip-unneeded $(@D)/retroarch
endef

define LIBRETRO_RETROARCH_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/emus/retroarch"
	$(INSTALL) -D -m 0755 $(@D)/retroarch "${BINARIES_DIR}/emus/retroarch"
	mkdir -p "${BINARIES_DIR}/retroarch/filters/audio"
	mkdir -p "${BINARIES_DIR}/retroarch/filters/video"
	$(INSTALL) -D -m 0644 $(@D)/libretro-common/audio/dsp_filters/*.dsp "${BINARIES_DIR}/retroarch/filters/audio"
	$(INSTALL) -D -m 0644 $(@D)/gfx/video_filters/*.filt "${BINARIES_DIR}/retroarch/filters/video"
endef

$(eval $(generic-package))
