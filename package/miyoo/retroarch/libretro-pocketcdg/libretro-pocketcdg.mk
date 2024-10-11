################################################################################
#
# POCKETCDG
#
################################################################################

LIBRETRO_POCKETCDG_VERSION = 34913f755c92aa7c98668f291631c23e21d88bdc
LIBRETRO_POCKETCDG_SITE = $(call github,libretro,libretro-pocketcdg,$(LIBRETRO_POCKETCDG_VERSION))
LIBRETRO_POCKETCDG_LICENSE = UNLICENSE
LIBRETRO_POCKETCDG_LICENSE_FILES = LICENSE

define LIBRETRO_POCKETCDG_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_POCKETCDG_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/pocketcdg_libretro.so \
		${BINARIES_DIR}/retroarch/cores/pocketcdg_libretro.so
endef

$(eval $(generic-package))
