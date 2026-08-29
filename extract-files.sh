#!/bin/bash
# extract-files.sh - Infinix Hot 60 Pro Plus (x6886)
# Copies proprietary blobs from a local full firmware dump into proprietary/.
# Usage: ./extract-files.sh <path-to-dump>   (defaults to the cloned dump)

set -e
DEVICE=x6886
THISDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DUMP="${1:-/root/android-tools/x6886_dump}"

if [ ! -d "$DUMP" ]; then
    echo "ERROR: dump dir not found: $DUMP"
    echo "Usage: $0 <path-to-dump>"
    exit 1
fi

OUT="$THISDIR/proprietary"
mkdir -p "$OUT"

# proprietary-files.txt uses lines like:
#   system/lib64/libfoo.so|libfoo.so
#   vendor/lib64/libbar.so
# Everything before '|' is the source path inside the dump; after is dest name.
while IFS= read -r line; do
    [ -z "$line" ] && continue
    case "$line" in \#*) continue ;; esac
    src="${line%%|*}"
    dst="${line##*|}"
    [ "$dst" = "$line" ] && dst="$(basename "$src")"
    full="$DUMP/$src"
    if [ -f "$full" ]; then
        tgt="$OUT/$(dirname "$src")"
        mkdir -p "$tgt"
        cp -f "$full" "$tgt/$dst"
    else
        echo "MISSING: $src"
    fi
done < "$THISDIR/proprietary-files.txt"

echo "Done. Blobs copied to $OUT"
