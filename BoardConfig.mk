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

# ==========================================
# Target Architecture (ARM64)
# ==========================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_IS_64_BIT := true
TARGET_USES_64_BIT_BINDER := true
TARGET_BOARD_SUFFIX := _64

# ==========================================
# Board Info & Platform
# ==========================================
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_BOARD_PLATFORM := mt6789
BOARD_USES_MTK_HARDWARE := true
TARGET_OTA_ASSERT_DEVICE := X6886

# ==========================================
# Power & CPU
# ==========================================
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# ==========================================
# Bootloader & Kernel
# ==========================================
TARGET_BOOTLOADER_BOARD_NAME := mt6789
TARGET_NO_BOOTLOADER := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_NO_KERNEL := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_USES_GENERIC_KERNEL_IMAGE := true

# ==========================================
# Build Hack
# ==========================================
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# ==========================================
# Building with minimal manifest
# ==========================================
ALLOW_MISSING_DEPENDENCIES := true

# ==========================================
# Vendor Boot (Header v4) - PATCHED FOR 64MB
# ==========================================
BOARD_RAMDISK_USE_LZMA := true
BOARD_RAMDISK_USE_LZ4 := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
TW_LOAD_VENDOR_BOOT_MODULES := true
BOARD_KERNEL_BASE := 0x3FFF8000
BOARD_PAGE_SIZE := 4096
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x26F08000
BOARD_TAGS_OFFSET := 0x07C88000
BOARD_BOOT_HEADER_VERSION := 4
BOARD_DTB_SIZE := 183850
BOARD_DTB_OFFSET := 0x07C88000
BOARD_HEADER_SIZE := 2128
BOARD_VENDOR_CMDLINE := "bootopt=64S3,32N2,64N2 androidboot.selinux=permissive"

BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# ==========================================
# Dynamic Partitions (VAB) & Filesystems
# ==========================================
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm odm_dlkm system_dlkm tr_region tr_company tr_carrier tr_product tr_preload tr_overlayfs tr_misc
BOARD_MAIN_SIZE := 9017751552 # (BOARD_SUPER_PARTITION_SIZE - 100000000) headroom

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_VENDOR_DLKMIMAGE := true

# ==========================================
# FBE Decryption (Crypto)
# ==========================================
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_METADATA_PARTITION := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2

# Fixed Platform Version for Decryption Match
PLATFORM_VERSION := 14
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# ==========================================
# System Properties & Init
# ==========================================
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_INIT_VENDOR_LIB := libinit_X6886
TARGET_RECOVERY_DEVICE_MODULES := libinit_X6886

# ==========================================
# Recovery, Display & Build Hacks
# ==========================================
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_NO_RECOVERY := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_AVB_ENABLE := true

# Resolution (1080x2400 AMOLED, density 420)
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_DENSITY := 420
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888

# Build Hacks for Dependencies
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# ==========================================
# TWRP Specific Configurations
# ==========================================
MAINTAINER := B E R U
TW_DEVICE_VERSION := Infinix_X6886

TW_FRAMERATE := 120
TW_NO_SCREEN_BLANK := true
TW_STATUS_ICONS_ALIGN := center
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := /sys/class/backlight/backlight/brightness
TW_DEFAULT_BRIGHTNESS := 200
TW_MAX_BRIGHTNESS := 2047
TWRP_NEW_THEME := true
RECOVERY_SDCARD_ON_DATA := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_PREPARE_DATA_MEDIA_EARLY := true
TW_USE_NEW_MINADBD := true
TW_EXCLUDE_APEX := true
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := ar
TW_HAS_NO_DISPLAY_CUTOUT := false
TW_NO_LEGACY_PROPS := true
TW_NO_BIND_SYSTEM := true
TW_BACKUP_EXCLUSIONS := /data/fonts
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.usb0/lun.%d/file
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

# TWRP Features & Tools - KEEP FASTBOOTD AS REQUESTED
TW_INCLUDE_FASTBOOTD := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_LPTOOLS := true
TW_INCLUDE_NTFS_3G := true
TARGET_USES_MKE2FS := true
TW_INCLUDE_FUSE_NTFS := true
TW_INCLUDE_FUSE_EXFAT := true

# Haptics & Battery
TW_LOAD_VENDOR_MODULES := ""
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_CUSTOM_CPU_TEMP_PATH := /sys/class/thermal/thermal_zone53/temp
TW_BATTERY_SYSFS_WAIT_SECONDS := 6

# Debugging
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TWRP_EVENT_LOGGING := true

# ==========================================
# OrangeFox Recovery Configurations
# ==========================================
# These flags load ONLY when building OrangeFox
ifeq ($(OFOX_BUILD), true)
    
    OFOX_MAINTAINER := "B E R U"
    OFOX_DEVICE := "Infinix Hot 60 Pro Plus"
    
    # Notch/Cutout Configurations (Adjust if UI overlaps camera)
    OFOX_STATUSBAR_RIGHT_MARGIN := 40
    OFOX_STATUSBAR_LEFT_MARGIN := 40
    
    # MediaTek specific fixes for OrangeFox
    FOX_BUGGED_AOSP_ARB_WORKAROUND := true
    FOX_RECOVERY_BOOT_PATCH_MTK := true
    
    # Virtual A/B (VAB) Fixes
    FOX_VIRTUAL_AB_DEVICE := true
    FOX_RECOVERY_SYSTEM_PARTITION := "/system"
    FOX_RECOVERY_VENDOR_PARTITION := "/vendor"
    FOX_USE_DYNAMIC_PARTITIONS := true
    
    # Advanced Security & Decryption (FBE)
    FOX_USE_DATA_RECOVERY_FOR_SETTINGS := true
    FOX_ADVANCED_SECURITY := true
    FOX_R_PROPS_MODULE := true
    
    # OrangeFox Tools & Features - KEEP ALL
    FOX_ENABLE_APP_MANAGER := true
    FOX_USE_BASH_SHELL := true
    FOX_ASH_IS_BASH := true
    FOX_USE_NANO_EDITOR := true
    FOX_USE_TAR_BINARY := true
    FOX_USE_SED_BINARY := true
    FOX_USE_XZ_UTILS := true
    FOX_USE_ZSTD_BINARY := true
    
    # Auto-generate Flashable ZIP & Minor Fixes
    FOX_GENERATE_FLASHABLE_ZIP := true
    OFOX_ALLOW_FRONT_CAMERA_ON_START := true
    FOX_DELETE_AROMAFM := true
    FOX_REMOVE_AAPT := true

    # ---- Flashlight (MTK torch sysfs path from dump selinux contexts) ----
    OF_FLASHLIGHT_ENABLE := 1
    OF_FL_PATH1 := /sys/devices/virtual/flashlight_core/flashlight/flashlight_torch

    # ---- Boot-critical flags for fox_14.1 (prebuilt kernel + VAB) ----
    OF_FORCE_PREBUILT_KERNEL := 1
    OF_USE_AIDL_BOOT_CONTROL := 1

    # ---- PATCH FOR 64MB LIMIT - MUST BE LAST ----
    OF_USE_LZMA_COMPRESSION := 1
    FOX_DRASTIC_SIZE_REDUCTION := 1

endif
