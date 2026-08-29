# Device Tree: Infinix Hot 60 Pro Plus (x6886)

OrangeFox Recovery device tree for the **Infinix Hot 60 Pro Plus** (codename **x6886**).

> Built from a full firmware dump and cross-checked against the device's
> stock `fstab.*`, vendor HALs, kernel modules and Trustonic TEE blobs.
> All device-specific binaries are sourced from the stock dump, not from
> third-party trees.

---

## Device specifications

| Feature        | Details                                      |
|----------------|----------------------------------------------|
| Codename       | `x6886` (X6886-OP)                           |
| Manufacturer   | Infinix (Transsion Group)                    |
| Platform       | MediaTek MT6789                              |
| CPU            | 2× Cortex-A76 + 6× Cortex-A55                |
| GPU            | ARM Mali-G57 MC2                             |
| Architecture   | arm64-v8a                                    |
| Android        | 16 (SDK 36, XOS 16)                          |
| Kernel         | 6.12.38 (GKI)                                |
| Build          | BP2A.250605.031.A3                           |
| Partition type | A/B, Dynamic (super), Treble                 |
| Recovery       | Packed inside `vendor_boot` (header v4)      |

---

## Key build parameters (from the dump)

| Parameter                         | Value              |
|-----------------------------------|--------------------|
| `BOARD_KERNEL_BASE`               | `0x3FFF8000`      |
| `BOARD_RAMDISK_OFFSET`            | `0x26F08000`      |
| `BOARD_DTB_OFFSET`                | `0x07C88000`      |
| `BOARD_DTB_SIZE`                  | `183850`           |
| `BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE` | `67108864` (64 MB) |
| `TARGET_RECOVERY_PIXEL_FORMAT`    | `BGRA_8888`       |
| `TARGET_SCREEN`                   | `1080 x 2400`     |
| USB controller                    | `musb-hdrc`       |

---

## How recovery is packed

This device has **no standalone `recovery.img`**. The recovery lives inside
`vendor_boot` as a ramdisk fragment (`recovery_ramdisk`). The build therefore
produces a `vendorbootimage`, controlled by:

```
TARGET_NO_RECOVERY := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
FOX_VENDOR_BOOT_RECOVERY := 1
```

---

## Decryption (FBE)

`/data` is `f2fs` with `fileencryption=aes-256-xts:aes-256-cts:v2`.
Decryption is handled by the **Trustonic TEE**:

- `android.hardware.gatekeeper@1.0-service` (trustonic)
- `android.hardware.security.keymint-service.trustonic`
- `mcDriverDaemon` (started from `init.tee.rc`)
- TEE registry blobs in `recovery/root/vendor/app/mcRegistry/`

---

## Partitions

The recovery mounts the logical partitions (`system`, `vendor`, `product`,
`system_ext`, `odm`, `vendor_dlkm`, `odm_dlkm`, `system_dlkm`) plus the
Transsion overlay partitions (`tr_*`) and `/data`, `/cache` (tranfs),
`/metadata`. Fstab sources:

- `recovery/root/first_stage_ramdisk/fstab.emmc` — active recovery fstab
- `recovery/root/first_stage_ramdisk/fstab.mt6789` — platform fstab (reference)

---

## Kernel modules & firmware

Loaded at recovery boot via `recovery/root/init.modules.rc`:

- `recovery/root/lib/modules/` — 235 `.ko` (display, touch, usb, charger,
  trustonic, transsion) copied from the stock dump
- `recovery/root/vendor/firmware/` — touch / WiFi / BT firmware
- `recovery/root/vendor/app/mcRegistry/` — Trustonic TEE registry

---

## Format data

`recovery/root/system/bin/formatdata.sh` performs a full `/data` + `/metadata`
wipe for FBE devices, wired through `recovery/root/init.format.rc`.

---

## Building

```bash
# From an OrangeFox 14.1 (fox_14.1) source tree
source build/envsetup.sh
breakfast ofox_X6886-bp2a-eng
mka vendorbootimage
```

Flags live in `vendorsetup.sh` (read by the build, not baked into `.mk`).

---

## Flashing

```bash
fastboot flash vendor_boot out/target/product/x6886/vendor_boot.img
```

> Tip: if the built `vendor_boot` lacks a valid platform ramdisk, use the
> `vendor_boot_ramdisk_fix` tool (swap the stock platform ramdisk in) before
> flashing.

---

## Maintained by

Spider Team — Youssef (Jo / Beru)
