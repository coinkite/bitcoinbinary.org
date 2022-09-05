#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e electrs ]; then
	# Checkout source and signature
	git clone --progress https://github.com/romanz/electrs
fi

cd electrs
git checkout ${VERSION_STRING}
cargo build --locked --release

# Add delay for results to be printed and recorded
sleep 10
