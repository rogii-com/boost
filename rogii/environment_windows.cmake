include(${CMAKE_CURRENT_LIST_DIR}/msvs_package.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/windowssdk_package.cmake)

CNPM_ADD_PACKAGE(
    NAME
        python
    VERSION
        3.12.4
    BUILD_NUMBER
        32
    TAG
        vsbt22
)