###############################################################################
## @file product.mk
##
## Base alchemy configuration for the obstination vehicle
###############################################################################

OBSTINATION_PC_CONFIG_DIR := $(call my-dir)
COMMON_DIR := $(OBSTINATION_PC_CONFIG_DIR)/../../common

TARGET_OS_FLAVOUR := native-chroot
TARGET_LIBC := native
# Detect the host architecture to set the right TARGET_ARCH.
ifeq ($(shell getconf LONG_BIT),32)
TARGET_ARCH := x86
LINUX_DEFAULT_CONFIG_TARGET := i86_defconfig
OPENSSL_CONFIG_NAME := linux-generic32
else
TARGET_ARCH := x64
LINUX_DEFAULT_CONFIG_TARGET := x86_64_defconfig
OPENSSL_CONFIG_NAME := linux-x86_64
endif
TARGET_CPU :=

# Add Base skeleton
TARGET_SKEL_DIRS += $(COMMON_DIR)/skel
TARGET_SKEL_DIRS += $(OBSTINATION_PC_CONFIG_DIR)/../skel
# TODO understand the next two
# Activate .alchemy.depends section generation
TARGET_ADD_DEPENDS_SECTION := 1

# Activate .alchemy.build-id section generation
TARGET_ADD_BUILDID_SECTION := 1

# the image target is used by gen_deb.sh
TARGET_IMAGE_FORMAT := ext2
TARGET_IMAGE_OPTIONS := --size 60M

custom.busybox.config := $(COMMON_DIR)/config/busybox.config
LINUX_CONFIG_FILE := $(OBSTINATION_PC_CONFIG_DIR)/linux.config

# tell alchemy we want to build a user mode linux kernel
TARGET_LINUX_ARCH := um

TARGET_NOSTRIP_FINAL := 1

# TODO reenable when logwrapping will be useful
#RELOG_FORCE_DEFAULT_OUTPUT_TO := /dev/ulog_main
#RELOG_FORCE_DEFAULT_ERROR_TO := /dev/ulog_main

