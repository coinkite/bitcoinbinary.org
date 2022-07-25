#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e bitbox02-firmware ] ; then
  # Checkout source and submodules
  git clone --progress --recurse-submodules https://github.com/digitalbitbox/bitbox02-firmware
fi

cd bitbox02-firmware
git checkout ${VERSION_STRING}

make firmware

# Add delay for results to be printed and recorded
sleep 10
