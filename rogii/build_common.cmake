if(
    NOT DEFINED ROOT
    OR NOT DEFINED ARCH
)
    message(
        FATAL_ERROR
        "Assert: ROOT = ${ROOT}; ARCH = ${ARCH}"
    )
endif()

set(
    PROJECT_ROOT_PATH
    "${CMAKE_CURRENT_LIST_DIR}/.."
)

set(
    ROGII_FOLDER_PATH
    "${CMAKE_CURRENT_LIST_DIR}"
)

include(${ROGII_FOLDER_PATH}/version.cmake)

set(
    BUILD
    0
)

if(DEFINED ENV{BUILD_NUMBER})
    set(
        BUILD
        $ENV{BUILD_NUMBER}
    )
endif()

set(
    TAG
    ""
)

if(DEFINED ENV{TAG})
    set(
        TAG
        "$ENV{TAG}"
    )
else()
    find_package(
        Git
    )

    if(Git_FOUND)
        execute_process(
            COMMAND
                ${GIT_EXECUTABLE} rev-parse --short HEAD
            OUTPUT_VARIABLE
                TAG
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )
        set(
            TAG
            "_${TAG}"
        )
    endif()
endif()

set(
    PACKAGE_NAME
    "boost-${BOOST_VERSION}-${ARCH}-${BUILD}${TAG}"
)

set(
    BUILD_PATH
    "${PROJECT_ROOT_PATH}/build"
)

file(
    MAKE_DIRECTORY
    ${BUILD_PATH}
)

set(
    CMAKE_INSTALL_PREFIX
    ${ROOT}/${PACKAGE_NAME}
)

if(WIN32)
    set(
        CMAKE_GENERATOR
        -G "NMake Makefiles"
    )
endif()

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Release -DADDRESS_MODEL=${ADDRESS_MODEL} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ${ROGII_FOLDER_PATH}
    WORKING_DIRECTORY
        ${BUILD_PATH}
)

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY
        ${BUILD_PATH}
)

configure_file(
    "${ROGII_FOLDER_PATH}/template__package.cmake"
    "${CMAKE_INSTALL_PREFIX}/package.cmake"
    @ONLY
)

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" -E tar cf "${PACKAGE_NAME}.7z" --format=7zip -- "${PACKAGE_NAME}"
    WORKING_DIRECTORY
        "${ROOT}"
)

