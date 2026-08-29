# vendorsetup.sh - Infinix Hot 60 Pro Plus (x6886)
# OrangeFox build flags for fox_14.1 (Android 16 / XOS 16)
# Reference: kinguser981/OrangeFox-Recovery-Flags
#
# Lunch combo MUST match PRODUCT_NAME (ofox_X6886) in ofox_X6886.mk.
# Format: <product>-<build-id>-<variant>  (bp2a = Android 16)

# Lunch combos
add_lunch_combo ofox_X6886-bp2a-eng
add_lunch_combo ofox_X6886-bp2a-userdebug

# ----- OrangeFox core flags -----
export FOX_VENDOR_BOOT_RECOVERY=1          # build recovery as vendor_boot (hdr4)
export FOX_RECOVERY_VENDOR_BOOT_PARTITION=vendor_boot
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1             # fixes splash / orange-screen / reboot
export FOX_RECOVERY_INSTALL_PARTITION=vendor_boot

# ----- Verified size-reduction / debloat flags (confirmed working) -----
export OF_USE_LZMA_COMPRESSION=1           # smaller ramdisk than LZ4 (helps fit 64MB)
export FOX_DRASTIC_SIZE_REDUCTION=1        # strip non-essential recovery bits
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1  # not a Xiaomi device

# ----- Languages: English default + Indonesian -----
export TW_DEFAULT_LANGUAGE=en
export TW_EXTRA_LANGUAGES=in

# ----- Prebuilt kernel (use stock dtb, no kernel config rebuild) -----
export OF_FORCE_PREBUILT_KERNEL=1
export FOX_USE_TWRP_SUPER_RAMDISK=1
