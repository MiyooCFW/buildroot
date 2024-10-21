################################################################################
#
# GEARBOY
#
################################################################################

LIBRETRO_GEARBOY_VERSION = 49438e4f90de9203615aeba2a0ef6362fe8144d9
LIBRETRO_GEARBOY_SITE = $(call github,drhelius,gearboy,$(LIBRETRO_GEARBOY_VERSION))
LIBRETRO_GEARBOY_LICENSE = GPL-3.0
LIBRETRO_GEARBOY_LICENSE_FILES = LICENSE

define LIBRETRO_GEARBOY_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/platforms/libretro/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/platforms/libretro/*_libretro.so
endef

define LIBRETRO_GEARBOY_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/platforms/libretro/gearboy_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gearboy_libretro.so
endef

$(eval $(generic-package))
