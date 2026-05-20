cmake_minimum_required(VERSION 3.17...4.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

# setup dependencies options before project() so vcpkg features can be used
include(DsdaDepsSetup)

project("dsda-doom" VERSION 0.29.4)

set(dsda_is_top_project FALSE)
if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(dsda_is_top_project TRUE)
endif()

if(dsda_is_top_project)
    include(DsdaSanitiser)
endif()

include(DsdaHelpers)
if(dsda_is_top_project)
    dsda_set_default_build_config(RelWithDebInfo)
endif()

if(VCPKG_TOOLCHAIN)
    set(ENV{PKG_CONFIG_PATH} "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/pkgconfig")
endif()

set(PROJECT_TARNAME "dsda-doom")
set(WAD_DATA "dsda-doom.wad")
set(PROJECT_STRING "${PROJECT_NAME} ${PROJECT_VERSION}")

include(DsdaOptions)
include(DsdaTargetFeatures)
include(DsdaDependencies)
include(DsdaConfigHeader)

set(DSDA_OUTPUT_PATH ${CMAKE_BINARY_DIR})

set(WAD_DATA_PATH "${DSDA_OUTPUT_PATH}/${WAD_DATA}")

# force this to false to bypass crashing native build tools sub step
set(DSDA_BUILD_PWAD_WITH_EXTERNAL_PROJECT FALSE)

if(DSDA_BUILD_PWAD_WITH_EXTERNAL_PROJECT)
    set(DSDA_HOST_TOOLCHAIN ""
        CACHE FILEPATH "Toolchain file to build host tools with"
    )
    include(ExternalProject)
    ExternalProject_Add(dsda-doom-wad
        SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/data"
        ${DSDA_EXTERNAL_PROJECT_VS_ARGS}
        CMAKE_CACHE_ARGS
            "-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}"
            "-DWAD_DATA_PATH:FILEPATH=${WAD_DATA_PATH}"
            "-DCMAKE_TOOLCHAIN_FILE:FILEPATH=${DSDA_HOST_TOOLCHAIN}"
            "-DCMAKE_C_FLAGS:STRING=$ENV{CFLAGS_FOR_BUILD} $ENV{CPPFLAGS_FOR_BUILD}"
            "-DCMAKE_EXE_LINKER_FLAGS:STRING=$ENV{LDFLAGS_FOR_BUILD}"
        BUILD_ALWAYS TRUE
        BUILD_BYPRODUCTS "${WAD_DATA_PATH}"
        INSTALL_COMMAND ""
    )
else()
    # commented out so skips building native data tools
    # add_subdirectory(data)
endif()

# force compiler options globally for all source files
add_compile_options("-sUSE_SDL=2")
add_compile_options("-sUSE_SDL_MIXER=2")
add_compile_options("-sUSE_SDL_IMAGE=2")
add_compile_options("-sUSE_ZLIB=1")

# tell linker to include all sdl2 and zlib bindings in final wasm binary
if(EMSCRIPTEN)
    add_link_options(
        "-sUSE_SDL=2"
        "-sUSE_SDL_MIXER=2"
        "-sUSE_SDL_IMAGE=2"
        "-sUSE_ZLIB=1"
        "-sLEGACY_GL_EMULATION=1"
        "-sERROR_ON_UNDEFINED_SYMBOLS=0"
	"-sINITIAL_MEMORY=268435456"
        "-sALLOW_MEMORY_GROWTH=1"
	"-sASYNCIFY=1"
    )
endif()

# Build the actual source code
add_subdirectory(src)

# Commented out desktop application artifacts
# add_subdirectory(ICONS)

# install(FILES
#    "${WAD_DATA_PATH}"
#    DESTINATION "${DSDAPWADDIR}"
# )

install(FILES
    "COPYING"
    DESTINATION "${DSDA_INSTALL_COPYRIGHT_DIR}"
)

if(ENABLE_PACKAGING)
    add_subdirectory(packaging)
endif()