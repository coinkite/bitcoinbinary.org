#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e poncho ] ; then
  # Checkout source and signature
  git clone --progress https://github.com/nbd-wtf/poncho.git
fi

cd poncho
git checkout ${VERSION}

sbt nativeLink

# Add delay for results to be printed and recorded
sleep 10
