# add missing libc files to

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libc_fix
LOCAL_MODULE_FILENAME := $(LOCAL_MODULE).done

_libc_fix_missing := \
	libm.so.6 \
	libpthread.so.0 \
	libc.so.6 \
	libstdc++.so.6 \
	ld-linux.so.3

_libc_fix_missing_staging := \
	$(foreach __f,$(_libc_fix_missing),$(TARGET_OUT_STAGING)/lib/$(__f) \
)

_libc_fix_build_dir := $(call local-get-build-dir)

$(_libc_fix_missing_staging):
	(target=$$($(TARGET_CROSS)gcc -print-file-name=$(notdir $@)); \
	$(PRIVATE_PATH)/../../../../tools/install.py $@ $${target})

# Register 'installed' file in build system
$(_libc_fix_build_dir)/$(LOCAL_MODULE_FILENAME): $(_libc_fix_missing_staging)

LOCAL_CLEAN_FILES += $(_libc_fix_missing_staging)

# Make sure this is the first module built
TARGET_GLOBAL_PREREQUISITES += $(_libc_fix_build_dir)/$(LOCAL_MODULE_FILENAME)

# Prebuilt so it is always enabled and does not appear in config
include $(BUILD_PREBUILT)
