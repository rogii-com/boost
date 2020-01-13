cmake_minimum_required(
    VERSION
    3.9.5
)

project(
    boost
)

set(
    SUBMODULE_INFO_SHOWN
    OFF
    CACHE
        BOOL
        "Was the information on how to correctly update submodules shown?"
)

if(NOT SUBMODULE_INFO_SHOWN)
    set(
        SUBMODULE_INFO_SHOWN
        ON
        CACHE
            BOOL
            "Was the information on how to correctly update submodules shown?"
        FORCE
    )

    message(
        FATAL_ERROR
        "To update submodules firt call 'git submodule init', then edit .git/config and change "
        "url for all submodules except cnpm: replace rogii-com to boostorg. This is required "
        "because we use our fork of the superproject but all submodules are set with relative path "
        "and we don't fork them. After that 'git submodule update --recursive' may be called as usual. "
        "For details check https://stackoverflow.com/a/42035018 ."
    )
endif()

include(
    "${PROJECT_SOURCE_DIR}/cmake/npm/NastyPackageManager.cmake"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    NPM_ADD_PACKAGE(
        NAME
            python
        VERSION
            3.7.4
        BUILD_NUMBER
            0
    )
elseif(MSVC)
    NPM_ADD_PACKAGE(
        NAME
            msvs
        VERSION
            2019
        BUILD_NUMBER
            1
    )
    NPM_ADD_PACKAGE(
        NAME
            windowssdk
        VERSION
            10.0.18362.0
        BUILD_NUMBER
            0
    )
    NPM_ADD_PACKAGE(
        NAME
            python
        VERSION
            3.7.4
        BUILD_NUMBER
            0
        TAG
            sdk14393_vs2015up3
    )
endif()

set(
    REPOSITORY_OS
    "windows"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(
        REPOSITORY_OS
        "linux"
    )
endif()

NPM_PREPARE_PACKAGES(
    DEFAULT_REPOSITORY_URLS
    "https://cnpm.rogii.com/${REPOSITORY_OS}/public"
)

get_property(
    PYTHON_LIB_LOCATION
    TARGET
        Python::library
    PROPERTY
        IMPORTED_LOCATION
)

# get python package directory from imported location "/python/lib/python3.7"

message(
    STATUS
    "PYTHON_LIB_LOCATION = ${PYTHON_LIB_LOCATION}"
)

get_filename_component(PYTHON_LIBDIR ${PYTHON_LIB_LOCATION} DIRECTORY)
message(
    STATUS
    "PYTHON_LIBDIR = ${PYTHON_LIBDIR}"
)

get_filename_component(PYTHON_LIBDIR ${PYTHON_LIBDIR} DIRECTORY)

message(
    STATUS
    "PYTHON_LIBDIR = ${PYTHON_LIBDIR}"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(
        TOOLSET
        "gcc"
    )
    set(
        USER_CONFIG
        "starsteer_linux.jam"
    )
    add_custom_command(
        OUTPUT
            ${boost_SOURCE_DIR}/project-config.jam
        COMMAND
            ./bootstrap.sh
        WORKING_DIRECTORY
            "${boost_SOURCE_DIR}"
    )
    add_custom_command(
        OUTPUT
            ${CMAKE_INSTALL_PREFIX}/include/boost-1_68/boost/version.hpp
        COMMAND
            export PYTHON_LIBDIR=${PYTHON_LIBDIR}
        COMMAND
            ${CMAKE_COMMAND} -E env PYTHON_LIBDIR=${PYTHON_LIBDIR} ./b2 install -j8 toolset=${TOOLSET} ${ADDRESS_MODEL} --build-type=minimal --user-config=${USER_CONFIG} python=3.7 --prefix=${CMAKE_INSTALL_PREFIX}
        WORKING_DIRECTORY
            "${boost_SOURCE_DIR}"
    )
elseif(MSVC)
    set(
        TOOLSET
        "msvc"
    )
    set(
        USER_CONFIG
        "starsteer.jam"
    )
    add_custom_command(
        OUTPUT
            ${PROJECT_SOURCE_DIR}/project-config.jam
        COMMAND
            cmd /C bootstrap.bat vc142
        COMMAND
            ${CMAKE_COMMAND}
            -DPROJECT_SOURCE_DIR=${PROJECT_SOURCE_DIR}
            -P ${PROJECT_SOURCE_DIR}/cmake/ProjectConfig.cmake
        WORKING_DIRECTORY
            ${PROJECT_SOURCE_DIR}
    )
    add_custom_command(
        OUTPUT
            ${CMAKE_INSTALL_PREFIX}/include/boost-1_72/boost/version.hpp
        COMMAND
            set PYTHON_LIBDIR=${PYTHON_LIBDIR}
        COMMAND
            set PYTHONPATH=${PYTHON_LIBDIR}/python37.zip
        COMMAND
            b2 install -j8 toolset=${TOOLSET} ${ADDRESS_MODEL} --build-type=minimal --user-config=${USER_CONFIG} python=3.7 --prefix=${CMAKE_INSTALL_PREFIX}
        WORKING_DIRECTORY
            ${PROJECT_SOURCE_DIR}
    )
endif()

add_custom_target(
    ${PROJECT_NAME}
    ALL
    DEPENDS
        ${boost_SOURCE_DIR}/project-config.jam
        ${CMAKE_INSTALL_PREFIX}/include/boost-1_72/boost/version.hpp
)

