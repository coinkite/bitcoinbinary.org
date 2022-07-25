#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e lnd ] ; then
  # Checkout source and submodules
  git clone --progress https://github.com/lightningnetwork/lnd
fi

cd lnd 
git checkout ${VERSION_STRING}
make release sys=linux-amd64 tag=${VERSION_STRING}

# Add delay for results to be printed and recorded
sleep 10
