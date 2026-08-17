# Copyright (C) 2026 The OrangeFox / TWRP Project
# SPDX-License-Identifier: Apache-2.0

# The OrangeFox build system lunches "omni_<device>-eng" by default.
# Provide this product so the combo resolves, inheriting the OrangeFox config.
$(call inherit-product, $(LOCAL_DIR)/ofox_X6886.mk)

PRODUCT_NAME := omni_X6886
