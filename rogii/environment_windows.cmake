include(${CMAKE_CURRENT_LIST_DIR}/msvs_package.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/windowssdk_package.cmake)

CNPM_ADD_PACKAGE(
    NAME
        python
    VERSION
        3.10.5
    BUILD_NUMBER
        16
    TAG
        brdev-rogii-v3.10.5-r79d143
)
