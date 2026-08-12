#
# Copyright (C) 2026 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/infinix/X6886

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Device identifier
PRODUCT_DEVICE := X6886
PRODUCT_NAME := twrp_X6886
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := X6886
PRODUCT_MANUFACTURER := Infinix
PRODUCT_RELEASE_NAME := Infinix HOT 60 Pro Plus
