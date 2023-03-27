JOY2KEY_VERSION = origin/master
JOY2KEY_SITE_METHOD = git
JOY2KEY_SITE = https://github.com/joolswills/joy2key.git
JOY2KEY_AUTORECONF = YES
JOY2KEY_CONF_OPTS = --disable-X
$(eval $(autotools-package))