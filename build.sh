#!/bin/bash

saved_directory="$PWD"
script_directory="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source_directory="$script_directory/src"


function base-build ()
{
    build_path="$1"
    build_type="$2"

    cd "$script_directory"/.cmake_build/"$build_path" || exit
    cmake \
        -S "$source_directory" \
        -GNinja \
        -DCMAKE_BUILD_TYPE="$build_type" \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

    cmake \
        --build "$script_directory"/.cmake_build/"$build_path" \
        --config "$build_type"
}

function release-build ()
{
    base-build "release" "Release"
}

function debug-build ()
{
    base-build "debug" "Debug"

    cd "$script_directory"/.cmake_build/debug/bin || exit
    cp /c/scoop/apps/llvm-mingw/current/x86_64-w64-mingw32/bin/libc++.dll .
    cp /c/scoop/apps/llvm-mingw/current/x86_64-w64-mingw32/bin/libunwind.dll .
    /c/qt-build/debug/qtbase/bin/windeployqt.exe src.exe
}

debug-build
#release-build

cd "$saved_directory" || exit
