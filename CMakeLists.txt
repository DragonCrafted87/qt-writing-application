cmake_minimum_required(VERSION 3.21)

include(FetchContent)

project("DragonCrafted87's Simple Writing Application" LANGUAGES C CXX)

set(VERSION_MAJOR 0)
set(VERSION_MINOR 0)
set(VERSION_PATCH 1)

add_compile_definitions(APPLICATION_NAME="${PROJECT_NAME}")
add_compile_definitions(
    APPLICATION_VERSION="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_CURRENT_LIST_DIR}/src)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

option(
    OUTPUT_COMPILER_INFO
    "Output compiler information when launching the main executable."
    ON
)

option(
    ENABLE_STATIC_ANALYSIS
    "Enable static analysis durring the build process."
    OFF
)

# option(EXPORT_COMPILE_COMMANDS "Enable/Disable output of compile commands
# during generation." ON )
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# SECTION - Compiler Commands
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

set(CMAKE_EXE_LINKER_FLAGS " -fuse-ld=lld")
if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(BUILD_SHARED_LIBS ON)
else()
    set(BUILD_SHARED_LIBS OFF)
    set(CMAKE_EXE_LINKER_FLAGS " -static")
endif()

set(CXX_FLAGS)
set(CXX_FLAGS_DEBUG)
set(CXX_FLAGS_RELEASE)

list(APPEND CXX_FLAGS "-fPIC" "-Wall" "-Wextra" "-Werror" "-Wpedantic")

if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    list(APPEND CXX_FLAGS "-fno-rtti" "-fno-exceptions")
    list(
        APPEND
        CXX_FLAGS_DEBUG
        "-Wsuggest-final-types"
        "-Wsuggest-final-methods"
        "-Wsuggest-override"
    )
    list(APPEND CXX_FLAGS_RELEASE "-O3" "-Wno-unused")
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES Clang)
    list(
        APPEND
        CXX_FLAGS
        "-fno-rtti"
        "-fno-exceptions"
        "-Qunused-arguments"
        "-fcolor-diagnostics"
    )
    list(APPEND CXX_FLAGS_DEBUG "-Wdocumentation")
    list(APPEND CXX_FLAGS_RELEASE "-O3" "-Wno-unused")
endif()

# SECTION - Libraries
find_package(Qt6 COMPONENTS Widgets REQUIRED)

fetchcontent_declare(
    GSL
    GIT_REPOSITORY "https://github.com/microsoft/GSL"
    GIT_TAG "v3.1.0"
)
fetchcontent_makeavailable(GSL)

# SECTION - Static Analyzers
if(ENABLE_STATIC_ANALYSIS)
    # clang-tidy
    set(CMAKE_CXX_CLANG_TIDY clang-tidy)

    # cppcheck
    find_program(CPPCHECK_PATH NAMES cppcheck REQUIRED)
    set(CPPCHECK_PATH_AND_OPTIONS
        ${CPPCHECK_PATH}
        --enable=all
        --inline-suppr
        --library=qt
        --quiet
        --std=c++17
        --suppressions-list=${CMAKE_CURRENT_LIST_DIR}/.cpp_check_suppressions
    )
    set(CMAKE_CXX_CPPCHECK ${CPPCHECK_PATH_AND_OPTIONS})

    # iwyu
    find_program(IWYU_PATH NAMES include-what-you-use iwyu REQUIRED)
    set(IWYU_PATH_AND_OPTIONS
        ${IWYU_PATH}
        -Xiwyu
        --no_comments
        -Xiwyu
        --mapping_file=${CMAKE_CURRENT_LIST_DIR}/.iwyu_mappings/main.imp
    )
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${IWYU_PATH_AND_OPTIONS})
endif()

file(GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS src/*.h src/*.cpp src/*.ui)

message(${PROJECT_SOURCES})
qt_add_executable(main MANUAL_FINALIZATION ${PROJECT_SOURCES})

target_compile_options(
    main
    PRIVATE
        ${CXX_FLAGS}
        "$<$<CONFIG:Debug>:${CXX_FLAGS_DEBUG}>"
        "$<$<CONFIG:Release>:${CXX_FLAGS_RELEASE}>"
)

target_link_libraries(main PRIVATE GSL Qt${QT_VERSION_MAJOR}::Widgets)
target_include_directories(main PRIVATE ${CMAKE_CURRENT_LIST_DIR}/src)
set_property(TARGET main PROPERTY WIN32_EXECUTABLE true)

qt_finalize_target(main)
