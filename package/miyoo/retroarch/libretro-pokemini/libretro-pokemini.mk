################################################################################
#
# POKEMINI
#
################################################################################

# Commit of 2023/05/28
LIBRETRO_POKEMINI_VERSION = 9bf450887026d9b92d4f9432b5d2a5ed749a35e2
LIBRETRO_POKEMINI_SITE = $(call github,libretro,PokeMini,$(LIBRETRO_POKEMINI_VERSION))
LIBRETRO_POKEMINI_LICENSE = GPL-3.0+
LIBRETRO_POKEMINI_LICENSE_FILES = LICENSE

define LIBRETRO_POKEMINI_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_POKEMINI_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/pokemini_libretro.so \
		${BINARIES_DIR}/retroarch/cores/pokemini_libretro.so
endef

$(eval $(generic-package))
