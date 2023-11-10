################################################################################
#
# CANNONBALL
#
################################################################################

LIBRETRO_CANNONBALL_VERSION = c5487ee342ec2596f733a211b812e338cdba8ad8
LIBRETRO_CANNONBALL_SITE = $(call github,libretro,cannonball,$(LIBRETRO_CANNONBALL_VERSION))
LIBRETRO_CANNONBALL_LICENSE = COPYRIGHT
LIBRETRO_CANNONBALL_NON_COMMERCIAL = y

define LIBRETRO_CANNONBALL_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_CANNONBALL_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
    mkdir -p "${BINARIES_DIR}/retroarch/system/cannonball/res"
	$(INSTALL) -D $(@D)/cannonball_libretro.so \
		${BINARIES_DIR}/retroarch/cores/cannonball_libretro.so
        $(INSTALL) -D $(@D)/res/* \
                ${BINARIES_DIR}/retroarch/system/cannonball/res
        $(INSTALL) -D $(@D)/roms/* \
                ${BINARIES_DIR}/retroarch/system/cannonball

endef

$(eval $(generic-package))
