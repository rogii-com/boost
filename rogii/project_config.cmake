
file(
    READ
    ${PROJECT_SOURCE_DIR}/project-config.jam
    PROJECT_CONFIG_JAM
)
string(
    REGEX REPLACE
    "(using[ \t]+msvc[^;]*)(;)"
    "\\1: : <setup>msvc-mock.bat \\2"
    NEW_PROJECT_CONFIG_JAM
    "${PROJECT_CONFIG_JAM}"
)
file(
    WRITE
    ${PROJECT_SOURCE_DIR}/project-config.jam
    "${NEW_PROJECT_CONFIG_JAM}"
)

