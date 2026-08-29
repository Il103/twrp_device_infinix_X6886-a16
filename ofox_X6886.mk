# ofox_X6886.mk - OrangeFox product makefile for Infinix Hot 60 Pro Plus
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# OrangeFox common config
$(call inherit-product, vendor/ofox/config/common.mk)

PRODUCT_NAME := ofox_X6886
PRODUCT_DEVICE := X6886
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix X6886
PRODUCT_MANUFACTURER := INFINIX

BUILD_FINGERPRINT := Infinix/X6886-OP/Infinix-X6886:16/BP2A.250605.031.A3/301400007:user/release-keys
PRIVATE_BUILD_DESC := sys_mssi_64_64only_cn_armv82-user 16 BP2A.250605.031.A3 149082 release-keys
