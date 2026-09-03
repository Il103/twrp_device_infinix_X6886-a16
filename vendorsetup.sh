# vendorsetup.sh - Infinix Hot 60 Pro Plus (x6886)
# OrangeFox Recovery - fox_12.1 (R12)
#
# Device: Transsion (Infinix) MT6789
# Recovery: vendor_boot (header v4)
#
# Lunch combo must match PRODUCT_NAME in ofox_X6886.mk

add_lunch_combo ofox_X6886-bp2a-eng
add_lunch_combo ofox_X6886-bp2a-userdebug

# Core flags for vendor_boot header v4
export FOX_VENDOR_BOOT_RECOVERY=1
export FOX_RECOVERY_VENDOR_BOOT_PARTITION=vendor_boot
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_RECOVERY_INSTALL_PARTITION=vendor_boot

# Handle stock platform ramdisk (ramdisk.cpio) via callback script
export FOX_LOCAL_CALLBACK_SCRIPT=device/infinix/X6886/ramdisk_callback.sh

# Size reduction (required to fit inside 64MB vendor_boot)
export OF_USE_LZMA_COMPRESSION=1
export FOX_DRASTIC_SIZE_REDUCTION=1

# Non-MIUI / Transsion device
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
export FOX_VANILLA_BUILD=1

# Display / cutout fixes
export OF_STATUS_H=144
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_HIDE_NOTCH=0
export TW_HAS_NO_DISPLAY_CUTOUT=false

# Languages
export TW_DEFAULT_LANGUAGE=en
export TW_EXTRA_LANGUAGES=in

# Use prebuilt kernel and DTB from dump
export OF_FORCE_PREBUILT_KERNEL=1
export FOX_USE_TWRP_SUPER_RAMDISK=1

# Android 16 FBE handling
export OF_SKIP_FBE_DECRYPTION_SDKVERSION=36
