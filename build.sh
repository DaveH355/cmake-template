#!/bin/bash

set -e  # Exit on first error

CONFIG_FILE=".build-config"

# Set defaults
BUILD_TYPE="Debug"
COMPILER="gcc"

# Load previous configuration if it exists
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
fi

# Parse command line arguments
while getopts "b:r:c:" opt; do
  case $opt in
    b)
      BUILD_TYPE=$OPTARG
      ;;
    r)
      RELOAD_ONLY=true
      ;;
    c)
      COMPILER=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Save current configuration
echo "BUILD_TYPE=\"$BUILD_TYPE\"" > "$CONFIG_FILE"
echo "COMPILER=\"$COMPILER\"" >> "$CONFIG_FILE"

# Choose compiler
if [[ "$COMPILER" == "clang" ]]; then
  export CC=clang
  export CXX=clang++
elif [[ "$COMPILER" == "gcc" ]]; then
  export CC=gcc
  export CXX=g++
else
  echo "Invalid compiler: $COMPILER. Valid compilers are gcc, clang."
  exit 1
fi

BUILD_DIR="build_${BUILD_TYPE}_${COMPILER}"

# Create build directory if it does not exist
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# rerun cmake incase changes were made 
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE ..

# Copy compile_commands.json file
if [ -f "compile_commands.json" ]; then
  echo "Copying compile_commands.json to project root..."
  cp compile_commands.json ../
else
  echo "No compile_commands.json found in current build directory"
fi

if [ "$RELOAD_ONLY" ]; then
  echo "Reload cmake only option is set. Finished and Exiting..."
  exit
fi

echo "Building project with $COMPILER..."
make

./opengl_playground
