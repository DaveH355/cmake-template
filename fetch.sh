#!/bin/bash

GITHUB_FILES=(
    "https://github.com/DaveH355/opengl-doc-wrapper/blob/main/include/gldoc.h"
    # Add more URLs here
)

mkdir -p ./external/singles
cd ./external/singles

for url in "${URLS[@]}"; do
    wget -N "$url"
done
