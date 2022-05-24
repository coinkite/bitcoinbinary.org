#!/bin/bash

VERSION="v0.5.6-beta"

if [ ! -e zap-android ] ; then
  # Checkout source and signature
  git clone --progress https://github.com/LN-Zap/zap-android.git
fi

cd zap-android
git checkout ${VERSION}

export JAVA_HOME=`ls -d /opt/hostedtoolcache/Java_Temurin-Hotspot_jdk/16*/x64 | head -n1`
./gradlew assembleRelease

# Add delay for results to be printed and recorded
sleep 10
