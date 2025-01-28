################################################################################
#
# SCUMMVM Legacy
#
################################################################################

# Legacy git 2.1.1 version
LIBRETRO_SCUMMVM_LEGACY_VERSION = 2fb2e4c551c9c1510c56f6e890ee0300b7b3fca3
LIBRETRO_SCUMMVM_LEGACY_SITE = $(call github,libretro-mirrors,scummvm,$(LIBRETRO_SCUMMVM_LEGACY_VERSION))
LIBRETRO_SCUMMVM_LEGACY_LICENSE = GPL-2.0
LIBRETRO_SCUMMVM_LEGACY_LICENSE_FILES = COPYING

LIBRETRO_SCUMMVM_LEGACY_LTO_CFLAGS = $(COMPILER_COMMONS_CFLAGS_SO)
LIBRETRO_SCUMMVM_LEGACY_LTO_CXXFLAGS = $(COMPILER_COMMONS_CXXFLAGS_SO)
LIBRETRO_SCUMMVM_LEGACY_LTO_LDFLAGS = $(COMPILER_COMMONS_LSFLAGS_SO)

define LIBRETRO_SCUMMVM_LEGACY_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/backends/platform/libretro/build/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(LIBRETRO_SCUMMVM_LEGACY_LTO_CFLAGS) -ffat-lto-objects" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(LIBRETRO_SCUMMVM_LEGACY_LTO_CXXFLAGS) -ffat-lto-objects" \
		LDFLAGS="$(TARGET_LDFLAGS) $(LIBRETRO_SCUMMVM_LEGACY_LTO_LDFLAGS) -ffat-lto-objects -shared -Wl,--no-undefined" \
		$(MAKE) all TOOLSET="$(TARGET_CROSS)" -C $(@D)/backends/platform/libretro/build/ platform="$(RETROARCH_LIBRETRO_PLATFORM)"
endef

define LIBRETRO_SCUMMVM_LEGACY_INSTALL_TARGET_CMDS
	mkdir -p ${BINARIES_DIR}/retroarch/cores
	mkdir -p ${BINARIES_DIR}/retroarch/system/scummvm
	unzip -o $(@D)/backends/platform/libretro/aux-data/scummvm.zip -d ${BINARIES_DIR}/retroarch/system/
	$(INSTALL) -D $(@D)/backends/platform/libretro/build/scummvm_libretro.so \
		${BINARIES_DIR}/retroarch/cores/scummvm_legacy_libretro.so
endef

$(eval $(generic-package))
