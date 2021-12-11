#!/bin/bash

set -e

script_directory="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

while getopts cdrx flag
do
    case "${flag}" in
        c) CLEAN=True;;
        d) DEBUG=True;;
        r) RELEASE=True;;
        x) EXECUTE=True;;
        *) ;;
    esac
done

function configure-and-build ()
{
    build_path="$1"
    build_type="$2"

    mkdir -p  "$script_directory"/.cmake_build/"$build_path"/bin
    pushd "$script_directory"/.cmake_build/"$build_path"

    if [ "$CLEAN" ]; then
        cmake --build . --target clean
    fi

    cmake \
        -S "$script_directory" \
        -GNinja \
        -DCMAKE_BUILD_TYPE="$build_type" \
        -DCMAKE_C_COMPILER=x86_64-w64-mingw32-clang \
        -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-clang++ \
        "${@:3}"

    cmake \
        --build . \
        --parallel "$(nproc)"

    if [ "$EXECUTE" ]; then
        bin/src.exe
    fi

    popd
}

function release-build ()
{
    configure-and-build \
        "release" \
        "Release" \
        "-DCMAKE_TOOLCHAIN_FILE=/clang64/qt6-static/lib/cmake/Qt6/qt.toolchain.cmake"
}

function debug-build ()
{
    configure-and-build \
        "debug" \
        "Debug" \
        "-DCMAKE_TOOLCHAIN_FILE=/clang64/lib/cmake/Qt6/qt.toolchain.cmake"
}

if [ "$DEBUG" ]; then
    debug-build
fi

if [ "$RELEASE" ]; then
    release-build
fi
