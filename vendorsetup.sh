#!/bin/bash
#
# vendorsetup.sh - Infinix HOT 60 Pro+ (X6886) - mt6789
# Maintainer : B E R U | Fox 14.1 | Android 16
#

FDEVICE="X6886"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then FOX_BUILD_DEVICE="$FDEVICE"
   else chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE); [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"; fi
}
if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then fox_get_target_device; fi

# ── OFOX BUILD ──
if [ "$1" = "ofox_X6886" -o "$FOX_BUILD_DEVICE" = "X6886" ]; then
    case "$1" in
        ofox*|"" )
        echo -e "\e[38;5;202m"
        cat << "EOF"

  ██████╗ ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗███████╗ ██████╗ ██╗  ██╗
 ██╔═══██╗██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝██╔════╝██╔═══██╗╚██╗██╔╝
 ██║   ██║██████╔╝███████║██╔██╗ ██║██║  ███╗█████╗  █████╗  ██║   ██║ ╚███╔╝
 ██║   ██║██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██╔══╝  ██║   ██║ ██╔██╗
 ╚██████╔╝██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗██║     ╚██████╔╝██╔╝ ██╗
  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝
              ╔══════════════════════════════════════════╗
              ║   OrangeFox  •  Fox 14.1  •  Android 16 ║
              ║   HOT 60 Pro+ • mt6789 • vendor_boot v4 ║
              ║   Maintainer : B E R U  •  64MB FIX     ║
              ╚══════════════════════════════════════════╝
EOF
        echo -e "\e[0m"
        echo -e "\e[1;38;5;214m [FOX] \e[37mFox 14.1 \e[38;5;208m│\e[37m VAB \e[38;5;208m│\e[37m LZMA+DRASTIC \e[32mREADY\e[0m"
        ;;
    esac

    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export FOX_BUILD_DEVICE="$FDEVICE"
    export OF_MAINTAINER="B E R U"
    export FOX_MAINTAINER_PATCH_VERSION="1"
    export FOX_VARIANT="A16"
    export FOX_BUILD_TYPE="Stable"
    export FOX_AB_DEVICE=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export OF_VIRTUAL_AB_DEVICE_WITH_SINGLETON=1
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export FOX_USE_DYNAMIC_PARTITIONS=1
    export OF_PATCH_AVB20=1
    export OF_KEEP_DM_VERITY=1
    export FOX_BUGGED_AOSP_ARB_WORKAROUND=1
    export FOX_RECOVERY_BOOT_PATCH_MTK=1
    # ── 64MB FIX MUST BE LAST ──
    export OF_USE_LZMA_COMPRESSION=1
    export FOX_DRASTIC_SIZE_REDUCTION=1
fi

# ── TWRP BUILD ──
if [ "$1" = "twrp_X6886" -o "$FOX_BUILD_DEVICE" = "X6886" ]; then
    case "$1" in
        twrp* )
        echo -e "\e[38;5;39m"
        cat << "EOF"

 ████████╗██╗    ██╗██████╗ ██████╗
 ╚══██╔══╝██║    ██║██╔══██╗██╔══██╗
    ██║   ██║ █╗ ██║██████╔╝██████╔╝
    ██║   ██║███╗██║██╔══██╗██╔═══╝
    ██║   ╚███╔███╔╝██║  ██║██║
    ╚═╝    ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝
              ╔══════════════════════════════════════════╗
              ║   TWRP 14.1  •  Fox 14.1  •  Android 16  ║
              ║   HOT 60 Pro+ • mt6789 • vendor_boot v4 ║
              ║   Maintainer : B E R U                  ║
              ╚══════════════════════════════════════════╝
EOF
        echo -e "\e[0m"
        echo -e "\e[1;38;5;39m [TWRP] \e[37m14.1 \e[38;5;208m│\e[37m VAB \e[32mREADY\e[0m"
        ;;
    esac
fi

add_lunch_combo twrp_X6886-eng
add_lunch_combo twrp_X6886-userdebug
add_lunch_combo ofox_X6886-eng
add_lunch_combo ofox_X6886-userdebug
