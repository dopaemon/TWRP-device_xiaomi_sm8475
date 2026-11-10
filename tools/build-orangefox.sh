#!/usr/bin/env bash
cd "$(dirname "$0")/../../../.." || exit 1
source build/envsetup.sh
lunch twrp_mayfly-eng || exit 1
# Prevent host noninteractive shell hooks from overriding the job limit.
unset BASH_ENV
export NINJA_REMOTE_NUM_JOBS="${JOBS:-32}"
export NINJA_ARGS="-l 0"
mka recoveryimage -j"${JOBS:-32}"
