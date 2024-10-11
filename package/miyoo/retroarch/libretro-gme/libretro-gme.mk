################################################################################
#
# GME
#
################################################################################

LIBRETRO_GME_VERSION = 40d8b3bf4f0bd4f713f65e08c62d30b1ae8b2282
LIBRETRO_GME_SITE = $(call github,libretro,libretro-GME,$(LIBRETRO_GME_VERSION))
LIBRETRO_GME_LICENSE = UNLICENSE
LIBRETRO_GME_LICENSE_FILES = LICENSE

define LIBRETRO_GME_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ platform="$(RETROARCH_LIBRETRO_PLATFORM)"
endef

define LIBRETRO_GME_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/gme_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gme_libretro.so
endef

$(eval $(generic-package))
