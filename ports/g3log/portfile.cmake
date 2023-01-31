vcpkg_minimum_required(VERSION 2022-10-12) # for ${VERSION}
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tricerat/g3log
    REF 59641c75bc850e64c0c1c18a80a486e8d4c17ee1 #v2.1 master w/Tricerat edits
    SHA512 00AB44285C48D72107A3B880CAEADB7A1D3C1BB31A99DD5135492C96DA1FCDB2E1169D02A2CAE3B69BD08FCBD7AD77113C95547933A39CB81E71789856E4430C
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" G3_SHARED_LIB)
string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "dynamic" G3_SHARED_RUNTIME)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DG3_SHARED_LIB=${G3_SHARED_LIB} # Options.cmake
        -DG3_SHARED_RUNTIME=${G3_SHARED_RUNTIME} # Options.cmake
        -DADD_FATAL_EXAMPLE=OFF
        -DADD_G3LOG_BENCH_PERFORMANCE=OFF
        -DADD_G3LOG_UNIT_TEST=OFF
        -DVERSION=${VERSION}
        -DUSE_DYNAMIC_LOGGING_LEVELS=ON
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/g3log)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
