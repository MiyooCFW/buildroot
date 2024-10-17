################################################################################
#
# SDLbook
#
################################################################################

SDLBOOK_VERSION = d0c4df8edf8df4f96312641ebf4d25d5b0b042fe
SDLBOOK_SITE_METHOD = git
SDLBOOK_SITE = https://github.com/rofl0r/SDLBook
SDLBOOK_LICENSE = GPL-3.0
SDLBOOK_LICENSE_FILES = COPYING
SDLBOOK_DEPENDENCIES = \
	sdl \
	djvu \
	mupdf \
	tiff

define SDLBOOK_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CFLAGS="-DMIYOO -Ofast -DRENDER_ONEPAGE" -C $(@D)
endef

define SDLBOOK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/sdlbook $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
