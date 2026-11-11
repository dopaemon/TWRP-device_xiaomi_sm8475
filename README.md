# Xiaomi SM8450 / SM8475 Unified Recovery Device Tree (Kernel 6.6)

Unified OrangeFox / TWRP device tree hỗ trợ:
- **mayfly** (Xiaomi 12S)
- **cupid** (Xiaomi 12)
- **zeus** (Xiaomi 12 Pro)
- **unicorn** (Xiaomi 12S Pro)

Linux Kernel 6.6 (GKI) + Vendor DLKM.

## Yêu cầu phụ thuộc
- `hardware/qcom-caf/bootctrl` (LineageOS lineage-21.0-caf)

## Cài đặt cấu trúc thư mục

Để build cho từng thiết bị, chỉ cần clone hoặc tạo symlink trong `device/xiaomi/`:

```sh
cd device/xiaomi

# Clone cùng repo hoặc tạo symlink trỏ về mayfly:
ln -s mayfly cupid
ln -s mayfly zeus
ln -s mayfly unicorn
```

## Cách build

```sh
source build/envsetup.sh

# Chọn thiết bị cần build:
lunch twrp_mayfly-eng    # Xiaomi 12S
lunch twrp_cupid-eng     # Xiaomi 12
lunch twrp_zeus-eng      # Xiaomi 12 Pro
lunch twrp_unicorn-eng   # Xiaomi 12S Pro

# Tiến hành build:
mka recoveryimage -j$(nproc)
```

## Cấu hình module & phần cứng
- Toàn bộ 261 recovery module Kernel 6.6 nằm tại `prebuilt/kernel-6.6/modules/`.
- Firmware cảm ứng & haptic tách riêng theo thiết bị trong `prebuilt/<device>/`:
  - `mayfly`: FocalTech `st_fts_l3s.ftb`
  - `cupid`: FocalTech `st_fts_l3.ftb`
  - `zeus`: FocalTech `st_fts_l1.ftb`
  - `unicorn`: FocalTech `st_fts_l2s.ftb`
- `BoardConfig.mk` tự động phát hiện `DEVICE_PATH` và cấu hình độ phân giải:
  - 1080x2400 (`OF_SCREEN_H := 2400`) cho mayfly, cupid.
  - 1440x3200 (`OF_SCREEN_H := 3200`) cho zeus, unicorn.
