# OrangeFox — Xiaomi 12S (mayfly), kernel 6.6

Build from the OrangeFox source root:

```sh
device/xiaomi/mayfly/tools/build-orangefox.sh
```

The recovery image excludes the kernel, matching the separate recovery
partition layout in the companion ROM. It uses the kernel from boot and
DTB/modules from the matching vendor_boot. This image is for the matching
6.6 ROM boot stack; it is not a standalone kernel upgrade for stock MIUI.
Do not mix its modules with a different kernel build.

`prebuilt/kernel-6.6/provenance.json` records the local PixelOS output used
for the kernel and recovery modules and hashes its companion boot images.
The old MIUI modules are replaced during recovery staging and depmod runs
on the replacement directory. TWRP requests the matching recovery module
load list rather than only the two old touch/ADSP modules.

Display, touch, USB, mounting and data decryption still require hardware
validation. The inherited Android 14 Keymaster/Gatekeeper blobs have not
been validated against a newer ROM's encryption stack.

This checkout's OrangeFox source identifies itself as R12.0 despite the
fox_12.1 branch/directory name. Do not rename the artifacts to imply R12.1.

The host's Soong customizations make OUT relative. The recovery GUI hook
was updated to resolve a relative OUT against the source root. The patch
is saved at `tools/orangefox-relative-out.patch`; on another clean checkout,
apply it from bootable/recovery with `git apply` before building.

Build completed successfully. The packaged image has boot header v4,
a zero-length kernel and a 104857600-byte AVB-padded partition image.
Its decompressed ramdisk contains all 261 modules byte-for-byte matching
the selected build, plus the GUI theme and recovery executable. ZIP
integrity passed and its recovery.img matches the standalone image.
SHA-256 sidecars accompany both artifacts in out/target/product/mayfly.
Hardware boot and decryption have not been tested.
