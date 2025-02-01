#!/bin/bash

# Check if a file path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_structure_file>"
    exit 1
fi

STRUCTURE_FILE="$1"

# Check if the file exists
if [ ! -f "$STRUCTURE_FILE" ]; then
    echo "Error: File $STRUCTURE_FILE does not exist"
    exit 1
fi

# Create directories and files
while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines and comments
    if [ -z "$line" ] || [[ "$line" =~ ^#.* ]]; then
        continue
    fi

    # Remove leading/trailing whitespace
    line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

    # Check if line ends with /
    if [[ "$line" == */ ]]; then
        # Create directory
        echo "Creating directory: $line"
        mkdir -p "$line"
    else
        # Create file and its parent directory
        echo "Creating file: $line"
        mkdir -p "$(dirname "$line")"
        touch "$line"
    fi
done < "$STRUCTURE_FILE"

echo "Project structure created successfully!"