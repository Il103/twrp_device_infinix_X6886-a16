# BoardConfig.mk - Infinix Hot 60 Pro Plus (x6886)
# Platform: MediaTek MT6789 (not Helio G100)
# Android: 16 (SDK 36, XOS 16)
# Recovery lives INSIDE vendor_boot (header v4) - NO standalone recovery.img
#
# All offsets/sizes below are derived from the real vendor_boot dump
# (unpack_bootimg.py) + cross-checked against a working PBRP tree for the
# same device. Do NOT edit blindly.

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := cortex-a75
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_VARIANT := cortex-a75

# --- Kernel / ramdisk / dtb load layout (relative to KERNEL_BASE 0x3FFF8000) ---
BOARD_KERNEL_BASE := 0x3FFF8000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x26F08000     # ramdisk load 0x66f00000
BOARD_TAGS_OFFSET := 0x07C88000
BOARD_DTB_OFFSET := 0x07C88000         # dtb load 0x47c80000
BOARD_DTB_SIZE := 183850               # real dtb size from unpack
BOARD_HEADER_SIZE := 2128
BOARD_KERNEL_PAGESIZE := 4096
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version 4
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_VENDOR_CMDLINE := "bootopt=64S3,32N2,64N2 androidboot.selinux=permissive"
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)

# --- Verified Boot ---
BOARD_AVB_ENABLE := true

# --- Recovery fstab (from stock dump: fstab.emmc) ---
# This is the single active fstab the recovery reads. fstab.mt6789 is also
# packed into the ramdisk as a reference file but is NOT set as the active
# fstab (avoids double-mount / conflicting entries at boot).
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/first_stage_ramdisk/fstab.emmc

# --- Init vendor lib (device-specific property overrides) ---
TARGET_INIT_VENDOR_LIB := libinit_X6886
TARGET_RECOVERY_DEVICE_MODULES := libinit_X6886

# --- Screen / recovery UI ---
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_DENSITY := 420
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_NO_SCREEN_BLANK := true
TW_STATUS_ICONS_ALIGN := center
TW_BRIGHTNESS_PATH := "/sys/class/backlight/backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 200
TW_MAX_BRIGHTNESS := 2047
TWRP_NEW_THEME := true

# --- vendor_boot-as-recovery: the recovery is packed into vendor_boot ---
TARGET_NO_RECOVERY := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

# Prebuilt DTB (extracted from stock vendor_boot, 64-byte MTK header stripped)
TARGET_PREBUILT_DTB := $(LOCAL_PATH)/prebuilt/dtb.img

# --- Partition sizes ---
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864   # 64MB - matches vendor_boot partition
BOARD_FLASH_BLOCK_SIZE := 131072

# --- SoC / vendor hardware ---
BOARD_USES_MTK_HARDWARE := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_USES_MTK_HOME_BUTTON := false

# --- Recovery graphics ---
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"   # from stock ro.minui.pixel_format
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_THEME := portrait_hdpi
TW_FRAMERATE := 120
TW_SCREEN_WIDTH := 1080
TW_SCREEN_HEIGHT := 2400
TW_DEFAULT_LANGUAGE := en
TW_EXTRA_LANGUAGES := in

# --- Dynamic / Virtual A/B ---
AB_OTA_UPDATER := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_HAS_LARGE_FILETABLE := true

# --- Allow the MTK prebuilt blobs (needed; we de-dup properly in setup-makefiles) ---
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Build only the recovery, not a full ROM
BUILD_TINY_ANDROID := true
