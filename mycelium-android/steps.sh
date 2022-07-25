#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e wallet-android ] ; then
  # Checkout source and signature
  git clone --progress --recursive https://github.com/mycelium-com/wallet-android.git
fi

cd wallet-android
git checkout ${VERSION}

git submodule update --init --recursive

export JAVA_HOME=/opt/hostedtoolcache/Java_Temurin-Hotspot_jdk/8.0.332-9/x64
./gradlew clean mbw::assembleProdnetRelease mbw::assembleBtctestnetRelease

find ./ -type f -iname *.apk

# Add delay for results to be printed and recorded
sleep 10
