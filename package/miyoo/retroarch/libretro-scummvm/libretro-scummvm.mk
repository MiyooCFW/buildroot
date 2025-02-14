################################################################################
#
# SCUMMVM
#
################################################################################

# Commit from Dec 3, 2024
LIBRETRO_SCUMMVM_VERSION = 7310d4e9f5d11553c6c5499911bd2f9b8ff3db3b
LIBRETRO_SCUMMVM_SITE = $(call github,libretro,scummvm,$(LIBRETRO_SCUMMVM_VERSION))
LIBRETRO_SCUMMVM_LICENSE = GPL-2.0
LIBRETRO_SCUMMVM_LICENSE_FILES = COPYING
# We will'be overwriting info file in final install step, so build core-info first
LIBRETRO_SCUMMVM_DEPENDENCIES = libretro-core-info

LIBRETRO_SCUMMVM_LTO_CFLAGS = $(COMPILER_COMMONS_CFLAGS_SO)
LIBRETRO_SCUMMVM_LTO_CXXFLAGS = $(COMPILER_COMMONS_CXXFLAGS_SO)
LIBRETRO_SCUMMVM_LTO_LDFLAGS = $(COMPILER_COMMONS_LSFLAGS_SO)

define LIBRETRO_SCUMMVM_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/backends/platform/libretro/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(LIBRETRO_SCUMMVM_LTO_CFLAGS) -ffat-lto-objects" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(LIBRETRO_SCUMMVM_LTO_CXXFLAGS) -ffat-lto-objects" \
		LDFLAGS="$(TARGET_LDFLAGS) $(LIBRETRO_SCUMMVM_LTO_LDFLAGS) -ffat-lto-objects -shared -Wl,--no-undefined" \
		$(MAKE) all TOOLSET="$(TARGET_CROSS)" -C $(@D)/backends/platform/libretro/ HEAVY=2 platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/backends/platform/libretro/scummvm_libretro.so
endef

define LIBRETRO_SCUMMVM_INSTALL_TARGET_CMDS
	mkdir -p ${BINARIES_DIR}/retroarch/cores
	mkdir -p ${BINARIES_DIR}/retroarch/system/ScummVM
	unzip -o $(@D)/backends/platform/libretro/scummvm.zip -d $(@D)/backends/platform/libretro/
	mv -fn $(@D)/backends/platform/libretro/scummvm/* ${BINARIES_DIR}/retroarch/system/ScummVM/
	$(INSTALL) -D $(@D)/backends/platform/libretro/ScummVM.dat \
		${BINARIES_DIR}/retroarch/system/ScummVM.dat
	$(INSTALL) -D $(@D)/backends/platform/libretro/scummvm_libretro.so \
		${BINARIES_DIR}/retroarch/cores/scummvm_libretro.so
# Overwrite existing info file with src generated one
	$(INSTALL) -D -m 0644 $(@D)/backends/platform/libretro/scummvm_libretro.info \
		${BINARIES_DIR}/retroarch/core_info/scummvm_libretro.info
endef

$(eval $(generic-package))
