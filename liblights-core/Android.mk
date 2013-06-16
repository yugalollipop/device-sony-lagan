LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := liblights-core
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES += liblights_dummy.c
include $(BUILD_SHARED_LIBRARY)
