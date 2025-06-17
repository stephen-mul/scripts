#!/bin/bash

# Check if a filename was provided as an argument
if [ $# -eq 0 ]; then
    echo "Error: No filename provided."
    echo "Usage: $0 <new_filename>"
    exit 1
fi

# Define the source and destination paths
SOURCE_FILE="$HOME/Downloads/event.ics"
DEST_DIR="$HOME/Downloads/ics_files"
DEST_FILE="$DEST_DIR/$1.ics"

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file $SOURCE_FILE does not exist."
    exit 1
fi

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Move and rename the file
mv "$SOURCE_FILE" "$DEST_FILE"

# Check if the move was successful
if [ $? -eq 0 ]; then
    echo "File moved successfully to $DEST_FILE"

    # Import the .ics file into the specified Google Calendar
    if gcalcli import "$DEST_FILE" --calendar stephenbmulligan@gmail.com; then
        echo "Calendar event imported successfully."
    else
        echo "Error: Failed to import the calendar event."

         # Rename it back to event.ics in original location
        echo "Restoring file as event.ics in original location..."
        mv "$DEST_FILE" "$SOURCE_FILE"
        
        if [ $? -eq 0 ]; then
            echo "File restored to $SOURCE_FILE"
        else
            echo "Error: Failed to restore file to original location."
        fi
    fi
else
    echo "Error: Failed to move the file."
fi

