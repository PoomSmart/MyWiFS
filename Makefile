DEBUG = 0
PACKAGE_VERSION = 0.0.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = MyWiFS
MyWiFS_FILES = Switch.xm Settings.m
MyWiFS_FRAMEWORKS = UIKit
MyWiFS_PRIVATE_FRAMEWORKS = BluetoothManager
MyWiFS_LIBRARIES = flipswitch
MyWiFS_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk