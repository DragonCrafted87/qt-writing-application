#!/bin/bash

set -e

script_directory="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

while getopts cdrsx flag
do
    case "${flag}" in
        c) CLEAN=True;;
        d) DEBUG=True;;
        r) RELEASE=True;;
        s) STATIC_ANALYSIS=True;;
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

    CMAKE_FLAGS=("${@:3}")

    if [[ -n "$STATIC_ANALYSIS" ]]; then
        CMAKE_FLAGS+=("-DENABLE_STATIC_ANALYSIS=ON")
    else
        CMAKE_FLAGS+=("-DENABLE_STATIC_ANALYSIS=OFF")
    fi

    if [[ -f "CMakeCache.txt" ]]; then
        if [[ -n "$CLEAN" || -n "$STATIC_ANALYSIS" ]]; then
            cmake --build . --target clean
        fi
    fi

    cmake \
        -S "$script_directory" \
        -GNinja \
        -DCMAKE_BUILD_TYPE="$build_type" \
        -DCMAKE_C_COMPILER=x86_64-w64-mingw32-clang \
        -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-clang++ \
        "${CMAKE_FLAGS[@]}"

    cmake \
        --build . \
        --parallel "$(nproc)"

    if [ "$EXECUTE" ]; then
        bin/main.exe
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

if [[ -n "$DEBUG" ]]; then
    debug-build
fi

if [[ -n "$RELEASE" ]]; then
    release-build
fi
