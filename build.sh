#!/bin/bash

clear

saved_directory="$PWD"
script_directory="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source_directory="$script_directory/src"

cd "$script_directory" || exit
mkdir -p .cmake_build/debug
mkdir -p .cmake_build/release
mkdir -p .cmake_build/release_min_size

/d/Applications/Qt/Tools/CMake_64/bin/cmake.exe \
    -S "$source_directory" \
    -B "$script_directory"/.cmake_build/debug \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_PROJECT_INCLUDE_BEFORE:PATH=D:/Applications/Qt/Tools/QtCreator/share/qtcreator/package-manager/auto-setup.cmake \
    -DQT_QMAKE_EXECUTABLE=D:/Applications/Qt/6.2.1/mingw81_64/bin/qmake.exe \
    -DCMAKE_PREFIX_PATH=D:/Applications/Qt/6.2.1/mingw81_64 \
    -DCMAKE_C_COMPILER=D:/Applications/Qt/Tools/mingw810_64/bin/gcc.exe \
    -DCMAKE_CXX_COMPILER=D:/Applications/Qt/Tools/mingw810_64/bin/g++.exe

cp "$script_directory"/.cmake_build/debug/compile_commands.json "$script_directory"/.cmake_build/

/d/Applications/Qt/Tools/CMake_64/bin/cmake.exe \
    --build "$script_directory"/.cmake_build/debug \
    --config Debug

/d/Applications/Qt/Tools/CMake_64/bin/cmake.exe \
    -S "$source_directory" \
    -B "$script_directory"/.cmake_build/release \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_PROJECT_INCLUDE_BEFORE:PATH=D:/Applications/Qt/Tools/QtCreator/share/qtcreator/package-manager/auto-setup.cmake \
    -DQT_QMAKE_EXECUTABLE=D:/Applications/Qt/6.2.1/mingw81_64/bin/qmake.exe \
    -DCMAKE_PREFIX_PATH=D:/Applications/Qt/6.2.1/mingw81_64 \
    -DCMAKE_C_COMPILER=D:/Applications/Qt/Tools/mingw810_64/bin/gcc.exe \
    -DCMAKE_CXX_COMPILER=D:/Applications/Qt/Tools/mingw810_64/bin/g++.exe

/d/Applications/Qt/Tools/CMake_64/bin/cmake.exe \
    --build "$script_directory"/.cmake_build/release \
    --config Release

/d/Applications/Qt/Tools/CMake_64/bin/cmake.exe \
    -S "$source_directory" \
    -B "$script_directory"/.cmake_build/release_min_size \
    -GNinja \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_PROJECT_INCLUDE_BEFORE:PATH=D:/Applications/Qt/Tools/QtCreator/share/qtcreator/package-manager/auto-setup.cmake \
    -DQT_QMAKE_EXECUTABLE=D:/Applications/Qt/6.2.1/mingw81_64/bin/qmake.exe \
    -DCMAKE_PREFIX_PATH=D:/Applications/Qt/6.2.1/mingw81_64 \
    -DCMAKE_C_COMPILER=D:/Applications/Qt/Tools/mingw810_64/bin/gcc.exe \
    -DCMAKE_CXX_COMPILER=D:/Applications/Qt/Tools/mingw810_64/bin/g++.exe

/d/Applications/Qt/Tools/CMake_64/bin/cmake.exe \
    --build "$script_directory"/.cmake_build/release_min_size \
    --config MinSizeRel

cd "$saved_directory" || exit
