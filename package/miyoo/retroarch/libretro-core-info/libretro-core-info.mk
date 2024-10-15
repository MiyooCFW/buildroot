LIBRETRO_CORE_INFO_VERSION = 1.16.0.3
LIBRETRO_CORE_INFO_SITE = $(call github,libretro,libretro-core-info,v${LIBRETRO_CORE_INFO_VERSION})
LIBRETRO_CORE_INFO_LICENSE = GPL-3.0
LIBRETRO_CORE_INFO_LICENSE_FILES = COPYING

define LIBRETRO_CORE_INFO_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/core_info"
	$(INSTALL) -D -m 0644  $(@D)/*.info "${BINARIES_DIR}/retroarch/core_info"
endef

$(eval $(generic-package))