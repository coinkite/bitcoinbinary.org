#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e sparrow ] ; then
  # Checkout source and signature
  git clone --progress --recursive https://github.com/sparrowwallet/sparrow.git
fi

cd sparrow

git checkout ${VERSION}

./gradlew jpackage
./gradlew packageTarDistribution

# Add delay for results to be printed and recorded
sleep 10
