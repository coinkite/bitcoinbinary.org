#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"
# Pull in GOPATH
eval "$(grep GOPATH artifacts.sh)"

if [ ! -e lnd ]; then
	# Checkout source and submodules
	git clone --progress https://github.com/lightningnetwork/lnd
fi

export PATH=$PATH:$GOPATH/bin

cd lnd
git checkout ${VERSION}
make release-install
echo "shasum" $(shasum -a 256 $GOPATH/bin/lnd)
$GOPATH/bin/lnd --version
# Add delay for results to be printed and recorded
sleep 10
