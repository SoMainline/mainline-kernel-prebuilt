# Copyright 2015 The Android Open Source Project
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

# Whenever this prebuilt configuration exists, forcefully
# disable inline kernel building:
BUILD_KERNEL := false

ifeq ($(BUILD_KERNEL),false)

platform := $(TARGET_BOARD_PLATFORM)

TARGET_PLATFORM ?= $(SOMC_PLATFORM)

local_kernel := $(KERNEL_PATH)/common-kernel/Image.gz
local_dtb    := $(KERNEL_PATH)/common-kernel/$(platform)-sony-xperia-$(TARGET_PLATFORM)-$(TARGET_DEVICE:-mainline=).dtb

# PRODUCT_OUT is not defined yet:
out/target/product/$(TARGET_DEVICE)/kernel: $(local_kernel) $(local_dtb)
	cat $^ >$@

endif
