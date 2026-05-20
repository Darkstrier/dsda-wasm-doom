#ifndef __EMSCRIPTEN__

// ============================================================================
// ORIGINAL DESKTOP IMPLEMENTATION (Hidden from WebAssembly compiler)
// ============================================================================

#include "config.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "sndfile.h"

#include "doomdef.h"
#include "i_sound.h"
#include "lprintf.h"
#include "z_zone.h"

typedef struct {
  SNDFILE *sf;
  SF_INFO sf_info;
} sndfile_handle_t;

void I_InitSndFile(void) {
  lprintf(LO_INFO, "I_InitSndFile: Initializing libsndfile\n");
}

#else

// ============================================================================
// EMSCRIPTEN WEB fallback
// ============================================================================

#include <stdio.h>

void I_InitSndFile(void) {
    // Simply do nothing; audio is handled smoothly via direct SDL_mixer elements
}

// Fallback stub to satisfy structural references in i_sound.c
// Replace your previous Load_SNDFile function in the #else block with this:
int Load_SNDFile(const void *a, int b, void *c, void *d) {
    (void)a; (void)b; (void)c; (void)d; // Prevent unused parameter warnings
    return 0; 
}

#endif // __EMSCRIPTEN__