#!/bin/bash

VERSION_STRING="core/v2.5.1"

if [ ! -e trezor-firmware ] ; then
  # Checkout source and submodules
  git clone --progress https://github.com/trezor/trezor-firmware.git
fi

cd trezor-firmware
git checkout ${VERSION_STRING}
git submodule update --init --recursive

poetry install
poetry run make clean vendor build_firmware

# https://github.com/trezor/trezor-firmware/blob/14a0bc13cefa888ee0939fdeb525ffc2667e71a4/ci/build.yml#L29
poetry run make -C core build_firmware

poetry run python/tools/firmware-fingerprint.py \
           -o core/build/firmware/firmware.bin.fingerprint \
           core/build/firmware/firmware.bin

# Add delay for results to be printed and recorded
sleep 10
