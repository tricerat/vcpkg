vcpkg_minimum_required(VERSION 2022-10-12) # for ${VERSION}
vcpkg_check_linkage(ONLY_STATIC_LIBRARY) #Upstream only support static compilation: https://github.com/uNetworking/uSockets/commit/b950efd6b10f06dd3ecb5b692e5d415f48474647

if(NOT VCPKG_TARGET_IS_LINUX)
   set(USE_LIBUV ON)
endif()

if ("network" IN_LIST FEATURES AND NOT VCPKG_TARGET_IS_WINDOWS)
    message(FATAL_ERROR "Feature 'network' is only supported on Windows")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uNetworking/uSockets
    REF b950efd6b10f06dd3ecb5b692e5d415f48474647 # 0.8.5
    SHA512 2E8572A8B96EF475FF806F8E79EFC8E78701FD600715B66401232E3B363C597B9AB0A8EA3C682469E81881F20296B5F4ABDF467B5C53DCB99CA62D7ED4842E37
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        ssl CMAKE_USE_OPENSSL
        event CMAKE_USE_EVENT
        network CMAKE_USE_NETWORK
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        "-DLIBUS_USE_LIBUV=${USE_LIBUV}"
    OPTIONS_DEBUG
        -DINSTALL_HEADERS=OFF
)

vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

vcpkg_copy_pdbs()
