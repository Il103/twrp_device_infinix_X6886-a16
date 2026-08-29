# BoardConfig.mk - Infinix Hot 60 Pro Plus (x6886)
# Platform: MediaTek MT6789 (not Helio G100)
# Android: 16 (SDK 36, XOS 16)
# Recovery lives INSIDE vendor_boot (header v4) - NO standalone recovery.img
#
# All offsets/sizes derived from the real vendor_boot dump (unpack_bootimg.py)
# and cross-checked against a working recovery tree for the same device.

DEVICE_PATH := device/infinix/X6886

# ---------------- Architecture ----------------
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

# ---------------- Board ----------------
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Power
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Assert
TARGET_OTA_ASSERT_DEVICE := X6886

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mt6789
TARGET_NO_BOOTLOADER := true

# ---------------- Build hacks (needed for MTK prebuilt blobs) ----------------
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# Minimal manifest build
ALLOW_MISSING_DEPENDENCIES := true

# ---------------- Crypto / Decryption (FBE) ----------------
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_METADATA_PARTITION := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
TW_FORCE_KEYMASTER_VER := true

# ---------------- Vendor boot / Kernel ----------------
TARGET_KERNEL_ARCH := arm64
BOARD_RAMDISK_USE_LZ4 := true
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_NO_KERNEL := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
TW_LOAD_VENDOR_BOOT_MODULES := true
BOARD_KERNEL_BASE := 0x3FFF8000
BOARD_PAGE_SIZE := 4096
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_TAGS_OFFSET := 0x07c88000
BOARD_RAMDISK_OFFSET := 0x26F08000
BOARD_TAGS_OFFSET := 0x07C88000
BOARD_BOOT_HEADER_VERSION := 4
BOARD_DTB_SIZE := 183850
BOARD_DTB_OFFSET := 0x07C88000
BOARD_HEADER_SIZE := 2128
BOARD_VENDOR_BASE := 0x3fff8000
BOARD_VENDOR_CMDLINE := "bootopt=64S3,32N2,64N2 androidboot.selinux=permissive"
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# ---------------- Partitions ----------------
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864   # 64MB
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_PARTITION_LIST := system vendor product system_ext odm vendor_dlkm odm_dlkm
BOARD_MAIN_SIZE := 9017751552 # (BOARD_SUPER_PARTITION_SIZE - 100000000) headroom
BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_VENDOR_DLKMIMAGE := true

TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# ---------------- Hardware / Platform ----------------
BOARD_USES_MTK_HARDWARE := true
TARGET_BOARD_PLATFORM := mt6789

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# ---------------- Recovery fstab (from stock dump: fstab.emmc) ----------------
# Single active fstab the recovery reads. fstab.mt6789 is packed as a reference
# file but not set as the active fstab (avoids double-mount conflicts).
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/first_stage_ramdisk/fstab.emmc

# ---------------- Screen / Recovery UI (Material Design 2 is built into OF) ----------------
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_DENSITY := 420
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888   # from stock ro.minui.pixel_format
TARGET_NO_RECOVERY := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_NO_SCREEN_BLANK := true
TW_STATUS_ICONS_ALIGN := center
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/class/backlight/backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 200
TW_MAX_BRIGHTNESS := 2047
TWRP_NEW_THEME := true
TW_FORCE_NEW_GUI := true
TW_FRAMERATE := 120

# ---------------- Verified Boot ----------------
BOARD_AVB_ENABLE := true

# ---------------- Init ----------------
TARGET_INIT_VENDOR_LIB := libinit_X6886
TARGET_RECOVERY_DEVICE_MODULES := libinit_X6886

# ---------------- TWRP Configurations (OrangeFox) ----------------
RECOVERY_SDCARD_ON_DATA := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_PREPARE_DATA_MEDIA_EARLY := true
TW_USE_NEW_MINADBD := true
TW_EXCLUDE_APEX := true
TW_EXCLUDE_LPDUMP := true
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := en
TW_HAS_NO_DISPLAY_CUTOUT := false
TW_NO_LEGACY_PROPS := true
TW_NO_BIND_SYSTEM := true
TW_BACKUP_EXCLUSIONS := /data/fonts
TW_DEVICE_VERSION := Infinix_X6886
MAINTAINER := BERU
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.usb0/lun.%d/file
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

# StatusBar
TW_CUSTOM_CPU_POS := 300
TW_CUSTOM_CLOCK_POS := 70
TW_CUSTOM_BATTERY_POS := 790

# Fastbootd
TW_INCLUDE_FASTBOOTD := true

# Debug
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TWRP_EVENT_LOGGING := true
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace

# Tools
TW_INCLUDE_FB2PNG := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_LPTOOLS := true

# Filesystem features
TW_INCLUDE_NTFS_3G := true
TARGET_USES_MKE2FS := true
TW_INCLUDE_FUSE_NTFS := true
TW_INCLUDE_FUSE_EXFAT := true
TW_ENABLE_FS_COMPRESSION := false

# Haptic / Battery
TW_LOAD_VENDOR_MODULES := ""
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone53/temp"
TW_BATTERY_SYSFS_WAIT_SECONDS := 6

# Platform version override (keeps recovery self-contained)
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
