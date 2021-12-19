#!/bin/bash

set -e


case "$OSTYPE" in
    msys*)
        pacman -Syu
        pacman -Su
        pacman -S \
            --needed \
            base-devel \
            python-pip \
            git \
            mingw-w64-clang-x86_64-boost\
            mingw-w64-clang-x86_64-extra-cmake-modules \
            mingw-w64-clang-x86_64-cppcheck \
            mingw-w64-clang-x86_64-ninja \
            mingw-w64-clang-x86_64-qt6-debug \
            mingw-w64-clang-x86_64-qt6-static \
            mingw-w64-clang-x86_64-toolchain
        ;;
    *)
        return
        ;;
esac

pip install lizard
pip install pre-commit

pushd /tmp
curl -L https://api.github.com/repos/include-what-you-use/include-what-you-use/tarball/refs/tags/0.17 --output iwyu.tar.gz
mkdir iwyu
bsdtar -xvf iwyu.tar.gz -C iwyu --strip-components 1
rm iwyu.tar.gz
pushd iwyu
mkdir build
pushd build

cmake  \
    -S .. \
    -GNinja \
    -Wno-dev \
    -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-clang++ \
    -DCMAKE_C_COMPILER=x86_64-w64-mingw32-clang \
    -DCMAKE_INSTALL_PREFIX=/clang64/

cmake --build . --parallel "$(nproc)"
cmake --install .
