#!/bin/bash

DATE=`date +%Y-%m-%d`
URL="https://wallet.mycelium.com/"
VERSION="v3.15.0.0"
REPO="https://github.com/mycelium-com/wallet-android"
CHECKSUM_SOURCE="https://github.com/mycelium-com/wallet-android/releases/tag/${VERSION}"
PROJECT="mycelium-android"
SHA256=`shasum -a 256 wallet-android/mbw/build/outputs/apk/prodnet/release/mbw-prodnet-release.apk | cut -f 1 -d ' '`

# Note GITHUB_ environment variables are populated by Github Actions
ARTIFACT_BASEURL="https://github.com/${GITHUB_REPOSITORY}/raw"
ARTIFACT_BRANCH=${GITHUB_REF_NAME}

ENTRY_TO_APPEND="<li><a href='${REPO}/releases/tag/${VERSION}'>${DATE}</a> | <a href='${URL}' class='project-name'>${PROJECT}</a>  | <a href='${REPO}/releases/tag/${VERSION}'>${VERSION}</a> | <a href='${CHECKSUM_SOURCE}'> factory ${SHA256} </a>| <a href='${ARTIFACT_BASEURL}/${ARTIFACT_BRANCH}/${PROJECT}/${PROJECT}-video.webm'>video proof</a> | no notes | <a href='https://github.com/coinkite/bitcoinbinary.org'>bitcoinbinary.org bot</a></li>"

echo ${ENTRY_TO_APPEND}
