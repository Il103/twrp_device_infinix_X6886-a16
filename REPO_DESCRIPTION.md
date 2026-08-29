# Infinix Hot 60 Pro Plus (x6886) – OrangeFox Recovery Device Tree

OrangeFox Recovery (fox_14.1) device tree for the **Infinix Hot 60 Pro Plus** (codename `x6886`, XOS 16 / Android 16).

## Specifications
- **SoC:** MediaTek MT6789 (2× Cortex-A76 + 6× Cortex-A55)
- **Architecture:** arm64-v8a
- **Android / SDK:** 16 / 36
- **Kernel:** 6.12.38 (GKI)
- **Build:** BP2A.250605.031.A3
- **Partition scheme:** A/B, Dynamic (super), Treble
- **Recovery model:** packed inside `vendor_boot` (header v4) — no standalone `recovery.img`

## Features
- Built entirely from the stock firmware dump (fstab, vendor HALs, kernel modules, Trustonic TEE blobs)
- `/data` decryption via Trustonic TEE (gatekeeper + keymint)
- Transsion (`tr_*`) overlay partitions mounted correctly
- Full `/data` + `/metadata` wipe script (`formatdata.sh`)
- Kernel modules auto-loaded at boot (display / touch / usb / charger / TEE)
- 64 MB `vendor_boot` size compliant (LZMA compression + size reduction flags)
- Languages: English (default) + Indonesian

## Building
```bash
source build/envsetup.sh
breakfast ofox_X6886-bp2a-eng
mka vendorbootimage
```

## Flashing
```bash
fastboot flash vendor_boot out/target/product/x6886/vendor_boot.img
```

## Maintained by
Spider Team — Youssef (Jo / Beru)
