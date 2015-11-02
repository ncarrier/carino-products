###############################################################################
## @file product.mk
##
## Base alchemy configuration for the obstination vehicle
###############################################################################

OBSTINATION_CONFIG_DIR := $(call my-dir)

TARGET_OS := linux
# TODO modify alchemy to be able to avoid parrot specific things here
TARGET_OS_FLAVOUR := parrot
TARGET_LIBC := eglibc
TARGET_ARCH := arm
# TODO modify alchemy to be able to avoid parrot specific things here
TARGET_CPU := p7
TARGET_CROSS := /usr/bin/arm-linux-gnueabi-

# Add Base skeleton
TARGET_SKEL_DIRS += $(OBSTINATION_CONFIG_DIR)/../skel

# TODO understand the next two
# Activate .alchemy.depends section generation
TARGET_ADD_DEPENDS_SECTION := 1

# Activate .alchemy.build-id section generation
TARGET_ADD_BUILDID_SECTION := 1

# the image target is used by gen_deb.sh
TARGET_IMAGE_FORMAT := ext2
TARGET_IMAGE_OPTIONS := --size 60M

custom.busybox.config := $(OBSTINATION_CONFIG_DIR)/busybox.config
custom.linux.config := $(OBSTINATION_CONFIG_DIR)/linux.config

# TODO reenable when logwrapping will be useful
#RELOG_FORCE_DEFAULT_OUTPUT_TO := /dev/ulog_main
#RELOG_FORCE_DEFAULT_ERROR_TO := /dev/ulog_main

