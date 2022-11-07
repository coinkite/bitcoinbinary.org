#!/bin/bash

DATE=`date +%Y-%m-%d`
TWITTER_NAME="BitBox02"
URL="https://shiftcrypto.ch/bitbox02/"
VERSION_STRING="v9.12.0"
REPO="https://github.com/digitalbitbox/bitbox02-firmware"
CHECKSUM_SOURCE="https://github.com/digitalbitbox/bitbox02-firmware/releases/tag/${VERSION}"
PROJECT="bitbox02-firmware"
SHA256=$(shasum -a 256 bitbox02-firmware/releases/temp/build/bin/firmware-btc.bin | cut -f 1 -d ' ')

# Note GITHUB_ environment variables are populated by Github Actions
ARTIFACT_BASEURL="https://github.com/${GITHUB_REPOSITORY}/raw"
ARTIFACT_BRANCH=${GITHUB_REF_NAME}

ENTRY_TO_APPEND="<li><a href='${REPO}/releases/tag/${VERSION}'>${DATE}</a> | <a href='${URL}' class='project-name'>${PROJECT}</a>  | <a href='${REPO}/releases/tag/${VERSION}'>${VERSION}</a> | <a href='${CHECKSUM_SOURCE}'> factory ${SHA256} </a>| <a href='${ARTIFACT_BASEURL}/${ARTIFACT_BRANCH}/${PROJECT}/${PROJECT}-${VERSION}-video.webm'>video proof</a> | <a href='https://github.com/coinkite/bitcoinbinary.org/blob/main/${PROJECT}/artifacts.sh' class="bot">build bot</a></li>"

echo ${ENTRY_TO_APPEND}
