#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION artifacts.sh)"

if [ ! -e WalletWasabi ] ; then
  # Checkout source and signature
  git clone https://github.com/zkSNACKs/WalletWasabi.git
fi

cd WalletWasabi
git checkout ${VERSION}

dotnet restore --locked-mode

cd WalletWasabi.Gui

dotnet build --configuration Release

# Add delay for results to be printed and recorded
sleep 10
