################################################################################
#
# dialog
#
################################################################################

DIALOG_VERSION = 20230209
DIALOG_SITE = $(call github,ThomasDickey,dialog-snapshots,t$(DIALOG_VERSION))
DIALOG_DEPENDENCIES = host-pkgconf ncurses $(TARGET_NLS_DEPENDENCIES)
DIALOG_LICENSE = LGPL-2.1
DIALOG_LICENSE_FILES = COPYING

ifneq ($(BR2_ENABLE_LOCALE),y)
DIALOG_DEPENDENCIES += libiconv
endif

ifneq ($(BR2_PACKAGE_NCURSES_WCHAR),y)
DIALOG_CONF_OPTS = --with-ncurses
else
DIALOG_CONF_OPTS = --with-ncursesw --enable-widec
endif

DIALOG_CONF_OPTS += --with-curses-dir=$(STAGING_DIR)/usr \
	--disable-rpath-hack
DIALOG_CONF_OPTS += NCURSES_CONFIG=$(STAGING_DIR)/usr/bin/$(NCURSES_CONFIG_SCRIPTS)

$(eval $(autotools-package))
