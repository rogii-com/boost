
file(
    READ
    ${PROJECT_SOURCE_DIR}/project-config.jam
    PROJECT_CONFIG_JAM
)
string(
    REGEX REPLACE
    "using[ \t]+msvc[^;]*;"
    "using msvc : 14.2 : : <setup>msvc-mock.bat ;"
    NEW_PROJECT_CONFIG_JAM
    "${PROJECT_CONFIG_JAM}"
)
file(
    WRITE
    ${PROJECT_SOURCE_DIR}/project-config.jam
    "${NEW_PROJECT_CONFIG_JAM}"
)

