################################################################################
#
# sdl_net
#
################################################################################

# The latest officially released version of SDL_image is 1.2.8, released in 2012.
# Since then, there have been several bugfixes.
#
# This commit points to the SDL-1.2 branch from 23 Apr 2024.
SDL_NET_VERSION = 0043be2e559f8d562d04bf62d6e3f4162ed8edad
SDL_NET_SITE = $(call github,libsdl-org,SDL_net,$(SDL_NET_VERSION))
SDL_NET_SOURCE = SDL_net-$(SDL_NET_VERSION).tar.gz
SDL_NET_LICENSE = Zlib
SDL_NET_LICENSE_FILES = COPYING

SDL_NET_CONF_OPTS = \
	--with-sdl-prefix=$(STAGING_DIR)/usr \
	--with-sdl-exec-prefix=$(STAGING_DIR)/usr

SDL_NET_INSTALL_STAGING = YES

SDL_NET_DEPENDENCIES = sdl

$(eval $(autotools-package))
