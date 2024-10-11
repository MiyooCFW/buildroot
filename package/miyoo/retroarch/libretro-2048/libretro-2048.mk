################################################################################
#
# 2048
#
################################################################################

LIBRETRO_2048_VERSION = 331c1de588ed8f8c370dcbc488e5434a3c09f0f2
LIBRETRO_2048_SITE = $(call github,libretro,libretro-2048,$(LIBRETRO_2048_VERSION))
LIBRETRO_2048_LICENSE = UNLICENSE
LIBRETRO_2048_LICENSE_FILES = LICENSE

define LIBRETRO_2048_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_2048_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/2048_libretro.so \
		${BINARIES_DIR}/retroarch/cores/2048_libretro.so
endef

$(eval $(generic-package))
 

