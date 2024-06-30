################################################################################
#
# MEDNAFEN_PCE_FAST
#
################################################################################

LIBRETRO_MEDNAFEN_PCE_FAST_VERSION = 1ce7a4a941b10aa0c2973cb441b89ee99e2c8d0e
LIBRETRO_MEDNAFEN_PCE_FAST_SITE = $(call github,libretro,beetle-pce-fast-libretro,$(LIBRETRO_MEDNAFEN_PCE_FAST_VERSION))
LIBRETRO_MEDNAFEN_PCE_FAST_LICENSE = GPL-2.0
LIBRETRO_MEDNAFEN_PCE_FAST_LICENSE_FILES = COPYING

define LIBRETRO_MEDNAFEN_PCE_FAST_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MEDNAFEN_PCE_FAST_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/mednafen_pce_fast_libretro.so \
		${BINARIES_DIR}/retroarch/cores/mednafen_pce_fast_libretro.so
endef

$(eval $(generic-package))
