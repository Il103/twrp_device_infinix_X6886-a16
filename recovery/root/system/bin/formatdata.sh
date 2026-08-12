#!/system/bin/sh
#
# Format Data script for Infinix X6886 (MT6789/UFS, Android 16)
# FBE/metadata-encryption aware: formats /data f2fs and clears /metadata
# so keymint can re-provision. Uses TWRP 14.1 tools (mkfs.f2fs / mke2fs).
#

DATA_DEV=/dev/block/by-name/userdata
META_DEV=/dev/block/by-name/metadata
MKFS_F2FS=/system/bin/mkfs.f2fs
MKE2FS=/system/bin/mke2fs

log() {
    echo "formatdata: $1" > /dev/kmsg
    echo "[formatdata] $1"
}

# Step 1: Unmount /data and /metadata if mounted
log "Step 1: Unmounting /data and /metadata..."
umount /data 2>/dev/null
umount -l /data 2>/dev/null
umount /metadata 2>/dev/null
umount -l /metadata 2>/dev/null

# Step 2: Wait for block devices
log "Step 2: Waiting for block devices..."
i=0
while [ ! -b "$DATA_DEV" ] && [ $i -lt 30 ]; do
    sleep 1
    i=$((i + 1))
done
if [ ! -b "$DATA_DEV" ]; then
    log "ERROR: $DATA_DEV not found after 30s"
    exit 1
fi

# Step 3: Remove dm-crypt / dm-default-key mappings
log "Step 3: Removing dm mappings..."
if [ -d /dev/block/mapper ]; then
    for dm in /dev/block/mapper/*userdata* /dev/block/mapper/*data*; do
        [ -b "$dm" ] && dmsetup remove -f "$dm" 2>/dev/null
    done
fi

# Step 4: Format metadata (clears FBE keys; keymint v3 re-provisions)
log "Step 4: Formatting metadata..."
if [ -b "$META_DEV" ]; then
    if [ -x "$MKE2FS" ]; then
        $MKE2FS -t ext4 -F "$META_DEV" >/dev/null 2>&1
        [ $? -eq 0 ] && log "metadata formatted (mke2fs)" || log "mke2fs failed"
    else
        dd if=/dev/zero of="$META_DEV" bs=4096 count=1 2>/dev/null
        log "metadata zeroed"
    fi
else
    log "WARNING: metadata partition not found"
fi

# Step 5: Format userdata f2fs (stock-compatible features)
log "Step 5: Formatting userdata with f2fs..."
RESULT=1
if [ -x "$MKFS_F2FS" ]; then
    $MKFS_F2FS -f -l userdata -O encrypt,quota,fsverity,inlinecrypt -s 16 "$DATA_DEV" >/dev/null 2>&1
    RESULT=$?
elif [ -x /sbin/mkfs.f2fs ]; then
    /sbin/mkfs.f2fs -f -l userdata -O encrypt,quota,fsverity,inlinecrypt -s 16 "$DATA_DEV" >/dev/null 2>&1
    RESULT=$?
else
    log "WARNING: no mkfs.f2fs found, zeroing first blocks"
    dd if=/dev/zero of="$DATA_DEV" bs=4096 count=128 2>/dev/null
    RESULT=$?
fi

if [ $RESULT -eq 0 ]; then
    log "Format completed successfully!"
else
    log "ERROR: Format failed with code $RESULT"
    exit 1
fi

sync
log "Format data completed. Reboot recommended."
exit 0
