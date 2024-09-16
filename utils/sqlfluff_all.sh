#!/bin/bash

# Set the base directory to the location of your folders
BASE_DIR="dbt-cta"
count=0  # Initialize a counter to limit to 3 folders

# Iterate over each folder in the base directory
for folder in "$BASE_DIR"/*; do
  if [ -d "$folder" ]; then
    # Extract folder name from the full path
    foldername=$(basename "$folder")
    
    # Set SYNC_NAME to the folder name
    SYNC_NAME="$foldername"
    
    # Print the sync name (optional, for debugging)
    echo "Processing folder: $SYNC_NAME"
    
    # Print the full sqlfluff command
    echo "Running command: pipenv run sqlfluff fix $BASE_DIR/$foldername/"
    
    # Run the sqlfluff fix command
    pipenv run sqlfluff fix "$BASE_DIR/$foldername/"
    
    # Increment the counter and break the loop if it's reached 3 folders
    ((count++))
    if [ "$count" -ge 2 ]; then
      break
    fi
  fi
done
