#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION_STRING artifacts.sh)"

if [ ! -e bitbox02-firmware ]; then
	# Checkout source and submodules
	git clone --progress https://github.com/digitalbitbox/bitbox02-firmware
fi

cd bitbox02-firmware/releases
./build.sh firmware-btc-only/${VERSION_STRING} "make firmware-btc"
echo "shasum" $(shasum -a 256 temp/build/bin/firmware-btc.bin)

# Add delay for results to be printed and recorded
sleep 10
