set(
    MODULE_PATH_BACKUP33333399999
    "${CMAKE_MODULE_PATH}"
)

set(
    CMAKE_MODULE_PATH
    ""
)

set(
    PREFIX_PATH_BACKUP33333399999
    "${CMAKE_PREFIX_PATH}"
)

set(
    CMAKE_PREFIX_PATH
    "${CMAKE_CURRENT_LIST_DIR}"
)

set(
    Boost_DEBUG
    OFF
)

set(
    Boost_USE_STATIC_LIBS
    ON
)

set(
    Boost_USE_MULTITHREADED
    ON
)

set(
    Boost_USE_RELEASE_LIBS
    ON
)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(
        Boost_USE_RELEASE_LIBS
        OFF
    )

    set(
        Boost_USE_DEBUG_LIBS
        ON
    )
    set(
        Boost_USE_DEBUG_RUNTIME
        ON
    )
endif()

# Derive COMPONENTS from the package itself (one lib/cmake/boost_<name>-<ver> dir per component),
# so the list always matches what was actually built per platform with no manual upkeep.
# Exclude components whose configs find_dependency() external packages (MPI, Python/NumPy): those
# would fail configure on consumers that lack them. Link-time-only deps (e.g. stacktrace backends)
# are safe and need no exclusion.
set(
    BOOST_COMPONENTS_EXCLUDE
    mpi
    mpi_python
    graph_parallel
    numpy
)

file(
    GLOB
    BOOST_COMPONENT_CONFIG_DIRS
    RELATIVE
        "${CMAKE_CURRENT_LIST_DIR}/lib/cmake"
    "${CMAKE_CURRENT_LIST_DIR}/lib/cmake/boost_*-@BOOST_VERSION@"
)

set(
    COMPONENTS
    ""
)

foreach(BOOST_COMPONENT_DIR ${BOOST_COMPONENT_CONFIG_DIRS})
    string(
        REGEX REPLACE
            "^boost_(.+)-@BOOST_VERSION@$"
            "\\1"
            BOOST_COMPONENT
            "${BOOST_COMPONENT_DIR}"
    )

    list(
        FIND
        BOOST_COMPONENTS_EXCLUDE
        "${BOOST_COMPONENT}"
        BOOST_COMPONENT_EXCLUDED
    )

    if(BOOST_COMPONENT_EXCLUDED EQUAL -1)
        list(
            APPEND
            COMPONENTS
            ${BOOST_COMPONENT}
        )
    endif()
endforeach()

unset(BOOST_COMPONENT_CONFIG_DIRS)
unset(BOOST_COMPONENTS_EXCLUDE)

find_package(
    Boost
    @BOOST_VERSION@
        EXACT
    REQUIRED
        ${COMPONENTS}
    CONFIG
)

set(
    CMAKE_MODULE_PATH
    "${MODULE_PATH_BACKUP33333399999}"
)

unset(
    MODULE_PATH_BACKUP33333399999
)

set(
    CMAKE_PREFIX_PATH
    "${PREFIX_PATH_BACKUP33333399999}"
)

unset(
    PREFIX_PATH_BACKUP33333399999
)

foreach(COMPONENT ${COMPONENTS})
    unset(
        boost_${COMPONENT}_DIR
        CACHE
    )

    unset(
        boost_${COMPONENT}_DIR-ADVANCED
        CACHE
    )
endforeach()

unset(
    COMPONENTS
)

unset(
    Boost_DIR
    CACHE
)

