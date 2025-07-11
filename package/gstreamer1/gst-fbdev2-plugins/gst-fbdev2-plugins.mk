################################################################################
#
# gst-fbdev2-plugins
#
################################################################################

GST_FBDEV2_PLUGINS_VERSION = d576ab21adbb5eacb1000a89fbaea14576784b10
GST_FBDEV2_PLUGINS_SITE = $(call github,hglm,gst-fbdev2-plugins,$(GST_FBDEV2_PLUGINS_VERSION))

GST_FBDEV2_PLUGINS_LICENSE = LGPL-2.1
GST_FBDEV2_PLUGINS_LICENSE_FILES = COPYING
GST_FBDEV2_PLUGINS_DEPENDENCIES = gstreamer1 gst1-plugins-base gst-omx libglib2 libdrm libtool
GST_FBDEV2_PLUGINS_AUTORECONF = YES

$(eval $(autotools-package))
