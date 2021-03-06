#!/bin/bash -e

# Build script to cross-compile rsync for Android
# Copyright © 2020 Matt Robinson

if [ -z "$ANDROID_NDK_HOME" ]; then
    if [ "$ANDROID_HOME" ]; then
        export ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
    else
        echo "Either ANDROID_NDK_HOME or ANDROID_HOME must be set" >&2
        exit 1
    fi
fi

TARGET=${TARGET:-armv7a-linux-androideabi}
PLATFORM=29

toolchain=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64


cd external/rsync

./configure --host="$TARGET" \
    AR="$toolchain/bin/${TARGET/armv7a/arm}-ar" \
    CC="$toolchain/bin/$TARGET$PLATFORM-clang" \
    LD="$toolchain/bin/${TARGET/armv7a/arm}-ld" \
    RANLIB="$toolchain/bin/${TARGET/armv7a/arm}-ranlib" \
    STRIP="$toolchain/bin/${TARGET/armv7a/arm}-strip"

make
