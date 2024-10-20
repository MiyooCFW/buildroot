LIBRETRO_DATABASE_VERSION = f8100512f424873a549bb07ab7ff9f300fab8adf
LIBRETRO_DATABASE_SITE = $(call github,libretro,libretro-database,${LIBRETRO_DATABASE_VERSION})
LIBRETRO_DATABASE_LICENSE = CC-BY-SA-4.0
LIBRETRO_DATABASE_LICENSE_FILES = LICENSE

define LIBRETRO_DATABASE_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
        mkdir -p "${BINARIES_DIR}/retroarch/cursors"
        mkdir -p "${BINARIES_DIR}/retroarch/rdb"
        $(INSTALL) -D -m 0644  $(@D)/cursors/* "${BINARIES_DIR}/retroarch/cursors/"
	$(INSTALL) -D -m 0644 $(@D)/rdb/* "${BINARIES_DIR}/retroarch/rdb/"
endef

$(eval $(generic-package))
