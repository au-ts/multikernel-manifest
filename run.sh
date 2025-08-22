#!/usr/bin/env bash

set -euo pipefail

export PATH=$PATH:$HOME/code/ts/machine_queue

cd microkit

python3 build_sdk.py --sel4="../seL4" --boards odroidc4_multikernel,odroidc4_multikernel_1,odroidc4_multikernel_2 --configs debug --skip-docs --skip-tar
python3 dev_build.py --rebuild --example hello --board odroidc4_multikernel

mq.sh run -s odroidc4_pool -f ./tmp_build/loader.img -c "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
