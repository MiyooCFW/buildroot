################################################################################
#
# CHAILOVE
#
################################################################################

LIBRETRO_CHAILOVE_VERSION = 69000df629896fb08c26edcfb7a6f08d40e0c74c
LIBRETRO_CHAILOVE_SITE = https://github.com/libretro/ChaiLove.git
LIBRETRO_CHAILOVE_SITE_METHOD=git
LIBRETRO_CHAILOVE_GIT_SUBMODULES=y
LIBRETRO_CHAILOVE_LICENSE = MIT
LIBRETRO_CHAILOVE_LICENSE_FILES = COPYING

define LIBRETRO_CHAILOVE_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_CHAILOVE_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/chailove_libretro.so \
		${BINARIES_DIR}/retroarch/cores/chailove_libretro.so
endef

$(eval $(generic-package))
