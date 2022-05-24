#!/bin/bash

DATE=`date +%Y-%m-%d`
VERSION="2.5.1"
VERSION_STRING="core/v${VERSION}"
URL="https://trezor.io/"
REPO="https://github.com/trezor/trezor-firmware"
CHECKSUM_SOURCE="https://data.trezor.io/firmware/2/trezor-${VERSION}.bin"
PROJECT="trezor-firmware"
SHA256=`shasum -a 256 trezor-firmware/build/firmware/firmware.bin | cut -f 1 -d ' '`

# Note GITHUB_ environment variables are populated by Github Actions
ARTIFACT_BASEURL="https://github.com/${GITHUB_REPOSITORY}/raw"
ARTIFACT_BRANCH=${GITHUB_REF_NAME}

ENTRY_TO_APPEND="<li><a href='${REPO}/releases/tag/${VERSION_STRING}'>${DATE}</a> | <a href='${URL}' class='project-name'>${PROJECT}</a>  | <a href='${REPO}/releases/tag/${VERSION_STRING}'>${VERSION_STRING}</a> | <a href='${CHECKSUM_SOURCE}'> factory ${SHA256} </a>| <a href='${ARTIFACT_BASEURL}/${ARTIFACT_BRANCH}/${PROJECT}/${PROJECT}-video.webm'>video proof</a> | no notes | <a href='https://github.com/coinkite/bitcoinbinary.org'>bitcoinbinary.org bot</a></li>"

echo ${ENTRY_TO_APPEND}
