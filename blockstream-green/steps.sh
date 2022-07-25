#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e green_android ] ; then
  # Checkout source and signature
  git clone -b ${VERSION} --progress --depth 1 https://github.com/Blockstream/green_android.git
fi

cd green_android

# Restrict memory footprint to avoid crashes
perl -pi -e 's|-Xmx4048m|-Xmx2048m|' gradle.properties

export JAVA_HOME=`ls -d /opt/hostedtoolcache/Java_Temurin-Hotspot_jdk/16*/x64 | head -n1`
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-16.jdk/Contents/Home"
env PATH="${JAVA_HOME}/bin:${PATH}" ./gradlew build -x test -x lint --no-daemon

# Add delay for results to be printed and recorded
sleep 10
