################################################################################
#
# REMINISCENCE
#
################################################################################

# Commit of 2022/04/05
LIBRETRO_REMINISCENCE_VERSION = c2624c7565bbae441835db80f24902fc40f83dd1
LIBRETRO_REMINISCENCE_SITE = $(call github,libretro,REminiscence,$(LIBRETRO_REMINISCENCE_VERSION))
LIBRETRO_REMINISCENCE_LICENSE = Copyright
# The Copyright license is written over source code files e.g.:
LIBRETRO_REMINISCENCE_LICENSE_FILES = src/game.cpp

define LIBRETRO_REMINISCENCE_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_NOLTO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_NOLTO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_NOLTO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_REMINISCENCE_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/reminiscence_libretro.so \
		${BINARIES_DIR}/retroarch/cores/reminiscence_libretro.so
endef

$(eval $(generic-package))
