#!/sbin/sh
# formatdata.sh - Infinix Hot 60 Pro Plus (x6886)
# Wipes /data properly for FBE devices:
#  - unmounts /data and /metadata
#  - reformats userdata (f2fs) + metadata (ext4) so encryption is reset cleanly
#  - re-mounts so TWRP/FOX can continue
#
# Called from init on a "format data" request (see init.format.rc).

LOG=/tmp/formatdata.log
echo "formatdata: start" >> $LOG

# Make sure nothing holds the partitions
umount /data 2>/dev/null
umount /metadata 2>/dev/null
umount /sdcard 2>/dev/null

# Wipe metadata + userdata block devices
DATA_DEV=$(ls -l /dev/block/by-name/userdata 2>/dev/null | awk '{print $NF}')
META_DEV=$(ls -l /dev/block/by-name/metadata 2>/dev/null | awk '{print $NF}')

if [ -z "$DATA_DEV" ]; then
    DATA_DEV=/dev/block/by-name/userdata
fi
if [ -z "$META_DEV" ]; then
    META_DEV=/dev/block/by-name/metadata
fi

echo "formatdata: data=$DATA_DEV meta=$META_DEV" >> $LOG

# Format metadata (ext4) then userdata (f2fs)
make_ext4fs -w -S /file_contexts -L metadata $META_DEV 2>> $LOG
mke2fs -t ext4 -b 4096 $META_DEV 2>> $LOG

# f2fs userdata (matches stock fstab type)
mkfs.f2fs -f $DATA_DEV 2>> $LOG

echo "formatdata: done" >> $LOG
exit 0
