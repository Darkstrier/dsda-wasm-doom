include_guard()

if(STRICT_FIND)
  set(dsda_strict_keyword REQUIRED)
endif()

add_library(dsda_dependencies INTERFACE IMPORTED)
add_library(dsda::dependencies ALIAS dsda_dependencies)

# 1. Create dummy interface targets to satisfy CMake's dependencies check
# Emscripten will supply the real versions of these via linker flags later.
foreach(lib OpenGL::GL OpenGL::GLU SndFile::sndfile libzip::zip ZLIB::ZLIB dsda::SDL2 dsda::xmp)
  if(NOT TARGET ${lib})
    add_library(${lib} INTERFACE IMPORTED)
  endif()
endforeach()

# 2. Tell the engine that we found the optional libraries Emscripten provides
set(HAVE_LIBSDL2_IMAGE TRUE)
set(HAVE_LIBVORBISFILE TRUE)

# 3. Explicitly disable desktop-specific sound/midi dependencies
set(HAVE_LIBMAD FALSE)
set(HAVE_LIBFLUIDSYNTH FALSE)
set(HAVE_LIBPORTMIDI FALSE)

# 4. Bind our dummy dependencies to the master library list
target_link_libraries(dsda_dependencies
  INTERFACE
  OpenGL::GL
  OpenGL::GLU
  SndFile::sndfile
  libzip::zip
  ZLIB::ZLIB
  dsda::SDL2
  dsda::xmp
)