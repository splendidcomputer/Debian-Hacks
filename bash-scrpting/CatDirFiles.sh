#!/bin/bash

# Get the current directory
current_dir=$(pwd)

# List all files in the directory
for file in $current_dir/*; do
    # Check if it is a regular file
    if [[ -f "$file" ]]; then
        # Print the file name
        echo "\n===== File: $(basename "$file") ====="
        
        # Print the contents of the file
        cat "$file"
    fi
done
