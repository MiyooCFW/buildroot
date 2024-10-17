################################################################################
#
# JAXE
#
################################################################################

LIBRETRO_JAXE_VERSION = e03ea87f37b33d89ce9c9bd71bd71fd0158cc68d
LIBRETRO_JAXE_SITE = https://github.com/kurtjd/jaxe.git
LIBRETRO_JAXE_SITE_METHOD=git
LIBRETRO_JAXE_GIT_SUBMODULES=y
LIBRETRO_JAXE_LICENSE = MIT
LIBRETRO_JAXE_LICENSE_FILES = LICENSE

define LIBRETRO_JAXE_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_JAXE_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/jaxe_libretro.so \
		${BINARIES_DIR}/retroarch/cores/jaxe_libretro.so
endef

$(eval $(generic-package))
