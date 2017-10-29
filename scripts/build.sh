#! /usr/bin/env bash

# log:
#   $OUT_DIR/build.log
# built binaries:
#   $OUT_DIR/structured/$OUT_DIR/
#   $OUT_DIR/flattened/

set -eu

PKGS=$1
BUILD_DIR=$2
FEED_DIR=$3
OUT_DIR=$4
ARCH_DIR=$5
VERBOSE=${6-}
FEED_NAME=custom

cd /home/openwrt/sdk
rm -rf bin
cp feeds.conf.default feeds.conf
echo src-link $FEED_NAME $FEED_DIR >> feeds.conf
./scripts/feeds update -a
./scripts/feeds install $PKGS
make defconfig

# To bypass travis-ci 10 minutes build timeout
[[ "$VERBOSE" > 0 ]] && while true ; do echo "..." ; sleep 60 ; done &

for pkg in toolchain $PKGS ; do
    echo make package/$pkg/compile V=s
    if [[ "$VERBOSE" > 0 ]] ; then
        make package/$pkg/compile V=s >> $OUT_DIR/build.log 2>&1
    else
        make package/$pkg/compile V=s
    fi
done

[[ "$VERBOSE" > 0 ]] && kill %1

ls -laR bin
mkdir -p $OUT_DIR/structured/$ARCH_DIR $OUT_DIR/flattened
if [[ -e "$BUILD_DIR/$FEED_NAME" ]] ; then
    cd $BUILD_DIR/$FEED_NAME
    for file in * ; do
        cp $file $OUT_DIR/structured/${ARCH_DIR}/${file}
        cp $file $OUT_DIR/flattened/${ARCH_DIR//\//-}-${file}
    done
    ls -la $OUT_DIR/structured/$ARCH_DIR/ $OUT_DIR/flattened/
fi
