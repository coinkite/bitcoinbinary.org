#!/bin/bash

# Pull in version numbers from artifacts.sh
eval "$(grep VERSION_STRING artifacts.sh)"

if [ ! -e cln ]; then
	# Checkout source and submodules
	git clone --progress https://github.com/ElementsProject/lightning.git
fi
# build motivated from the CLN's build Dockerfile, https://github.com/ElementsProject/lightning/blob/master/Dockerfile
export TZ=America/Los_Angeles

# install specific version of sqlite
wget -q https://www.sqlite.org/2019/sqlite-src-3290000.zip \
	&& unzip sqlite-src-3290000.zip \
	&& cd sqlite-src-3290000 \
	&& ./configure --enable-static --disable-readline --disable-threadsafe --disable-load-extension \
	&& sudo make \
	&& sudo make install && cd .. && rm sqlite-src-3290000.zip && rm -rf sqlite-src-3290000

cd lightning
git checkout ${VERSION_STRING}

pip install poetry
poetry config virtualenvs.create false
poetry install
./configure
pwd
make clean
make
cd ..
./lightning/lightningd/lightningd --version
shasum -a 256 lightning/lightningd/lightningd

# Add delay for results to be printed and recorded
sleep 10
