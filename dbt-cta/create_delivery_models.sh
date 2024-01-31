#!/bin/bash

# Loop through all subdirectories in the current directory
for folder in */; do
    folder="${folder%/}" # Remove trailing slash if present
    if [ -d "$folder" ]; then
        # Create the '2_cta_delivery' folder if it doesn't exist
        mkdir -p "$folder/models/2_cta_delivery"

        # Copy files from 'models/2_partner_matviews' to '2_cta_delivery' with the 'cta_' prefix
        cp "$folder/models/2_partner_matviews"/* "$folder/models/2_cta_delivery/"
        pushd "$folder/models/2_cta_delivery/"

        # Add 'cta_' prefix to the filenames
        for file in *; do
            new_filename="cta_$file"
            mv "$file" "$new_filename"
        done

        echo "Created '2_cta_delivery' folder in '$folder' and copied files with 'cta_' prefix."

        # Return to the original directory
        popd
    fi
done
