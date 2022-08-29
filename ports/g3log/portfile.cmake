vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tricerat/g3log
    REF fa59807d2f462ec1a5802b47c1b7d5c45a26f942 #8-29-2022 master w/Tricerat edits (v1.3.4 was last tagged release)
    SHA512 B33BB39C637D7AF72448CDC7C2318473F46C0FE75BDF70459EE9AF8258DFA2D1E1D8C03BA868A6B169A7B44CBB7EE876FE550CBB25B7F18C69FB67D31EB798BB
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
