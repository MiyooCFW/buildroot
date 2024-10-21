################################################################################
#
# python-keyboard
#
################################################################################

PYTHON_KEYBOARD_VERSION = 0.13.5
PYTHON_KEYBOARD_SITE = $(call github,boppreh,keyboard,v$(PYTHON_KEYBOARD_VERSION))
PYTHON_KEYBOARD_LICENSE = MIT
PYTHON_KEYBOARD_LICENSE_FILES = LICENSE.txt
PYTHON_KEYBOARD_SETUP_TYPE = setuptools

$(eval $(python-package))
