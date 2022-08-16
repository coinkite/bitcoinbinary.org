#!/bin/bash

find ./firmware -type f -name firmware*.bin >&2

DATE=`date +%Y-%m-%d`
TWITTER_NAME="@COLDCARDwallet Mk3"
VERSION=4.1.5
VERSION_STRING="2022-05-04T1258-v${VERSION}"
URL="https://coldcard.com"
REPO="https://github.com/Coldcard/firmware"
CHECKSUM_SOURCE="https://raw.githubusercontent.com/Coldcard/firmware/v4-legacy/releases/signatures.txt"
PROJECT="coldcard-mk3"
SHA256=`shasum -a 256 firmware/stm32/firmware-signed.bin | cut -f 1 -d ' '`

# Note GITHUB_ environment variables are populated by Github Actions
ARTIFACT_BASEURL="https://github.com/${GITHUB_REPOSITORY}/raw"
ARTIFACT_BRANCH=${GITHUB_REF_NAME}

ENTRY_TO_APPEND="<li><a href='${REPO}/releases/tag/${VERSION_STRING}'>${DATE}</a> | <a href='${URL}' class='project-name'>${PROJECT}</a>  | <a href='${REPO}/releases/tag/${VERSION_STRING}'>v${VERSION}</a> | <a href='${CHECKSUM_SOURCE}'> factory ${SHA256} </a>| <a href='${ARTIFACT_BASEURL}/${ARTIFACT_BRANCH}/${PROJECT}/${PROJECT}-${VERSION}-video.webm'>video proof</a> | <a href='https://github.com/coinkite/bitcoinbinary.org/blob/main/${PROJECT}/artifacts.sh' class="bot">build bot</a></li>"

echo ${ENTRY_TO_APPEND}
