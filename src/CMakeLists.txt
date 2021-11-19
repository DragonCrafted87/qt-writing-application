cmake_minimum_required(VERSION 3.21)

project(src VERSION 0.1 LANGUAGES CXX)


IF(CMAKE_BUILD_TYPE MATCHES Debug)
    include("c:/qt-build/debug/qtbase/lib/cmake/Qt6/qt.toolchain.cmake")
ELSE()
    include("c:/qt-build/release/qtbase/lib/cmake/Qt6/qt.toolchain.cmake")
    set(CMAKE_EXE_LINKER_FLAGS "-static")

ENDIF()





set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

find_package(Qt6 COMPONENTS Widgets REQUIRED)


file(GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS "*.h" "*.cpp" "*.ui")


qt_add_executable(src
    MANUAL_FINALIZATION
    ${PROJECT_SOURCES}
)

# IF(CMAKE_BUILD_TYPE MATCHES Debug)
#
# ELSE()
#     set_property(TARGET src PROPERTY WIN32_EXECUTABLE true)
# ENDIF()
#

target_link_libraries(src PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(src PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}

    WIN32_EXECUTABLE true
)

qt_finalize_executable(src)
