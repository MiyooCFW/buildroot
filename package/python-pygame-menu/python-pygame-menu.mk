################################################################################
#
# python-pygame-menu
#
################################################################################

PYTHON_PYGAME_MENU_VERSION = 4.4.3
PYTHON_PYGAME_MENU_SITE = $(call github,ppizarror,pygame-menu,$(PYTHON_PYGAME_MENU_VERSION))
PYTHON_PYGAME_MENU_LICENSE = MIT
PYTHON_PYGAME_MENU_LICENSE_FILES = LICENSE
PYTHON_PYGAME_MENU_SETUP_TYPE = setuptools

$(eval $(python-package))
