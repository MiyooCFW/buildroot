################################################################################
#
# VAPORSPEC
#
################################################################################

LIBRETRO_VAPORSPEC_VERSION = fb5d6ddabec23298db39ab8536f77623fb3a1bae
LIBRETRO_VAPORSPEC_SITE = https://github.com/minkcv/vm.git
LIBRETRO_VAPORSPEC_SITE_METHOD=git
LIBRETRO_VAPORSPEC_GIT_SUBMODULES=y
LIBRETRO_VAPORSPEC_LICENSE = MIT
LIBRETRO_VAPORSPEC_LICENSE_FILES = LICENSE.md

define LIBRETRO_VAPORSPEC_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/machine -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/machine/*_libretro.so
endef

define LIBRETRO_VAPORSPEC_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/machine/vaporspec_libretro.so \
		${BINARIES_DIR}/retroarch/cores/vaporspec_libretro.so
endef

$(eval $(generic-package))
