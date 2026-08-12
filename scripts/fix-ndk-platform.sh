#!/bin/bash
# Fix for TWRP 14.1 minimal manifest build error:
#   FAILED: ninja: '.../android.security.apc-ndk_platform.so.toc', needed by '.../libtar.so', missing and no known rule to make it
#
# The minimal manifest does not generate the "_platform" variant of AIDL NDK libs.
# This is the official TWRP fix: use the plain "-ndk" names (already used by
# bootable/recovery/prebuilt/Android.mk).
#
# Run from the root of the AOSP tree (where bootable/ lives):
#   bash scripts/fix-ndk-platform.sh
set -e

FILES=(
  "bootable/recovery/libtar/Android.mk"
  "bootable/recovery/Android.mk"
)

for f in "${FILES[@]}"; do
  if [ ! -f "$f" ]; then
    echo "SKIP: $f not found"
    continue
  fi
  echo "Fixing $f"
  sed -i 's/android\.security\.apc-ndk_platform/android.security.apc-ndk/g' "$f"
  sed -i 's/android\.system\.keystore2-V1-ndk_platform/android.system.keystore2-V1-ndk/g' "$f"
  sed -i 's/android\.security\.authorization-ndk_platform/android.security.authorization-ndk/g' "$f"
  sed -i 's/android\.security\.maintenance-ndk_platform/android.security.maintenance-ndk/g' "$f"
done

echo "Done. Rebuild with:"
echo "  mka vendorbootimage"
