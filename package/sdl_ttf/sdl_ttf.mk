################################################################################
#
# sdl_ttf
#
################################################################################

# There is unlikely to be a new SDL_ttf release for the foreseeable future:
# https://bugzilla.libsdl.org/show_bug.cgi?id=5344#c1
#
# This commit points to the SDL-1.2 branch from 23 Apr 2024.
SDL_TTF_VERSION = 3c4233732b94ce08d5f6a868e597af39e13f8b23
SDL_TTF_SITE = $(call github,libsdl-org,SDL_ttf,$(SDL_TTF_VERSION))
SDL_TTF_LICENSE = Zlib
SDL_TTF_LICENSE_FILES = COPYING

SDL_TTF_INSTALL_STAGING = YES
SDL_TTF_DEPENDENCIES = sdl freetype
SDL_TTF_CONF_OPTS = \
	--without-x \
	--with-freetype-prefix=$(STAGING_DIR)/usr \
	--with-sdl-prefix=$(STAGING_DIR)/usr

SDL_TTF_MAKE_OPTS = \
	INCLUDES="-I$(STAGING_DIR)/usr/include/SDL" \
	LDFLAGS="-L$(STAGING_DIR)/usr/lib"

$(eval $(autotools-package))
