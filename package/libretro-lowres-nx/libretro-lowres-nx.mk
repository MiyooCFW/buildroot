################################################################################
#
# LOWRES-NX
#
################################################################################

# Commit of 2023/03/23
LIBRETRO_LOWRES_NX_VERSION = 10a48e309ac5284724010eea56372fbc72b9f975
LIBRETRO_LOWRES_NX_SITE = $(call github,timoinutilis,lowres-nx,$(LIBRETRO_LOWRES_NX_VERSION))
LIBRETRO_LOWRES_NX_LICENSE = ZLIB
LIBRETRO_LOWRES_NX_LICENSE_FILES = LICENSE

define LIBRETRO_LOWRES_NX_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/platform/LibRetro/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/platform/LibRetro -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/platform/LibRetro/*_libretro.so
endef

define LIBRETRO_LOWRES_NX_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/platform/LibRetro/lowresnx_libretro.so \
		${BINARIES_DIR}/retroarch/cores/lowresnx_libretro.so
endef

$(eval $(generic-package))
