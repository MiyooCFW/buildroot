################################################################################
#
# BLUEMSX
#
################################################################################

# Commit of 2023/04/17
LIBRETRO_BLUEMSX_VERSION = e21bf74bddb79ad1bbe20b4d964e7515269c669b
LIBRETRO_BLUEMSX_SITE = $(call github,libretro,blueMSX-libretro,$(LIBRETRO_BLUEMSX_VERSION))
LIBRETRO_BLUEMSX_LICENSE = GPL, ZLIB, Freeware, BSD
LIBRETRO_BLUEMSX_LICENSE_FILES = license.txt

define LIBRETRO_BLUEMSX_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_BLUEMSX_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/bluemsx_libretro.so \
		${BINARIES_DIR}/retroarch/cores/bluemsx_libretro.so
	# Create bios directory
	mkdir -p ${BINARIES_DIR}/retroarch/system
	# Copy Databases and Machines directories
	cp -R $(@D)/system/bluemsx/* ${BINARIES_DIR}/retroarch/system
endef

$(eval $(generic-package))
