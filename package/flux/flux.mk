################################################################################
#
# flux
#
################################################################################

FLUX_VERSION = e45758aa9384b9740ff021ea952399fd113eb0e9
FLUX_SITE = https://github.com/deniskropp/flux.git
FLUX_SITE_METHOD = git
FLUX_LICENSE = GPL-3
FLUX_AUTORECONF = YES
HOST_FLUX_DEPENDENCIES = host-pkgconf

$(eval $(host-autotools-package))

