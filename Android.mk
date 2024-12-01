# Copyright (C) 2007 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

# TARGET_RECOVERY_UI_LIB should be one of librecovery_ui_{default,wear,vr,ethernet} or a
# device-specific module that defines make_device() and the exact RecoveryUI class for the
# target. It defaults to librecovery_ui_default, which uses ScreenRecoveryUI.
TARGET_RECOVERY_UI_LIB ?= librecovery_ui_default

# librecovery_ui_ext (shared library)
# ===================================
include $(CLEAR_VARS)

LOCAL_MODULE := librecovery_ui_ext
LOCAL_LICENSE_KINDS := SPDX-license-identifier-Apache-2.0 SPDX-license-identifier-MIT SPDX-license-identifier-OFL
LOCAL_LICENSE_CONDITIONS := by_exception_only notice
LOCAL_NOTICE_FILE := $(LOCAL_PATH)/NOTICE

# LOCAL_MODULE_PATH for shared libraries is unsupported in multiarch builds.
LOCAL_MULTILIB := first

ifeq ($(TARGET_IS_64_BIT),true)
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/lib64
else
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/lib
endif

LOCAL_WHOLE_STATIC_LIBRARIES := \
    $(TARGET_RECOVERY_UI_LIB)

LOCAL_SHARED_LIBRARIES := \
    libbase.recovery \
    libboot_control_client.recovery \
    liblog.recovery \
    librecovery_ui.recovery

include $(BUILD_SHARED_LIBRARY)
