################################################################################
#
# GAMBATTE
#
################################################################################

# Commit of 2023/09/29
LIBRETRO_GAMBATTE_VERSION = 40d0d7ac4e11b5c2d1feac2ce96e4d824c248985
LIBRETRO_GAMBATTE_SITE = $(call github,libretro,gambatte-libretro,$(LIBRETRO_GAMBATTE_VERSION))
LIBRETRO_GAMBATTE_LICENSE = GPL-2.0
LIBRETRO_GAMBATTE_LICENSE_FILES = COPYING

define LIBRETRO_GAMBATTE_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_GAMBATTE_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/gambatte_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gambatte_libretro.so
endef

$(eval $(generic-package))
