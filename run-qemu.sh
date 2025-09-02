#!/usr/bin/env bash

set -euo pipefail

export PATH=$PATH:$HOME/code/ts/machine_queue

cd microkit

python3 build_sdk.py --sel4="../seL4" --boards qemu_virt_aarch64_multikernel --configs debug --skip-docs --skip-tar
python3 dev_build.py --rebuild --example hello --board qemu_virt_aarch64_multikernel

qemu-system-aarch64 \
  -machine virt,virtualization=on \
  -cpu cortex-a53 \
  -nographic \
  -serial mon:stdio \
  -device loader,file=./tmp_build/loader.img,addr=0x70000000,cpu-num=0 \
  -m size=2G "$@"
