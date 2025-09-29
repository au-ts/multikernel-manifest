#!/usr/bin/env bash

set -euo pipefail

cd microkit

# bindgen ../seL4/libsel4/include/sel4/bootinfo.h --no-layout-tests --blocklist-item 'seL4_CPtr' -- -Ibuild/qemu_virt_aarch64_multikernel/debug/sel4/install/libsel4/include > tool/microkit/src/kernel_bootinfo.rs

python3 build_sdk.py --sel4="../seL4" --boards qemu_virt_aarch64_multikernel --configs debug --skip-docs --skip-tar
# python3 build_sdk.py --sel4="../seL4" --boards qemu_virt_aarch64_multikernel,qemu_virt_aarch64 --configs debug --skip-docs --skip-tar
# python3 dev_build.py --rebuild --example hello --board qemu_virt_aarch64_multikernel
# python3 dev_build.py --rebuild --example hierarchy --board qemu_virt_aarch64_multikernel
python3 dev_build.py --rebuild --example multikernel --board qemu_virt_aarch64_multikernel
# python3 dev_build.py --rebuild --example multikernel_memory --board qemu_virt_aarch64_multikernel

qemu-system-aarch64 \
  -machine virt,virtualization=on \
  -smp 4 \
  -cpu cortex-a53 \
  -nographic \
  -serial mon:stdio \
  -device loader,file=./tmp_build/loader.img,addr=0x70000000,cpu-num=0 \
  -d guest_errors \
  -m size=2G "$@"
