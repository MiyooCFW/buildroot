LIBRETRO_ASSETS_VERSION = Latest
LIBRETRO_ASSETS_SITE = $(call github,libretro,retroarch-assets,${LIBRETRO_ASSETS_VERSION})
LIBRETRO_ASSETS_LICENSE = GPL-3.0
LIBRETRO_ASSETS_LICENSE_FILES = COPYING

define LIBRETRO_ASSETS_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
        mkdir -p "${BINARIES_DIR}/retroarch/assets"
        cp -r $(@D)/rgui/ "${BINARIES_DIR}/retroarch/assets/"
	$(INSTALL) -D -m 0644 $(@D)/COPYING "${BINARIES_DIR}/retroarch/assets/"
endef

$(eval $(generic-package))