#!/usr/bin/env bash

set -euo pipefail

cd microkit

python3 build_sdk.py --sel4="../seL4" --boards maaxboard_multikernel --configs debug --skip-docs --skip-tar
# python3 dev_build.py --rebuild --example multikernel --board maaxboard_multikernel
# python3 dev_build.py --rebuild --example multikernel_memory --board maaxboard_multikernel
python3 dev_build.py --rebuild --example multikernel_timer --board maaxboard_multikernel

mq.sh run -s maaxboard_pool -f ./tmp_build/loader.img -c "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
