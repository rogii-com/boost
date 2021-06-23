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

set(
    COMPONENTS

    atomic
    chrono
    container
    context
    contract
    coroutine
    date_time
    exception
    fiber
    filesystem
    graph
    headers
    iostreams
    json
    locale
    log_setup
    log
    math_c99
    math_c99f
    math_c99l
    math_tr1
    math_tr1f
    math_tr1l
    nowide
    prg_exec_monitor
    program_options
    python
    random
    regex
    serialization
    stacktrace_noop
    system
    test_exec_monitor
    thread
    timer
    type_erasure
    unit_test_framework
    wave
    wserialization
)

if(WIN32)
    set(
        COMPONENTS

        ${COMPONENTS}
        stacktrace_windbg_cached
        stacktrace_windbg
    )
endif()

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

