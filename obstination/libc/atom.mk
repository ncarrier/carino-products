# add missing libc files to the rootfs

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libc_fix
LOCAL_MODULE_FILENAME := $(LOCAL_MODULE).done

_libc_fix_missing := \
	libm.so.6 \
	libpthread.so.0 \
	libc.so.6 \
	libstdc++.so.6 \
	ld-linux.so.3 \
	libdl.so.2 \
	librt.so.1 \
	libgcc_s.so.1

_libc_fix_missing_staging := \
	$(foreach __f,$(_libc_fix_missing),$(TARGET_OUT_STAGING)/lib/$(__f) \
)

_libc_fix_build_dir := $(call local-get-build-dir)

$(_libc_fix_missing_staging):
	$(Q) (target=$$($(TARGET_CROSS)gcc -print-file-name=$(notdir $@)); \
		$(PRIVATE_PATH)/install.py $@ $${target})

$(_libc_fix_build_dir)/$(LOCAL_MODULE_FILENAME): $(_libc_fix_missing_staging)

LOCAL_CLEAN_FILES += $(_libc_fix_missing_staging)

include $(BUILD_PREBUILT)
