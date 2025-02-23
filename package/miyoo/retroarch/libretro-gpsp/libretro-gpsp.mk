################################################################################
#
# gpSP
#
################################################################################

# Commit of 2023/12/31
LIBRETRO_GPSP_VERSION = 092c5144827ee3ac07a6af9276244221c303ca41
LIBRETRO_GPSP_SITE = $(call github,libretro,gpsp,$(LIBRETRO_GPSP_VERSION))
LIBRETRO_GPSP_LICENSE = GPL-2.0
LIBRETRO_GPSP_LICENSE_FILES = COPYING
# Optimize build with Profile Guided Optimization (values: 0, YES, APPLY)
LIBRETRO_GPSP_PGO ?= APPLY

ifeq ($(LIBRETRO_GPSP_PGO),APPLY)
define LIBRETRO_GPSP_CONFIGURE_CMDS
	cp -r $(BASE_DIR)/../board/miyoo/profile/$(LIBC)/libretro-gpsp/* $(@D)/
endef
endif

define LIBRETRO_GPSP_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO) -Ofast -fdata-sections -ffunction-sections -fsingle-precision-constant -flto" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		$(MAKE) PROFILE="$(LIBRETRO_GPSP_PGO)" CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) platform="$(RETROARCH_LIBRETRO_PLATFORM)" OPTIMIZE="$(COMPILER_COMMONS_LDFLAGS_SO)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_GPSP_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system"
	$(INSTALL) -D $(@D)/gpsp_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gpsp_libretro.so
	$(INSTALL) -D $(@D)/bios/open_gba_bios.bin \
		${BINARIES_DIR}/retroarch/system
endef

$(eval $(generic-package))
