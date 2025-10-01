#!/usr/bin/env bash

set -euo pipefail

cd microkit

python3 build_sdk.py --sel4="../seL4" --boards odroidc4_multikernel --configs debug --skip-docs --skip-tar
# python3 dev_build.py --rebuild --example multikernel --board odroidc4_multikernel
python3 dev_build.py --rebuild --example multikernel_memory --board odroidc4_multikernel
# python3 dev_build.py --rebuild --example multikernel_timer --board odroidc4_multikernel

mq.sh run -s odroidc4_pool -f ./tmp_build/loader.img -c "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
