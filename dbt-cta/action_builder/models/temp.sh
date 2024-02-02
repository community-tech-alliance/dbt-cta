#!/bin/bash

# Function to replace "_base" in filenames
replace_in_filenames() {
  for file in "$1"/*; do
    if [ -f "$file" ]; then
      new_name="${file//_base/}" # Replace "_base" with an empty string
      if [ "$file" != "$new_name" ]; then
        mv "$file" "$new_name" # Rename the file
        echo "Renamed: $file -> $new_name"
      fi
    elif [ -d "$file" ]; then
      replace_in_filenames "$file" # Recursively process subdirectories
    fi
  done
}

# Start processing from the current directory
replace_in_filenames .

echo "Finished replacing '_base' in filenames."
