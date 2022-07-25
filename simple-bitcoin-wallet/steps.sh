#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e wallet ] ; then
  # Checkout source and signature
  git clone --progress https://github.com/btcontract/wallet.git
fi

cd wallet
git checkout ${VERSION}

export JAVA_HOME=/opt/hostedtoolcache/Java_Temurin-Hotspot_jdk/8.0.332-9/x64
./gradlew assembleRelease

# Add delay for results to be printed and recorded
sleep 10
