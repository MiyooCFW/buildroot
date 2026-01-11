LIBRETRO_DATABASE_VERSION = fbcc8c1c24d8b20b6aaca95b4da6a2f39ad85f05
LIBRETRO_DATABASE_SITE = $(call github,libretro,libretro-database,${LIBRETRO_DATABASE_VERSION})
LIBRETRO_DATABASE_LICENSE = CC-BY-SA-4.0
LIBRETRO_DATABASE_LICENSE_FILES = LICENSE

define LIBRETRO_DATABASE_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
        mkdir -p "${BINARIES_DIR}/retroarch/database/cursors"
        mkdir -p "${BINARIES_DIR}/retroarch/database/rdb"
        $(INSTALL) -D -m 0644  $(@D)/cursors/* "${BINARIES_DIR}/retroarch/database/cursors/"
	$(INSTALL) -D -m 0644 $(@D)/rdb/* "${BINARIES_DIR}/retroarch/database/rdb/"
endef

$(eval $(generic-package))
