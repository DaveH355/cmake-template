#!/bin/bash

SRC_DIR="./src"
ASSETS_DIR="./assets"

# Check if .clang-format file exists
if [ ! -f "./.clang-format" ]; then
    echo ".clang-format file not found in project root"
    exit
fi

# Format C++ files including subdirectories
find "$SRC_DIR" \( -name "*.cpp" -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.hxx" \) -exec clang-format -i -style=file {} \;

# Format GLSL shader files
# find "$ASSETS_DIR" \( -name "*.vert" -o -name "*.frag" -o -name "*.comp" \) -exec clang-format -i -style=file {} \;

echo "Format finished"
