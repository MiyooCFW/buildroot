################################################################################
#
# ECWOLF
#
################################################################################

LIBRETRO_ECWOLF_VERSION = 18eca17c2d634b154824e0782c6cbbe0a2c9ea76
LIBRETRO_ECWOLF_SITE = https://github.com/libretro/ecwolf.git
LIBRETRO_ECWOLF_SITE_METHOD=git
LIBRETRO_ECWOLF_GIT_SUBMODULES=y
LIBRETRO_ECWOLF_LICENSE = GPL-2.0+, ID-Software, MAME, Other
LIBRETRO_ECWOLF_LICENSE_FILES = docs/copyright docs/license-gpl.txt docs/license-id.txt docs/license-mame.txt
LIBRETRO_ECWOLF_NON_COMMERCIAL = y

define LIBRETRO_ECWOLF_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/src/libretro/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/src/libretro/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/src/libretro/*_libretro.so
endef

define LIBRETRO_ECWOLF_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/src/libretro/ecwolf_libretro.so \
		${BINARIES_DIR}/retroarch/cores/ecwolf_libretro.so
endef

$(eval $(generic-package))
