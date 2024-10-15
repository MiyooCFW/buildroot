################################################################################
#
# MGBA
#
################################################################################

# Commit of 2023/05/28
LIBRETRO_MGBA_VERSION = 314bf7b676f5b820f396209eb0c7d6fbe8103486
LIBRETRO_MGBA_SITE = $(call github,libretro,mgba,$(LIBRETRO_MGBA_VERSION))
LIBRETRO_MGBA_LICENSE = MPL-2.0
LIBRETRO_MGBA_LICENSE_FILES = LICENSE

ifeq ($(BR2_TOOLCHAIN_BUILDROOT_LIBC),"musl")
mgba_platform="unix"
else
mgba_platform="miyoo"
endif

LIBRETRO_MGBA_CFLAGS = $(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)
ifeq ($(BR2_TOOLCHAIN_BUILDROOT_LOCALE),y)
LIBRETRO_MGBA_CFLAGS += -DHAVE_LOCALE
endif

define LIBRETRO_MGBA_BUILD_CMDS
	CFLAGS="$(LIBRETRO_MGBA_CFLAGS)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(mgba_platform)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MGBA_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/retroarch/cores
	$(INSTALL) -D $(@D)/mgba_libretro.so \
		$(BINARIES_DIR)/retroarch/cores/mgba_libretro.so
endef

$(eval $(generic-package))
