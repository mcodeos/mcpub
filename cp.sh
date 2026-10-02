#!/bin/bash

# Target directory (user's directory)
TARGET_DIR="~/.mcode"
TARGET_DIR_EXPANDED=$(eval echo "$TARGET_DIR")

# Determine the correct source directory for mcpub files
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

# Check if mcpub subdirectory exists, remove if it does
LIBS_DIR="$TARGET_DIR_EXPANDED/mcpub"
if [ -d "$LIBS_DIR" ]; then
    echo "Existing mcpub directory found, removing..."
    rm -rf "$LIBS_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Cannot remove existing mcpub directory"
        exit 1
    fi
    echo "Existing mcpub directory removed successfully"
fi

# Create mcpub subdirectory in target
mkdir -p "$LIBS_DIR"

# Copy the source directory contents to target, excluding repo plumbing:
# cp.sh itself, git metadata, and macOS cruft never belong in the installed lib.
echo "Copying mcpub files from $SOURCE_DIR to $LIBS_DIR..."
rsync -a \
    --exclude 'cp.sh' \
    --exclude '.git' \
    --exclude '.gitignore' \
    --exclude '.gitattributes' \
    --exclude '.DS_Store' \
    "$SOURCE_DIR"/ "$LIBS_DIR"/
if [ $? -ne 0 ]; then
    echo "Error: Cannot copy mcpub files"
    exit 1
fi

echo "Operation completed: mcpub files successfully copied to $TARGET_DIR/mcpub"
