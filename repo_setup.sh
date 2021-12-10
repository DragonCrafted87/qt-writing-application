#!/bin/bash



# install mysys2

pacman -Syu
pacman -Su
pacman -S \
    --needed \
    base-devel \
    git \
    mingw-w64-clang-x86_64-boost\
    mingw-w64-clang-x86_64-cmake \
    mingw-w64-clang-x86_64-cppcheck \
    mingw-w64-clang-x86_64-ninja \
    mingw-w64-clang-x86_64-python-pip \
    mingw-w64-clang-x86_64-qt6-debug \
    mingw-w64-clang-x86_64-qt6-static \
    mingw-w64-clang-x86_64-toolchain \

pip install lizard

#
#    git clone https:
#    //github.com/microsoft/vcpkg.git .vcpkg
#    cd .vcpkg
#    ./bootstrap-vcpkg.bat -disableMetrics
#
#    ./vcpkg install --triplet x64-mingw-dynamic --x-install-root=../.vcpkg_installed
#    ./vcpkg install --triplet x64-mingw-static --x-install-root=../.vcpkg_installed


#    mkdir -p .third_party/src
#    mkdir -p .third_party/debug
#    mkdir -p .third_party/release
#
#    cd .third_party/src
#
#    # https://api.github.com/repos/qt/qt5/tags
#    curl -L https://api.github.com/repos/qt/qt5/tarball/refs/tags/v6.2.2 --output qt.tar.gz
#    mkdir qt
#    bsdtar -xvf qt.tar.gz -C qt --strip-components 1
#    rm qt.tar.gz
#
#    cd qt
#
#    # https://api.github.com/repos/qt/qtbase/tags
#    curl -L https://api.github.com/repos/qt/qtbase/tarball/refs/tags/v6.2.2 --output qtbase.tar.gz
#    bsdtar -xvf qtbase.tar.gz -C qtbase --strip-components 1
#    rm qtbase.tar.gz
#
#
#    # https://api.github.com/repos/qt/qtsvg/tags
#    curl -L https://api.github.com/repos/qt/qtsvg/tarball/refs/tags/v6.2.2 --output qtsvg.tar.gz
#    bsdtar -xvf qtsvg.tar.gz -C qtsvg --strip-components 1
#    rm qtsvg.tar.gz
#
#
#    mkdir build
#    cd build
#
#    #    https://github.com/qt/qtbase/blob/dev/cmake/configure-cmake-mapping.md
#
#    cmake  \
#        -S .. \
#        -GNinja \
#        -Wno-dev \
#        -DBUILD_qtbase=ON \
#        -DBUILD_qtsvg=ON \
#        -DBUILD_SHARED_LIBS=ON \
#        -DBUILD_WITH_PCH=OFF \
#        -DCMAKE_BUILD_TYPE=Debug \
#        -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-clang++ \
#        -DCMAKE_C_COMPILER=x86_64-w64-mingw32-clang \
#        -DCMAKE_INSTALL_PREFIX=../../../debug/ \
#        -DFEATURE_sql_sqlite=ON \
#        -DFEATURE_system_doubleconversion=OFF \
#        -DFEATURE_system_freetype=OFF \
#        -DFEATURE_system_harfbuzz=OFF \
#        -DFEATURE_system_jpeg=OFF \
#        -DFEATURE_system_pcre2=OFF \
#        -DFEATURE_system_png=OFF \
#        -DFEATURE_system_sqlite=OFF \
#        -DFEATURE_system_zlib=OFF \
#        -DINPUT_opengl= \
#        -DQT_BUILD_EXAMPLES=OFF \
#        -DQT_BUILD_TESTS=OFF \
#
#    cmake --build . --parallel $(nproc)
#    cmake --install .
#
#    rm -rf *
#    cmake  \
#        -S .. \
#        -GNinja \
#        -Wno-dev \
#        -DBUILD_qtbase=ON \
#        -DBUILD_qtsvg=ON \
#        -DBUILD_SHARED_LIBS=OFF \
#        -DBUILD_WITH_PCH=OFF \
#        -DCMAKE_BUILD_TYPE=Release \
#        -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-clang++ \
#        -DCMAKE_C_COMPILER=x86_64-w64-mingw32-clang \
#        -DCMAKE_INSTALL_PREFIX=../../../release/ \
#        -DFEATURE_sql_sqlite=ON \
#        -DFEATURE_static_runtime=ON \
#        -DFEATURE_system_doubleconversion=OFF \
#        -DFEATURE_system_freetype=OFF \
#        -DFEATURE_system_harfbuzz=OFF \
#        -DFEATURE_system_jpeg=OFF \
#        -DFEATURE_system_pcre2=OFF \
#        -DFEATURE_system_png=OFF \
#        -DFEATURE_system_sqlite=OFF \
#        -DFEATURE_system_zlib=OFF \
#        -DINPUT_opengl= \
#        -DQT_BUILD_EXAMPLES=OFF \
#        -DQT_BUILD_TESTS=OFF \
#        -DQT_FEATURE_zstd=OFF \
#
#    cmake --build . --parallel $(nproc)
#    cmake --install .
#
#
#
#        -DFEATURE_system_assimp=OFF \
#        -DFEATURE_system_hunspell=OFF \
#        -DFEATURE_system_tiff=OFF \
#        -DFEATURE_system_webp=OFF \
#
