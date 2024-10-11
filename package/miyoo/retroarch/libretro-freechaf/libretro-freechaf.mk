################################################################################
#
# FREECHAF
#
################################################################################

# commit of 2023/10/08
LIBRETRO_FREECHAF_VERSION = a406693850f6308392dc488e642fe1b1ae1bff3b
LIBRETRO_FREECHAF_SITE = https://github.com/libretro/FreeChaF.git
LIBRETRO_FREECHAF_LICENSE = GPL-3.0
LIBRETRO_FREECHAF_LICENSE_FILES = LICENSE

LIBRETRO_FREECHAF_SITE_METHOD=git
LIBRETRO_FREECHAF_GIT_SUBMODULES=y

define LIBRETRO_FREECHAF_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	# Currently, FreeChaF crash when compiled with LTO.
	# As it might be a compiler or a code issue, try to reactivate LTO
	# on next toolchain or code bump.
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_NOLTO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_NOLTO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_NOLTO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_CXX)" AR="$(TARGET_AR)" RANLIB="$(TARGET_RANLIB)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_FREECHAF_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/freechaf_libretro.so \
		${BINARIES_DIR}/retroarch/cores/freechaf_libretro.so
endef

$(eval $(generic-package))
