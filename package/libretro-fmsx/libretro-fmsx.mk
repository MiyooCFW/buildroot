################################################################################
#
# FMSX
#
################################################################################

# Commit of 2023/04/17
LIBRETRO_FMSX_VERSION = 1806eed4376fbe2fad82fa19271ea298cfbb7795
LIBRETRO_FMSX_SITE = $(call github,libretro,fmsx-libretro,$(LIBRETRO_FMSX_VERSION))
LIBRETRO_FMSX_LICENSE = COPYRIGHT
LIBRETRO_FMSX_LICENSE_FILES = LICENSE
LIBRETRO_FMSX_NON_COMMERCIAL = y

define LIBRETRO_FMSX_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) platform="$(RETROARCH_LIBRETRO_PLATFORM)" PLATFORM_DEFINES="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_FMSX_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/fmsx_libretro.so \
		${BINARIES_DIR}/retroarch/cores/fmsx_libretro.so
endef

$(eval $(generic-package))
