################################################################################
#
# NUMERO
#
################################################################################

LIBRETRO_NUMERO_VERSION = 19354c9bfe06a3e4fd936961ee8414b040a3d1c6
LIBRETRO_NUMERO_SITE = $(call github,nbarkhina,numero,$(LIBRETRO_NUMERO_VERSION))
LIBRETRO_NUMERO_LICENSE = UNLICENSE
LIBRETRO_NUMERO_LICENSE_FILES = LICENSE

define LIBRETRO_NUMERO_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_NUMERO_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/numero_libretro.so \
		${BINARIES_DIR}/retroarch/cores/numero_libretro.so
endef

$(eval $(generic-package))
