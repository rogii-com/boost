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

if(WIN32)
	find_package(
		Boost
		1.72.0
			EXACT
		REQUIRED
            python
            log_setup
        CONFIG
	)
elseif(UNIX)
	find_package(
		Boost
		1.72
			EXACT
		REQUIRED
			python37
	)
endif()

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

