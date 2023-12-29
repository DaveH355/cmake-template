#!/bin/bash

SRC_DIR="./src"

CLANG_FORMAT_FILE="./.clang-format"

# Check if clang-format is installed
if ! command -v clang-format &> /dev/null
then
    echo "clang-format could not be found"
    exit
fi

# Check if .clang-format file exists
if [ ! -f "$CLANG_FORMAT_FILE" ]; then
    echo ".clang-format file not found in project root"
    exit
fi

# Format files including subdirectories
find "$SRC_DIR" \( -name "*.cpp" -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.hxx" \) -exec clang-format -i -style=file {} \;

echo "Format finished"
