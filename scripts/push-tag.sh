#! /usr/bin/env bash

set -eu

TARGET_DIR=${1:-.}

if [[ "$(find . -name Makefile | wc -l)" -ne "1" ]]; then
    if [[ "$(find . -name Makefile | wc -l)" -eq "0" ]]; then
        echo "Error: Not found Makefile. Exited."
    else
        echo "Error: multiple Makefile found. Exited."
    fi
else
    MAKEFILE_PATH=$(find . -name Makefile)
    PKG_VERSION=$(grep '^PKG_VERSION:=' ${MAKEFILE_PATH} | sed -e 's/^PKG_VERSION:=//')
    PKG_RELEASE=$(grep '^PKG_RELEASE:=' ${MAKEFILE_PATH} | sed -e 's/^PKG_RELEASE:=//')
    TAG=${PKG_VERSION}-${PKG_RELEASE}
    git pull --tags
    if [[ -n "$(git tag -l ${TAG})" ]]; then
        echo "Already exist tag: ${TAG}"
        echo "Do nothing."
    else
        cd ${TARGET_DIR}
        git config --global user.name "Travis CI"
        git config --global user.email "travis@example.com"
        git config --global "url.git@github.com:.pushinsteadof" "https://github.com/"
        git tag ${TAG}
        git push origin ${TAG}
    fi
fi
