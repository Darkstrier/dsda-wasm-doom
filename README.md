# DSDA-Doom Cloud Launcher

An open-source, WebAssembly-compiled port of the DSDA-Doom source port, optimized to run natively inside modern web browsers. This project brings a high-performance, demo-compatible Doom engine to the web using Emscripten, SDL2, and WebGL.

To comply with copyright laws and security sandboxing, this page uses a **Local File Injection** method. The core open-source engine assets are hosted online, while commercial game data files (IWADs) and custom mods (PWADs) are safely read straight from your local hard drive into the browser's isolated memory pool on demand.

## Features

* **Zero Server Setup:** Play directly from a static web page (like GitHub Pages) without needing a local command-line server.
* **TrueType Retro Typography:** Styled with custom classic gaming fonts directly via CSS.
* **Pointer Lock API integration:** Automatic mouse capture and raw input handling when clicking inside the gameplay canvas.
* **Responsive Layout:** Pixel-perfect, crisp canvas upscaling that preserves performance on massive slaughtermaps.

## Repository Directory Structure

```text
web-doom/
├── source/                 # Complete corresponding C++ source code tree
│   └── prboom2/
│       ├── CMakeLists.txt  # Build setup featuring -sASYNCIFY and memory flags
│       └── ...
├── index.html              # Interactive web launcher interface
├── dsda-doom.js            # Emscripten JavaScript glue layer
├── dsda-doom.wasm          # Compiled WebAssembly binary
├── dsda-doom.wad           # Core engine asset file (menus, fonts, HUD)
├── AmazDooMLeft.ttf        # TrueType display font for the header title
├── LICENSE                 # GNU General Public License v2.0 text file
└── README.md               # Documentation and setup instructions
