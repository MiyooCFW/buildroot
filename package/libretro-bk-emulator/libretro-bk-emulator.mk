################################################################################
#
# BK-0010/0011/Terak 8510a emulator
#
################################################################################

# Commit of 2022/07/26
LIBRETRO_BK_EMULATOR_VERSION = cf70ce503ddb65051a58f3c4f61d1e258fc4c84b
LIBRETRO_BK_EMULATOR_SITE = $(call github,libretro,bk-emulator,$(LIBRETRO_BK_EMULATOR_VERSION))
LIBRETRO_BK_EMULATOR_LICENSE = Custom

define LIBRETRO_BK_EMULATOR_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CPPFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_BK_EMULATOR_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/bk_libretro.so \
		${BINARIES_DIR}/retroarch/cores/bk_libretro.so
endef

$(eval $(generic-package))
