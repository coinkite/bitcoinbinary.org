#!/bin/bash

DATE=`date +%Y-%m-%d`
VERSION="v0.14.1-beta"
URL="https://lightning.network/"
REPO="https://github.com/lightningnetwork/lnd"
CHECKSUM_SOURCE="https://github.com/lightningnetwork/lnd/releases/download/${VERSION}/manifest-${VERSION}.txt"
PROJECT="lnd"
SHA256=`shasum -a 256 lnd/lnd | cut -f 1 -d ' '`

# Note GITHUB_ environment variables are populated by Github Actions
ARTIFACT_BASEURL="https://github.com/${GITHUB_REPOSITORY}/raw"
ARTIFACT_BRANCH=${GITHUB_REF_NAME}

ENTRY_TO_APPEND="<li><a href='${REPO}/releases/tag/${VERSION}'>${DATE}</a> | <a href='${URL}' class='project-name'>${PROJECT}</a>  | <a href='${REPO}/releases/tag/${VERSION}'>${VERSION}</a> | <a href='${CHECKSUM_SOURCE}'> factory ${SHA256} </a>| <a href='${ARTIFACT_BASEURL}/${ARTIFACT_BRANCH}/${PROJECT}/${PROJECT}-video.webm'>video proof</a> | no notes | <a href='https://github.com/coinkite/bitcoinbinary.org'>bitcoinbinary.org bot</a></li>"

echo ${ENTRY_TO_APPEND}
