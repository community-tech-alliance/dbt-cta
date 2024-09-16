#!/bin/bash
# Run this from the root directory in order to use the .sqlfluff configs: sh utils/sqlfluff_all.sh

# Set the base directory to the location of your folders
BASE_DIR="dbt-cta"

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
    
  fi
done
