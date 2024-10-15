################################################################################
#
# GW
#
################################################################################

# Commit of 2023/05/28
LIBRETRO_GW_VERSION = 0ecff52b11c327af52b22ea94b268c90472b6732
LIBRETRO_GW_SITE = $(call github,libretro,gw-libretro,$(LIBRETRO_GW_VERSION))
LIBRETRO_GW_LICENSE = ZLIB
LIBRETRO_GW_LICENSE_FILES = LICENSE

define LIBRETRO_GW_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_GW_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/gw_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gw_libretro.so
endef

$(eval $(generic-package))
