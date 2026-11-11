#!/usr/bin/env bash
cd "$(dirname "$0")/../../../.." || exit 1
# Drop variables left over from a lunch in another source tree (OUT,
# ANDROID_PRODUCT_OUT, TARGET_PRODUCT, ...), otherwise the build writes into
# that tree's out directory instead of this one.
for v in $(compgen -e | grep -E '^(ANDROID_|TARGET_|OUT$|OUT_DIR)'); do unset "$v"; done
source build/envsetup.sh
lunch "twrp_${1:-mayfly}-eng" || exit 1
# The relink step that copies rebuilt shared libraries (libminuitwrp.so, ...)
# into the ramdisk only runs once per out directory. Drop its stamps so an
# incremental build does not ship a new recovery binary with stale libraries.
rm -f "$OUT"/recovery/root/relink_*-timestamp
# Prevent host noninteractive shell hooks from overriding the job limit.
unset BASH_ENV
export NINJA_REMOTE_NUM_JOBS="${JOBS:-32}"
export NINJA_ARGS="-l 0"
mka recoveryimage -j"${JOBS:-32}"
