################################################################################
#
# UW8
#
################################################################################

LIBRETRO_UW8_VERSION = 2dced6e1b990222033e269d5fb269b2e2f9ee543
LIBRETRO_UW8_SITE = https://github.com/libretro/uw8-libretro.git
LIBRETRO_UW8_SITE_METHOD=git
LIBRETRO_UW8_GIT_SUBMODULES=y
LIBRETRO_UW8_LICENSE = UNLICENSE
LIBRETRO_UW8_LICENSE_FILES = UNLICENSE

define LIBRETRO_UW8_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_UW8_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/uw8_libretro.so \
		${BINARIES_DIR}/retroarch/cores/uw8_libretro.so
endef

$(eval $(generic-package))
