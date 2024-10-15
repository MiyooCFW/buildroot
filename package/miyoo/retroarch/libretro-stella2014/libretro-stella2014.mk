################################################################################
#
# STELLA2014
#
################################################################################

LIBRETRO_STELLA2014_VERSION = 8ab051edd4816f33a5631d230d54059eeed52c5f
LIBRETRO_STELLA2014_SITE = $(call github,libretro,stella2014-libretro,$(LIBRETRO_STELLA2014_VERSION))
LIBRETRO_STELLA2014_LICENSE = GPL-2.0

LIBRETRO_STELLA2014_PLATFORM=$(RETROARCH_LIBRETRO_BOARD)

define LIBRETRO_STELLA2014_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_STELLA2014_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/stella2014_libretro.so \
		${BINARIES_DIR}/retroarch/cores/stella2014_libretro.so
endef

$(eval $(generic-package))
