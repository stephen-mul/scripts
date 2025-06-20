#!/bin/bash

# Check number of arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <PROJECT> <PATH_TO_BIB> <NEW_NAME>"
  echo "Example: $0 OPT /path/to/cite.bib my_citation"
  exit 1
fi

PROJECT=$1
BIB_PATH=$2
NEW_NAME=$3

# Resolve destination directory
case "$PROJECT" in
  OPT)
    DEST_DIR="/home/stephen/Documents/projects/optimal_detector/paper/citations"
    ;;
  *)
    echo "Invalid project shorthand: $PROJECT"
    echo "Supported options: OPT"
    exit 1
    ;;
esac

# Ensure .bib file exists
if [ ! -f "$BIB_PATH" ]; then
  echo "Error: .bib file '$BIB_PATH' does not exist."
  exit 1
fi

# Ensure destination directory exists
mkdir -p "$DEST_DIR"

# Move and rename the .bib file
DEST_FILE="$DEST_DIR/${NEW_NAME}.bib"
mv "$BIB_PATH" "$DEST_FILE"

# Copy to clipboard
cat "$DEST_FILE" | xclip -selection clipboard

echo "Moved to $DEST_FILE and copied to clipboard."

