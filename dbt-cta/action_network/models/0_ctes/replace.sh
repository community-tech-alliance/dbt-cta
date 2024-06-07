#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define the string to search for in filenames
SEARCH_STRING="ab4"

# Define the replacement string for line 8
REPLACEMENT_LINE="    ROW_NUMBER() OVER (PARTITION BY id ORDER BY _airbyte_extracted_at desc) as rownum"

# Loop through each SQL file in the directory
for FILE in "$SCRIPT_DIR"/*"$SEARCH_STRING"*.sql; do
  # Check if the file exists to avoid errors when no files match the pattern
  if [[ -f "$FILE" ]]; then
    # Output the file being processed
    echo "Processing $FILE"
    
    # Create a temporary file
    TMP_FILE=$(mktemp)
    
    # Use awk to replace line 8 with the replacement line
    awk -v replacement="$REPLACEMENT_LINE" 'NR==8{$0=replacement}1' "$FILE" > "$TMP_FILE"
    
    # Move the temporary file to overwrite the original file
    mv "$TMP_FILE" "$FILE"
    
    echo "Updated line 8 in $FILE"
  else
    echo "No files matching the pattern '*$SEARCH_STRING*.sql' found."
  fi
done
