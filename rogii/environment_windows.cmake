include(${CMAKE_CURRENT_LIST_DIR}/msvs_package.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/windowssdk_package.cmake)

CNPM_ADD_PACKAGE(
    NAME
        python
    VERSION
        3.7.13
    BUILD_NUMBER
        19
    TAG
        brdev-rogii-v3.7.13-rabadf6
)
