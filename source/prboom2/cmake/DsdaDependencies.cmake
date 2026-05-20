include_guard()

if(STRICT_FIND)
  set(dsda_strict_keyword REQUIRED)
endif()

add_library(dsda_dependencies INTERFACE IMPORTED)
add_library(dsda::dependencies ALIAS dsda_dependencies)

foreach(lib OpenGL::GL OpenGL::GLU SndFile::sndfile libzip::zip ZLIB::ZLIB dsda::SDL2 dsda::xmp)
  if(NOT TARGET ${lib})
    add_library(${lib} INTERFACE IMPORTED)
  endif()
endforeach()

set(HAVE_LIBSDL2_IMAGE TRUE)
set(HAVE_LIBVORBISFILE TRUE)

set(HAVE_LIBMAD FALSE)
set(HAVE_LIBFLUIDSYNTH FALSE)
set(HAVE_LIBPORTMIDI FALSE)

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