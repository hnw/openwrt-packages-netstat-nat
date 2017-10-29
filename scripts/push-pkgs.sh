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
    PKG_NAME=$(grep '^PKG_NAME:=' ${MAKEFILE_PATH} | sed -e 's/^PKG_NAME:=//')
    PKG_VERSION=$(grep '^PKG_VERSION:=' ${MAKEFILE_PATH} | sed -e 's/^PKG_VERSION:=//')
    PKG_RELEASE=$(grep '^PKG_RELEASE:=' ${MAKEFILE_PATH} | sed -e 's/^PKG_RELEASE:=//')
    BRANCH=${PKG_NAME}-${PKG_VERSION}-${PKG_RELEASE}
    cd ${TARGET_DIR}
    git config --global user.name "Travis CI"
    git config --global user.email "travis@example.com"
    git config --global "url.git@github.com:.pushinsteadof" "https://github.com/"
    git add *
    git commit -m 'Add generated files for '${BRANCH}
    git push -f origin master:${BRANCH}
    git push -f origin master:latest/${PKG_NAME}
fi
