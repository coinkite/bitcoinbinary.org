#!/bin/bash

VERSION_STRING="v0.14.1-beta"

if [ ! -e lnd ] ; then
  # Checkout source and submodules
  git clone --progress https://github.com/lightningnetwork/lnd
fi

cd lnd 
git checkout ${VERSION_STRING}
make release sys=linux-amd64 tag=${VERSION_STRING}

# Add delay for results to be printed and recorded
sleep 10
