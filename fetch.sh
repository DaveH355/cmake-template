#!/bin/bash

# Define list of GitHub file URLs
GITHUB_FILES=(
    "https://github.com/DaveH355/opengl-doc-wrapper/blob/main/include/gldoc.h"
    # Add more URLs here
)

if ! mkdir -p ./external/singles; then
    echo "Error creating directory ./external/singles" >&2
    exit 1
fi

for GITHUB_URL in "${GITHUB_FILES[@]}"; do

    RAW_URL=$(echo "${GITHUB_URL}" | sed "s/github\.com/raw.githubusercontent.com/; s/blob\///")

    # Extract the file name from URL
    FILE_NAME="${RAW_URL##*/}"

    FILE_PATH="./external/singles/${FILE_NAME}"

    # Check if the file exists and get checksum
    [ -f "${FILE_PATH}" ] && BEFORE_CHECKSUM=$(md5sum "${FILE_PATH}" | cut -d ' ' -f 1)

    # Download the file
    if ! curl -sS -L "${RAW_URL}" -o "${FILE_PATH}" > /dev/null; then
        echo "Error downloading ${FILE_NAME}" >&2
        continue
    fi

    # Calculate checksum after download
    AFTER_CHECKSUM=$(md5sum "${FILE_PATH}" | cut -d ' ' -f 1)

    if [ -n "${BEFORE_CHECKSUM}" ] && [ "${BEFORE_CHECKSUM}" != "${AFTER_CHECKSUM}" ]; then
        echo "Updated ${FILE_NAME}"
    elif [ -n "${BEFORE_CHECKSUM}" ]; then
        echo "No updates available for ${FILE_NAME}"
    else
        echo "Added ${FILE_NAME}"
    fi
done
