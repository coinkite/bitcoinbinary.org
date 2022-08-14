#!/bin/bash

DATE=`date +%Y-%m-%d`
TWITTER_NAME="@Blockstream Green"
URL="https://blockstream.com/"
VERSION="3.8.5"
VERSION_STRING="release_${VERSION}"
REPO="https://github.com/Blockstream/green_android"
CHECKSUM_SOURCE="https://github.com/Blockstream/green_android/releases/tag/${VERSION_STRING}"
PROJECT="blockstream-green"
SHA256=`shasum -a 256 green_android/green/build/outputs/apk/development/release/BlockstreamGreen-v${VERSION}-development-release-unsigned.apk | cut -f 1 -d ' '`

# Note GITHUB_ environment variables are populated by Github Actions
ARTIFACT_BASEURL="https://github.com/${GITHUB_REPOSITORY}/raw"
ARTIFACT_BRANCH=${GITHUB_REF_NAME}

ENTRY_TO_APPEND="<li><a href='${REPO}/releases/tag/${VERSION_STRING}'>${DATE}</a> | <a href='${URL}' class='project-name'>${PROJECT}</a>  | <a href='${REPO}/releases/tag/${VERSION_STRING}'>v${VERSION}</a> | <a href='${CHECKSUM_SOURCE}'> factory ${SHA256} </a>| <a href='${ARTIFACT_BASEURL}/${ARTIFACT_BRANCH}/${PROJECT}/${PROJECT}-${VERSION}-video.webm'>video proof</a> | <a href='https://github.com/coinkite/bitcoinbinary.org/blob/main/${PROJECT}/artifacts.sh' class="bot">build bot</a></li>"

echo ${ENTRY_TO_APPEND}
