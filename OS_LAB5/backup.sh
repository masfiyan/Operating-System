#!/bin/bash

# Create the backup directory if it doesn't exist
backup_dir="$HOME/backup"
mkdir -p "$backup_dir"

# Iterate through each file in the home directory
for file in "$HOME"/*; do
    # Check if the file is a regular file (not a directory)
    if [ -f "$file" ]; then
        # Extract the file name without the path
        filename=$(basename "$file")
        
        # Create a backup file in the backup directory
        cp "$file" "$backup_dir/$filename.bak"
        
        # Check if the operation was successful
        if [ $? -eq 0 ]; then
            echo "Backup of '$filename' created successfully."
        else
            echo "Error: Failed to create a backup of '$filename'."
        fi
    fi
done
