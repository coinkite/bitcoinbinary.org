#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION_STRING artifacts.sh)"

if [ ! -e fulcrum ]; then
	# Checkout source and submodules
	git clone --progress https://github.com/cculianu/Fulcrum.git
fi

cd Fulcrum
git checkout ${VERSION_STRING}
qmake
make -j5

# print shasum
shasum -a 256 Fulcrum

# print version
./Fulcrum --version

# Add delay for results to be printed and recorded
sleep 10
