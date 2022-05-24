#!/bin/bash

DATE=`date +%Y-%m-%d`
URL="http://zaphq.io/"
VERSION="0.5.6-beta"
VERSION_STRING="v${VERSION}"
REPO="https://github.com/LN-Zap/zap-android"
CHECKSUM_SOURCE="https://github.com/LN-Zap/zap-android/releases/tag/${VERSION_STRING}"
PROJECT="zap-android"
SHA256=`shasum -a 256 "zap-android/app/build/outputs/apk/release/zap-android-${VERSION}(36)-release-unsigned.apk" | cut -f 1 -d ' '`

# Note GITHUB_ environment variables are populated by Github Actions
ARTIFACT_BASEURL="https://github.com/${GITHUB_REPOSITORY}/raw"
ARTIFACT_BRANCH=${GITHUB_REF_NAME}

ENTRY_TO_APPEND="<li><a href='${REPO}/releases/tag/${VERSION_STRING}'>${DATE}</a> | <a href='${URL}' class='project-name'>${PROJECT}</a>  | <a href='${REPO}/releases/tag/${VERSION_STRING}'>v${VERSION}</a> | <a href='${CHECKSUM_SOURCE}'> factory ${SHA256} </a>| <a href='${ARTIFACT_BASEURL}/${ARTIFACT_BRANCH}/${PROJECT}/${PROJECT}-video.webm'>video proof</a> | no notes | <a href='https://github.com/coinkite/bitcoinbinary.org'>bitcoinbinary.org bot</a></li>"

echo ${ENTRY_TO_APPEND}
