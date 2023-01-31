vcpkg_minimum_required(VERSION 2022-10-12) # for ${VERSION}

# header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uNetworking/uWebSockets
    REF 46c8aebc0e78f818dacfcc216f0e801d931f4810 # v20.36.0
    SHA512 2C77653830BF1B3A61F0B559D3B9D2A45A20D4E3371FC24E063E22240F87B13E72F6984FF81FD9BFFFCC34DEA143234DA8BDA5ED40846194DC18CA48FDD147A3
    HEAD_REF master
)

file(COPY "${SOURCE_PATH}/src"  DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(RENAME "${CURRENT_PACKAGES_DIR}/include/src" "${CURRENT_PACKAGES_DIR}/include/uwebsockets")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
