################################################################################
#
# python-keyboard
#
################################################################################

PYTHON_KEYBOARD_VERSION = 0.13.5
PYTHON_KEYBOARD_SOURCE = keyboard-$(PYTHON_KEYBOARD_VERSION).zip
PYTHON_KEYBOARD_SITE = https://files.pythonhosted.org/packages/79/75/c969f2258e908c39aadfc57d1cb78247dc49e6d36371bb3a48c194640c01
PYTHON_KEYBOARD_LICENSE = MIT
PYTHON_KEYBOARD_LICENSE_FILES = LICENSE
PYTHON_KEYBOARD_SETUP_TYPE = setuptools
define PYTHON_KEYBOARD_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_KEYBOARD_DL_DIR)/$(PYTHON_KEYBOARD_SOURCE)
	yes | cp -rf $(@D)/keyboard-0.13.5/* $(@D)/ 
endef
$(eval $(python-package))
