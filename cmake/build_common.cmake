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
    "boost-1.72.0-${ARCH}-${BUILD}${TAG}"
)

set(
    BUILD_PATH
    "${CMAKE_CURRENT_LIST_DIR}/../build"
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
        "${CMAKE_COMMAND}" ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Release -DADDRESS_MODEL=${ADDRESS_MODEL} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ..
    WORKING_DIRECTORY
        ${BUILD_PATH}
)

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY
        ${BUILD_PATH}
)

file(
    COPY
        package.cmake
    DESTINATION
        "${CMAKE_INSTALL_PREFIX}"
)

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" -E tar cf "${PACKAGE_NAME}.7z" --format=7zip -- "${PACKAGE_NAME}"
    WORKING_DIRECTORY
        "${ROOT}"
)

