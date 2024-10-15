################################################################################
#
# X1
#
################################################################################

LIBRETRO_X1_VERSION = 04b3c90af710b66b31df3c9621fa8da13b24e123
LIBRETRO_X1_SITE = $(call github,libretro,xmil-libretro,$(LIBRETRO_X1_VERSION))
LIBRETRO_X1_LICENSE = UNLICENSE
LIBRETRO_X1_LICENSE_FILES = LICENSE

define LIBRETRO_X1_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/libretro -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/libretro/*_libretro.so
endef

define LIBRETRO_X1_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/libretro/x1_libretro.so \
		${BINARIES_DIR}/retroarch/cores/x1_libretro.so
endef

$(eval $(generic-package))
