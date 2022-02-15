vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tricerat/g3log
    REF ae1d71641fb740badabbd84ae2bdc3e305d7b7cd #v1.3.4
    SHA512 eef8fb87003acd140e88ac0a25d81676e21d632afd1dd12f9fc43fd54748720ada3ca69f1320568ca433ec0ed7437bc7c907948237d4cf023277ffb570e915d1
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" G3_SHARED_LIB)
string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "dynamic" G3_SHARED_RUNTIME)

# https://github.com/KjellKod/g3log#prerequisites
set(VERSION "1.3.4")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DG3_SHARED_LIB=${G3_SHARED_LIB} # Options.cmake
        -DG3_SHARED_RUNTIME=${G3_SHARED_RUNTIME} # Options.cmake
        -DADD_FATAL_EXAMPLE=OFF
        -DADD_G3LOG_BENCH_PERFORMANCE=OFF
        -DADD_G3LOG_UNIT_TEST=OFF
        -DVERSION=${VERSION}
        -DUSE_DYNAMIC_LOGGING_LEVELS=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/g3log)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
