include(${CMAKE_CURRENT_LIST_DIR}/msvs_package.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/windowssdk_package.cmake)

CNPM_ADD_PACKAGE(
    NAME
        python
    VERSION
        3.12.14
    BUILD_NUMBER
        54
    TAG
        sdk26100_vsbt18
)

CNPM_ADD_PACKAGE(
    NAME
        python_libraries
    VERSION
        3.12.1
    BUILD_NUMBER
        5
)