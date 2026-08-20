# OrangeFox / TWRP for Infinix HOT 60 Pro+ (X6886)

![Android 16](https://img.shields.io/badge/Android-16-3DDC84?style=for-the-badge&logo=android)
![Kernel 6.12](https://img.shields.io/badge/Kernel-6.12.38-1B82E2?style=for-the-badge)
![SoC Helio G200](https://img.shields.io/badge/SoC-Helio%20G200-6425F6?style=for-the-badge)
![Fox 14.1](https://img.shields.io/badge/Fox-14.1-orange?style=for-the-badge)

Recovery tree for **Infinix HOT 60 Pro+** — `mt6789` • `Baklava` • `Android 16` • `vendor_boot v4`

> Maintainer: **B E R U** | Tested on `BP2A.250605.031.A3`

---

### Device Specs

| Spec | Value |
| :--- | :--- |
| **SoC** | MediaTek Helio G200 (MT6789) - 6nm N6, 2x A76 @2.20 + 6x A55 @2.00 |
| **GPU** | Mali-G57 MC2 @1100MHz |
| **RAM / Storage** | 8GB LPDDR4X / 256GB UFS 2.2 |
| **Display** | 6.78" AMOLED 2400x1080 144Hz, nt37706a_fhdp_dsc_boe, 388 PPI |
| **Kernel** | 6.12.38-android16-5 GKI 4K |
| **Android** | 16 - API 36 - BP2A.250605.031.A3 |
| **Boot** | vendor_boot header v4 (64MB limit) - Virtual A/B |
| **Partitions** | Super 9GB (erofs), Dynamic, No recovery partition |
| **Crypto** | FBE + Metadata + fscrypt v2, KeyMint 7.0 Trustonic |
| **Board** | Infinix-X6886 / X6886-OP |

---

### Features

- ✅ Boot - vendor_boot v4 boots correctly
- ✅ Decryption - FBE + Metadata, `Format Data` works
- ✅ Display - 1080x2400 144Hz, BGRA_8888, brightness control
- ✅ Touch - mtk-tpd, 2400x1080
- ✅ Storage - /data (f2fs), SDCard, USB OTG, MTP/ADB
- ✅ Fastbootd - `TW_INCLUDE_FASTBOOTD` keep
- ✅ Flashlight - `/sys/devices/virtual/flashlight_core/...`
- ✅ Vibration - AIDL Haptics
- ✅ 64MB Fix - LZMA + DRASTIC (92MB -> 60MB)

### Build

#### 1. Sync Fox 14.1
```bash
mkdir -p ~/fox_14.1 && cd ~/fox_14.1
git clone https://gitlab.com/OrangeFox/sync.git
cd sync && ./orangefox_sync.sh --branch 14.1 --path ~/fox_14.1
