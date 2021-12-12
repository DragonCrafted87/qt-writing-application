cmake_minimum_required(VERSION 3.21)

project(
  "DragonCrafted87's Simple Writing Application"
  VERSION 0.0.1
  LANGUAGES C CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

find_package(
  Qt6
  COMPONENTS Widgets
  REQUIRED)

set(CMAKE_EXE_LINKER_FLAGS " -fuse-ld=lld")
if(CMAKE_BUILD_TYPE MATCHES Debug)
  set(BUILD_SHARED_LIBS ON)
  set(CMAKE_SHARED_LIBRARY_SUFFIX "dll.a")
else()
  set(CMAKE_STATIC_LIBRARY_SUFFIX MATCHES "^((?!dll).)*$")
  set(BUILD_SHARED_LIBS OFF)
  set(CMAKE_EXE_LINKER_FLAGS " -static")
endif()

# Setup Static Analyzers
set(CMAKE_CXX_CLANG_TIDY clang-tidy)
find_program(CPPCHECK_PATH NAMES cppcheck REQUIRED)
set(CPPCHECK_PATH_AND_OPTIONS
    ${CPPCHECK_PATH}
    --enable=all
    --force
    --library=qt
    --quiet
    --std=c++14
    --suppressions-list=${CMAKE_CURRENT_LIST_DIR}/.cpp_check_suppressions)
set(CMAKE_CXX_CPPCHECK ${CPPCHECK_PATH_AND_OPTIONS})

find_program(IWYU_PATH NAMES include-what-you-use iwyu REQUIRED)
set(IWYU_PATH_AND_OPTIONS
    ${IWYU_PATH} -Xiwyu --no_comments -Xiwyu
    --mapping_file=${CMAKE_CURRENT_LIST_DIR}/.iwyu_mappings/main.imp)
set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${IWYU_PATH_AND_OPTIONS})

add_compile_definitions(APPLICATION_NAME="${PROJECT_NAME}")
add_compile_definitions(APPLICATION_VERSION="${PROJECT_VERSION}")

file(GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS src/*.h src/*.cpp src/*.ui)

message(${PROJECT_SOURCES})
qt_add_executable(src MANUAL_FINALIZATION ${PROJECT_SOURCES})

target_link_libraries(src PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(
  src
  PROPERTIES MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             WIN32_EXECUTABLE true)

qt_finalize_target(src)
