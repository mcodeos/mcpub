#!/bin/bash

# Target directory (user's directory)
TARGET_DIR="~/.mcode"
TARGET_DIR_EXPANDED=$(eval echo "$TARGET_DIR")

# Determine the correct source directory for mclibs files
# Always use the directory containing this script as the base
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR"

echo "Script directory: $SCRIPT_DIR"
echo "Source directory: $SOURCE_DIR"

# Check if target directory exists, create if not
if [ ! -d "$TARGET_DIR_EXPANDED" ]; then
    echo "Target directory does not exist, creating..."
    mkdir -p "$TARGET_DIR_EXPANDED"
    if [ $? -ne 0 ]; then
        echo "Error: Cannot create target directory"
        exit 1
    fi
    echo "Target directory created successfully"
fi

# Check if mclibs subdirectory exists, remove if it does
LIBS_DIR="$TARGET_DIR_EXPANDED/mclibs"
if [ -d "$LIBS_DIR" ]; then
    echo "Existing mclibs directory found, removing..."
    rm -rf "$LIBS_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Cannot remove existing mclibs directory"
        exit 1
    fi
    echo "Existing mclibs directory removed successfully"
fi

# Create mclibs subdirectory in target
mkdir -p "$LIBS_DIR"

# Copy only the contents of the source directory to target
# This ensures we only copy mclibs files, not other project files
echo "Copying mclibs files from $SOURCE_DIR to $LIBS_DIR..."
cp -r "$SOURCE_DIR"/* "$LIBS_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Cannot copy mclibs files"
    exit 1
fi

echo "Operation completed: mclibs files successfully copied to $TARGET_DIR/mclibs"
