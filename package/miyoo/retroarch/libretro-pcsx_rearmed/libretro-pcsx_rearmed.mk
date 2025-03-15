################################################################################
#
# PCSX_REARMED
#
################################################################################

# Commit of Mar-3-2025
LIBRETRO_PCSX_REARMED_VERSION = f49a4c48cb6eb1974505644f2ae76cf55693e9fe
LIBRETRO_PCSX_REARMED_SITE = https://github.com/notaz/pcsx_rearmed
LIBRETRO_PCSX_REARMED_SITE_METHOD = git
LIBRETRO_PCSX_REARMED_LICENSE = GPL-2.0
LIBRETRO_PCSX_REARMED_LICENSE_FILES = COPYING
LIBRETRO_PCSX_REARMED_GIT_SUBMODULES = YES
# Optimize build with Profile Guided Optimization (values: 0, YES, APPLY)
LIBRETRO_PCSX_REARMED_PGO ?= APPLY

ifeq ($(LIBRETRO_PCSX_REARMED_PGO),APPLY)
define LIBRETRO_PCSX_REARMED_CONFIGURE_CMDS
	cp -r $(BASE_DIR)/../board/miyoo/profile/$(LIBC)/libretro-pcsx_rearmed/* $(@D)/
endef
endif

define LIBRETRO_PCSX_REARMED_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) PROFILE="$(LIBRETRO_PCSX_REARMED_PGO)" CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" AR="$(TARGET_AR)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_PCSX_REARMED_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/pcsx_rearmed_libretro.so \
		${BINARIES_DIR}/retroarch/cores/pcsx_rearmed_libretro.so
endef

$(eval $(generic-package))
