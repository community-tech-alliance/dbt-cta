#!/usr/bin/env bash

# Confused? Check the README :D

####  FUNCTIONS  ####
copy_dbt_from_airbyte() {

    # Set environment vars for copy script
    ALLOWED_ENVIRONMENTS="dev\nprod"

    ENVIRONMENT=$(echo -e $ALLOWED_ENVIRONMENTS | gum filter --placeholder "Which Airbyte Environment should be used?")
    WORKSPACE_ID=$(gum input --placeholder "Airbyte Workspace ID ex. 814")
    
    # Prompt if Cacher Snippet should be downloaded
    if gum confirm "Download Cacher script to copy an Airbyte workspace?"; then
        # Get Cacher creds from user
        CACHER_API_KEY=$(gum input --placeholder "Enter your Cacher API Key -> https://app.cacher.io/enter?action=view_api_creds")
        CACHER_API_TOKEN=$(gum input --placeholder "Enter your Cacher API Token -> https://app.cacher.io/enter?action=view_api_creds")
        # This is just the ID to the Cacher snippet that holds a script to extract an Airbyte Workspace from the Airbyte server.
        # https://docs.airbyte.com/operator-guides/transformation-and-normalization/transformations-with-dbt/#exporting-dbt-normalization-project-outside-airbyte
        CACHER_SNIPPET_GUID="2b77280d537736f980f9" 

        mkdir -p $ROOT_PATH/.cta
        cd $ROOT_PATH/.cta
        pipenv run python $ROOT_PATH/utils/dbt_format_utils.py getCacherScript \
        --cacherSnippetGUID $CACHER_SNIPPET_GUID \
        --cacherApiKey $CACHER_API_KEY \
        --cacherApiToken $CACHER_API_TOKEN \
        --outputPath copy_airbyte_workspace.sh
        RET=$?
        if [[ $RET -ne 0 ]]; then
            echo "Failed to download Cacher Script. Exiting"
            exit 1
        fi  
        chmod +x copy_airbyte_workspace.sh
        cd $ROOT_PATH
    fi

    # Run script to copy Airbyte Workspace to local
    echo "Starting job to copy Airbyte workspace.."
    ./.cta/copy_airbyte_workspace.sh -e $ENVIRONMENT -w $WORKSPACE_ID
    RET=$?
    if [[ $RET -ne 0 ]]; then
        echo "Failed to grab normalization dbt for workspace: $WORKSPACE_ID from $ENVIRONMENT Airbyte"
    else
        echo "Airbyte Workspace $WORKSPACE_ID exported to local directory -> airbyte_dbt_export/$WORKSPACE_ID"
    fi
}

format_airbyte_dbt() {
    
    # Get target path for dbt from user
    while [ -z "$DIR_NAME" ]; do
        DIR_NAME=$(gum input --prompt "Enter the target directory name (name of directory to create in dbt-cta): " --placeholder "vendor_name (ex. actblue)")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    TARGET_PATH="$ROOT_PATH/dbt-cta/$DIR_NAME/"
    gum confirm "Confirm the Target Path is correct: $TARGET_PATH" || exit 1
    # Check to see if Directory exists, if not create it
    if [[ ! -d $TARGET_PATH ]]; then
        mkdir -p $TARGET_PATH
    fi

    # Get path to exported Airbyte Workspace
    while [ -z "$WORKSPACE" ]; do
        WORKSPACE=$(gum input --prompt "Enter the path of the exported Airbyte Workspace: " --placeholder "airbyte_dbt_export/814/")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
        WORKSPACE_PATH="$ROOT_PATH/$WORKSPACE"
    done
    WORKSPACE_PATH="$ROOT_PATH/$WORKSPACE"
    gum confirm "Confirm the Airbyte Worspace Path is correct: $WORKSPACE_PATH" || exit 1
    # Check to see if Workspace Path actually exists
    if [[ ! -d $WORKSPACE_PATH ]]; then
        echo "The entered path for the Airbyte Workspace doesnt exist. Path: $WORKSPACE_PATH"
    fi
    pipenv run python $ROOT_PATH/utils/dbt_format_utils.py restructAirbyteDbt --airbyteWorkspacePath $WORKSPACE_PATH --dbtCtaPath $TARGET_PATH

}

append_base_to_files() {
    # Get target path for directory that should be modified from user
    while [ -z "$DIR_NAME" ]; do
        DIR_NAME=$(gum input --prompt "Enter the directory name of the base tables to rename: " --placeholder "(ex. dbt-cta/actblue/1_cta_incremental/)")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    gum confirm "Confirm the Base models path is correct: $ROOT_PATH/$DIR_NAME" || exit 1
    echo "Starting job to rename base model files..."
    echo ""
    pipenv run python $ROOT_PATH/utils/dbt_format_utils.py renameBaseTables --basePath $ROOT_PATH/$DIR_NAME
    echo ""
    echo "Base models have been renamed! You can copy/pasta the outputted list into your sources.yml file."
}

generate_matviews() {
    # Get target path for directory holding Base models
    while [ -z "$INPUT_DIR_NAME" ]; do
        INPUT_DIR_NAME=$(gum input --prompt "Enter the directory name of the base models to generate matviews for: " --placeholder "(ex. dbt-cta/actblue/1_cta_incremental/)")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    gum confirm "Confirm the Base models path is correct: $ROOT_PATH/$INPUT_DIR_NAME" || exit 1

    # Get target path for directory where matviews should be created
    while [ -z "$OUTPUT_DIR_NAME" ]; do
        OUTPUT_DIR_NAME=$(gum input --prompt "Enter the directory name where matviews should be placed: " --placeholder "(ex. dbt-cta/actblue/2_partner_matviews/)")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    gum confirm "Confirm the Base models path is correct: $ROOT_PATH/$OUTPUT_DIR_NAME" || exit 1

    pipenv run python $ROOT_PATH/utils/dbt_format_utils.py createMatViews --basePath $ROOT_PATH/$INPUT_DIR_NAME --outputPath $ROOT_PATH/$OUTPUT_DIR_NAME
}

generate_dbt_tests() {
    # Get target path for vendor directory
    while [ -z "$INPUT_DIR_NAME" ]; do
        INPUT_DIR_NAME=$(gum input --prompt "Enter the name of the vendor to generate tests for: " --placeholder "(ex. actblue)")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    gum confirm "Confirm the vendor name is correct: $INPUT_DIR_NAME" || exit 1

    cd $ROOT_PATH
    pipenv run python $ROOT_PATH/utils/generate_schema_yml.py --sync-name "$INPUT_DIR_NAME" --merge
}

init() {
    cd $ROOT_PATH
    pip install pipenv
    pipenv install
}

#### ENTRY POINT ####

set -o pipefail
# Absolute path to this script
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in
SCRIPT_PATH=$(dirname "$SCRIPT")
# Move to root of git repo and set as ROOT_PATH
ROOT_PATH=$(cd "$SCRIPT_PATH"/..; pwd)

command="gum -v &>/dev/null"
if [[ "$(command)" -ne 0 ]]; then
    printf '%s' "You must have gum installed in order to use this script. Run brew install gum to continue.";
    exit 1;
fi

# Options
INIT="Initialize Python virtual env"
COPY_FROM_AIRBYTE="Copy dbt from an Airbyte Workspace"
FORMAT_AIRBYTE_DBT="Format exported Airbyte dbt to CTA structure"
APPEND_BASE_TO_FILES="Add '_base' suffix to all models in a folder"
GENERATE_MATVIEWS="Generate Matviews for all the models in a folder"
GENERATE_DBT_TESTS="Generate dbt Tests for a vendor dbt folder"


FUNCTION=$(gum choose "$INIT" "$COPY_FROM_AIRBYTE" "$FORMAT_AIRBYTE_DBT"  "$APPEND_BASE_TO_FILES" "$GENERATE_MATVIEWS" "$GENERATE_DBT_TESTS")

if [[ -n $FUNCTION ]]; then
    case "$FUNCTION" in
        "$INIT")
            command="init"
            ;;
        "$COPY_FROM_AIRBYTE")
            command="copy_dbt_from_airbyte"
            ;;
        "$FORMAT_AIRBYTE_DBT")
            command="format_airbyte_dbt"
            ;;
        "$APPEND_BASE_TO_FILES")
            command="append_base_to_files"
            ;;
        "$GENERATE_MATVIEWS")
            command="generate_matviews"
            ;;
        "$GENERATE_DBT_TESTS")
            command="generate_dbt_tests"
            ;;
    esac
    # Confirm choice 
    gum confirm "Confirm selection: ${FUNCTION}?" && $command "$@"
fi

