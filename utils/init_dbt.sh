#!/usr/bin/env bash

# Confused? Check the README :D

set -o pipefail

command="gum -v &>/dev/null"
if [[ "$(command)" -ne 0 ]]; then
    printf '%s' "You must have gum installed in order to use this script. Run brew install gum to continue.";
    exit 1;
fi

while [ -z "$DIR_NAME" ]; do
    DIR_NAME="$(gum input --prompt "Enter your directory name: " --placeholder "vendor_name")"
    if [[ $? != 0 ]]; then
    echo "Ctrl-C caught, exiting..."
    exit 1
fi
done
if [[ "$DIR_NAME" ]]; then
    CONFIRMED="$(gum confirm "Confirm that your path is correct: $PWD/${DIR_NAME}")"
fi
# if [[ -z "$CONFIRMED" || "$CONFIRMED" == "" ]]; then
#     exit 1;
# fi
while [[ -z "$TARBALL_LOCATION" ]]; do
    FOUND_TARBALL_LOCATION="$(find . -name "*.tar.gz")"
    if [[ -n "$FOUND_TARBALL_LOCATION" && "$FOUND_TARBALL_LOCATION" != "" ]]; then
        $(gum confirm "Tarball found, is this correct? ${FOUND_TARBALL_LOCATION}") \
            && TARBALL_LOCATION="$FOUND_TARBALL_LOCATION" \
            || TARBALL_LOCATION=$(gum input --prompt "Enter the location of the tarball obtained from Airbyte: " --placeholder "3365.tar.gz")
    else
        TARBALL_LOCATION=$(gum input --prompt "Enter the location of the tarball obtained from Airbyte: " --placeholder "3365.tar.gz")
    fi
    if [[ $? != 0 ]]; then
    echo "Ctrl-C caught, exiting......"
    exit 1
fi
done
DIR_UNDER=${DIR_NAME//-\s/_}

printf '%s' "Moving folders out of 0..."
rm -rf $DIR_UNDER; mkdir $DIR_UNDER
tar --strip-components=11 -C "$DIR_NAME" -zxvf "$TARBALL_LOCATION" "var/lib/docker/volumes/airbyte_workspace/_data/*/0/normalize/models/generated"

gum format "Moving models folders..."
mkdir -p "$DIR_NAME"/models
mv "$DIR_NAME"/airbyte_* "$DIR_NAME"/models

# Move Airbyte-generated CTEs and modify references
# These always exist, so we do not check for the directory
# in the downloaded tarball
printf '%s' "Moving ctes..."
mv "$DIR_NAME"/models/airbyte_ctes*/**/ "$DIR_NAME"/models/0_ctes
printf 'Modifying references in 0_ctes for %s' "$DIR_NAME"
for file in $(ls "$DIR_NAME"/models/0_ctes/); do
	sed -i 's/\`\prod.*\(_airbyte_raw_[^ ]*\)/{{ source("'"cta"'", "'"\1"'" \) }}/g' "$DIR_NAME"/models/0_ctes/$file;
    sed -i 's/\`\prod.*\(\`\w+\`[^ ]*\)/{{ source("'"cta"'", "'"\1"'" \) }}/g' "$DIR_NAME"/models/0_ctes/$file;
done

# Move Airbyte-generated full-refresh tables and modify references
# if they exist in tarball
if [[ -d "${DIR_NAME}/models/airbyte_tables/" ]]; then
	printf '%s' "Full-refresh models found, moving into 1_cta_tables"
  	mv "$DIR_NAME"/models/airbyte_tables/**/ "$DIR_NAME"/models/1_cta_tables
    
    printf 'Modifying references in 1_cta_base for %s' "$DIR_NAME"
    for file in $(ls "$DIR_NAME"/models/1_cta_tables/); do
	    sed -i 's/\`\prod.*\(_airbyte_raw_[^ ]*\)/{{ source("'"cta"'", "'"\1"'" \) }}/g' "$DIR_NAME"/models/1_cta_tables/$file;
    done
fi

# Move Airbyte-generated incremental tables and modify references
# if they exist in tarball
if [[ -d "${DIR_NAME}/models/airbyte_incremental/" ]]; then
	printf '%s' "Incremental models found, moving into 1_cta_base"
	mv "$DIR_NAME"/models/airbyte_incremental*/**/ "$DIR_NAME"/models/1_cta_base

    printf 'Modifying references in 1_cta_base for %s' "$DIR_NAME"
    for file in $(ls "$DIR_NAME"/models/1_cta_base/); do
	    sed -i 's/\`\prod.*\(_airbyte_raw_[^ ]*\)/{{ source("'"cta"'", "'"\1"'" \) }}/g' "$DIR_NAME"/models/1_cta_base/$file;
    done
fi

gum format "Cleaning up after myself..."
printf '%s' "rm -rf "$DIR_NAME"/models/airbyte_ctes "$DIR_NAME"/models/airbyte_incremental "$DIR_NAME"/models/airbyte_tables"
rm -rf "$DIR_NAME"/models/airbyte_ctes "$DIR_NAME"/models/airbyte_incremental "$DIR_NAME"/models/airbyte_tables

printf 'Modifying references in 0_ctes for %s' "$DIR_NAME"

gum format "Have a proggy day! 🐸"