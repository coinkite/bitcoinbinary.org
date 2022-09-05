#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e fulcrum ]; then
	# Checkout source and submodules
	git clone --progress https://github.com/cculianu/Fulcrum.git
fi

cd Fulcrum
git checkout v${VERSION}
qmake
make -j5

# Add delay for results to be printed and recorded
sleep 10
