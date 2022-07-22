#!/bin/bash

VERSION=5.0.5
VERSION_STRING="2022-07-20T1508-v${VERSION}"
MK_NUM=4

if [ ! -e firmware ] ; then
  # Checkout source and submodules
  git clone --progress https://github.com/Coldcard/firmware.git
fi

cd firmware

git checkout ${VERSION_STRING}
git submodule update --init --depth 1

# Patch repro-build script to convert Docker paths to local paths
perl -pi -e "s|/work/src|`pwd`|g" stm32/repro-build.sh
perl -pi -e "s|/work/built|`pwd`/stm32|g" stm32/repro-build.sh

sh stm32/repro-build.sh ${VERSION} ${MK_NUM}

# Add delay for results to be printed and recorded
sleep 10
