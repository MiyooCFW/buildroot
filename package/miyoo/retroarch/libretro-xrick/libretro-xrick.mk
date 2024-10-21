################################################################################
#
# XRICK
#
################################################################################

# Commit of 2023/05/28
LIBRETRO_XRICK_VERSION = 58e544ee8de08ca8421e97c064d52ef6cdd73bd2
LIBRETRO_XRICK_SITE = $(call github,libretro,xrick-libretro,$(LIBRETRO_XRICK_VERSION))
LIBRETRO_XRICK_LICENSE = GPL-1.0, Copyright
LIBRETRO_XRICK_LICENSE_FILES = README

define LIBRETRO_XRICK_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_XRICK_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system/xrick"
	$(INSTALL) -D $(@D)/xrick_libretro.so \
		${BINARIES_DIR}/retroarch/cores/xrick_libretro.so
	$(INSTALL) -D $(@D)/data.zip \
		${BINARIES_DIR}/retroarch/system/xrick
endef

$(eval $(generic-package))
