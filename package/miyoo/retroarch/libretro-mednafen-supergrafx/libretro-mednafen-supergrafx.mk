################################################################################
#
# MEDNAFEN_SUPERGRAFX
#
################################################################################

LIBRETRO_MEDNAFEN_SUPERGRAFX_VERSION = a776133c34ae8da5daf7d9ccb43e3e292e2b07b0
LIBRETRO_MEDNAFEN_SUPERGRAFX_SITE = $(call github,libretro,beetle-supergrafx-libretro,$(LIBRETRO_MEDNAFEN_SUPERGRAFX_VERSION))
LIBRETRO_MEDNAFEN_SUPERGRAFX_LICENSE = GPL-2.0
LIBRETRO_MEDNAFEN_SUPERGRAFX_LICENSE_FILES = COPYING

define LIBRETRO_MEDNAFEN_SUPERGRAFX_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MEDNAFEN_SUPERGRAFX_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/mednafen_supergrafx_libretro.so \
		${BINARIES_DIR}/retroarch/cores/mednafen_supergrafx_libretro.so
endef

$(eval $(generic-package))
