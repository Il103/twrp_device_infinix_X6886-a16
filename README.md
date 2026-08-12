# TWRP for Infinix HOT 60 Pro Plus (X6886)

<img src="https://img.shields.io/badge/Android-16-3DDC84?style=for-the-badge&logo=android" />
<img src="https://img.shields.io/badge/Kernel-6.12.38-1B82E2?style=for-the-badge" />
<img src="https://img.shields.io/badge/SoC-MediaTek%20Helio%20G200-64B5F6?style=for-the-badge" />
<img src="https://img.shields.io/badge/TWRP-14.1-orange?style=for-the-badge" />

**TWRP 14.1** device tree for the **Infinix HOT 60 Pro Plus (X6886)** — MT6789 (Helio G200), Android 16, GKI, recovery in `vendor_boot`.

---

## Device Specifications

| Spec | Value |
|------|-------|
| SoC | MediaTek Helio G200 (MT6789) |
| Display | 6.8" AMOLED, 1080x2400, 144Hz |
| RAM / Storage | 8GB / 256GB UFS |
| Android | 16 (BP2A.250605.031.A3) |
| Kernel | 6.12.38-android16 (GKI 4K) |
| Boot | Vendor Boot (v4) / Virtual A/B |
| Encryption | FBE, Metadata, fscrypt v2, KeyMint v3 |

---

## Features

- ✅ FBE / Metadata Decryption (`TW_INCLUDE_FBE_METADATA_DECRYPT`)
- ✅ KeyMint v3 (Trustonic) — keys work, **Format Data works**
- ✅ Vendor boot module loading (`TW_LOAD_VENDOR_BOOT_MODULES`)
- ✅ Fastbootd included
- ✅ Full MTK bootctrl (Virtual A/B slots)
- ✅ External SD + USB OTG
- ✅ 1080x2400 @144Hz recovery UI (BGRA_8888)

---

## Build

```bash
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-14.1
repo sync

# clone this tree to:
#   device/infinix/X6886

source build/envsetup.sh
lunch twrp_X6886-ap2a-eng
mka vendorbootimage
```

Output:

```
out/target/product/X6886/vendor_boot.img
```

---

## Flash

```bash
# reboot to fastboot, then:
fastboot flash vendor_boot out/target/product/X6886/vendor_boot.img
fastboot reboot recovery
```

> **Keep stock `dtbo.img`** — the panel dtb is device-specific.

---

## Kernel Modules

Kernel modules come straight from the **stock A16 dump** (`lib/modules`), loaded via `modules.load.recovery`. Display chain includes:

- `mediatek_drm_v1.ko` + `mtk_panel_ext.ko` + `tran_drm_panel_i2c.ko`
- Panel: `nt37706a_fhdp_dsi_vdo_dsc_boe_boe_144hz_x6886.ko`

---

## Credits

- **TWRP Team** for the recovery
- **MTK / Transsion** community trees as reference
- Stock A16 firmware dump for blobs & modules

---

## Disclaimer

Recovery flashing carries risk. Use at your own pace, keep backups.
