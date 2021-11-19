#!/bin/bash

clear

MSYS_NO_PATHCONV=1 \
    docker run \
    -v d:/git-home/qt-writing-application:c:/application \
    qt_6_2_1 \
    C:/scoop/apps/git/current/bin/bash.exe \
    ./application/build.sh
