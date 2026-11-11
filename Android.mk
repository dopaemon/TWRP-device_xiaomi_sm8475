LOCAL_PATH := $(call my-dir)

ifneq ($(filter mayfly cupid zeus unicorn thor diting,$(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
