################################################################################
#
# JUMPNBUMP
#
################################################################################

LIBRETRO_JUMPNBUMP_VERSION = 4e68831f5576075c45c147f86865812afb816139
LIBRETRO_JUMPNBUMP_SITE = $(call github,libretro,jumpnbump-libretro,$(LIBRETRO_JUMPNBUMP_VERSION))
LIBRETRO_JUMPNBUMP_LICENSE = UNLICENSE
LIBRETRO_JUMPNBUMP_LICENSE_FILES = LICENSE

define LIBRETRO_JUMPNBUMP_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_JUMPNBUMP_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/jumpnbump_libretro.so \
		${BINARIES_DIR}/retroarch/cores/jumpnbump_libretro.so
endef

$(eval $(generic-package))
