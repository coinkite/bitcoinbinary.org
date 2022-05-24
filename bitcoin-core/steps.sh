#!/bin/bash

VERSION_STRING="v23.0"

if [ ! -e lnd ] ; then
  # Checkout source and submodules
  git clone --progress https://github.com/bitcoin/bitcoin.git
fi

cd bitcoin 
git checkout ${VERSION_STRING}

./autogen.sh
./configure
make -j5

# Add delay for results to be printed and recorded
sleep 10
