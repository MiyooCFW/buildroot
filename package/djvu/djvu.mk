################################################################################
#
# DjVuLibre
#
################################################################################

DJVU_VERSION = 3.5.24
DJVU_SITE = https://sourceforge.net/projects/djvu/files/DjVuLibre/$(DJVU_VERSION)
DJVU_SOURCE = djvulibre-$(DJVU_VERSION).tar.gz
DJVU_LICENSE = GPL-2.0+
DJVU_LICENSE_FILES = COPYING COPYRIGHT

DJVU_INSTALL_STAGING = YES
DJVU_AUTORECONF = YES
DJVU_DEPENDENCIES = tiff jpeg

$(eval $(autotools-package))
