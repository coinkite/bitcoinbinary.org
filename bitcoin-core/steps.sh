#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

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
