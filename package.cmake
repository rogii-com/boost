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
    ON
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
    fiber_numa
    fiber
    filesystem
    graph_parallel
    graph
    headers
    iostreams
    locale
    log_setup
    log
    math_c99
    math_c99f
    math_c99l
    math_tr1
    math_tr1f
    math_tr1l
    numpy
    prg_exec_monitor
    program_options
    python
    random
    regex
    serialization
    stacktrace_addr2line
    stacktrace_backtrace
    stacktrace_basic
    stacktrace_noop
    stacktrace_windbg_cached
    stacktrace_windbg
    system
    test_exec_monitor
    thread
    timer
    type_erasure
    unit_test_framework
    wave
    wserialization
)

find_package(
    Boost
    1.72.0
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

