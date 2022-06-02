#!/bin/bash

BRANCH="v4-legacy"
VERSION=4.1.5
VERSION_STRING="2022-05-04T1258-v${VERSION}"
MK_NUM=3

if [ ! -e firmware ] ; then
  # Checkout source and submodules
  git clone --progress https://github.com/Coldcard/firmware.git
fi

cd firmware

git checkout ${BRANCH}
git submodule update --init --depth 1

# Patch repro-build script to convert Docker paths to local paths
perl -pi -e "s|/work/src|`pwd`|g" stm32/repro-build.sh
perl -pi -e "s|/work/built|`pwd`/stm32|g" stm32/repro-build.sh

sh stm32/repro-build.sh ${VERSION}

# Add delay for results to be printed and recorded
sleep 10
