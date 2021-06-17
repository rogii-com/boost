cmake_minimum_required(
    VERSION
    3.12.4
)

project(
    boost
)

set(
    PROJECT_ROOT_PATH
    "${CMAKE_CURRENT_LIST_DIR}/.."
)

set(
    ROGII_FOLDER_PATH
    "${CMAKE_CURRENT_LIST_DIR}"
)

include(ProcessorCount)
ProcessorCount(N)
message(STATUS "Processor count is ${N}")

include(${ROGII_FOLDER_PATH}/npm/Include.cmake)
include(${ROGII_FOLDER_PATH}/environment.cmake)
include(${ROGII_FOLDER_PATH}/version.cmake)

CNPM_PREPARE_PACKAGES(
    DEFAULT_REPOSITORY_URLS
    "$ENV{CNPM_URLS}"
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

set(
    VERSIONED_BOOST_INCLUDE_DIR_NAME
    boost-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}
)

set(
    INSTALLED_BOOST_VERSION_HEADER_FILE_PATH
    ${CMAKE_INSTALL_PREFIX}/include/${VERSIONED_BOOST_INCLUDE_DIR_NAME}/boost/version.hpp
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
            ${PROJECT_ROOT_PATH}/project-config.jam
        COMMAND
            ./bootstrap.sh
        WORKING_DIRECTORY
            ${PROJECT_ROOT_PATH}
        USES_TERMINAL
    )
    add_custom_command(
        OUTPUT
            ${INSTALLED_BOOST_VERSION_HEADER_FILE_PATH}
        COMMAND
            ${CMAKE_COMMAND}
            -E
            env
            PYTHON_LIBDIR=${PYTHON_LIBDIR}
            ./b2
            install
            -j${N}
            cxxstd=17
            toolset=${TOOLSET}
            variant=debug,release
            link=static
            threading=multi
            runtime-link=shared
            cflags=-fPIC
            cxxflags=-fPIC
            ${ADDRESS_MODEL}
            --layout=versioned
            --build-type=minimal
            --user-config=${USER_CONFIG}
            python=3.7
            --prefix=${CMAKE_INSTALL_PREFIX}
        DEPENDS
            ${PROJECT_ROOT_PATH}/project-config.jam
        WORKING_DIRECTORY
            ${PROJECT_ROOT_PATH}
        USES_TERMINAL
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
            ${PROJECT_ROOT_PATH}/project-config.jam
        COMMAND
            cmd /C bootstrap.bat vc142
        COMMAND
            ${CMAKE_COMMAND}
            -DPROJECT_SOURCE_DIR=${PROJECT_ROOT_PATH}
            -P ${ROGII_FOLDER_PATH}/project_config.cmake
        WORKING_DIRECTORY
            ${PROJECT_ROOT_PATH}
        USES_TERMINAL
    )
    add_custom_command(
        OUTPUT
            ${INSTALLED_BOOST_VERSION_HEADER_FILE_PATH}
        COMMAND
            ${CMAKE_COMMAND}
            -E
            env
            PYTHON_LIBDIR=${PYTHON_LIBDIR}
            PYTHONPATH=${PYTHON_LIBDIR}/python37.zip
            b2
            install
            -j${N}
            cxxstd=17
            toolset=${TOOLSET}
            ${ADDRESS_MODEL}
            --build-type=minimal
            --user-config=${USER_CONFIG}
            python=3.7
            --prefix=${CMAKE_INSTALL_PREFIX}
        DEPENDS
            ${PROJECT_ROOT_PATH}/project-config.jam
        WORKING_DIRECTORY
            ${PROJECT_ROOT_PATH}
        USES_TERMINAL
    )
endif()

add_custom_target(
    ${PROJECT_NAME}
    ALL
    DEPENDS
        ${INSTALLED_BOOST_VERSION_HEADER_FILE_PATH}
)
