#!/usr/bin/env bash

# Confused? Check the README :D

####  FUNCTIONS  ####
copy_dbt_from_airbyte() {

    # Set environment vars for copy script
    ALLOWED_ENVIRONMENTS="dev\nprod"

    ENVIRONMENT=$(echo -e $ALLOWED_ENVIRONMENTS | gum filter --placeholder "Which Airbyte Environment should be used?")
    kubectl &> /dev/null
    RET=$?
    if [[ "$RET" -ne 0 ]]; then
        echo "kubectl isn't installed, please install and try again."
        exit 1;
    fi
    if [[ "$ENVIRONMENT" == "prod" ]]; then
        while [ -z "$PROD_CONFIRM_PROJECT_ID" ]; do
            PROD_CONFIRM_PROJECT_ID=$(\
            gum input --cursor.foreground "#FF0" --prompt.foreground "#0FF" --prompt "* " \
            --placeholder "Are you sure you want to use the production context? Enter CTA's prod Google Project ID: " --width 160)
            if [[ $? != 0 ]]; then
                echo "Ctrl-C caught, exiting..."
                exit 1
            fi
        done 
        if [[ "$PROD_CONFIRM_PROJECT_ID" != "" ]]; then
            gcloud config set project "$PROD_CONFIRM_PROJECT_ID"
            RET=$?
            if [[ "$RET" -eq 0 ]]; then
                gcloud container clusters get-credentials airbyte-prod-cluster --region us-central1
            fi
        fi
    elif [[ "$ENVIRONMENT" == "dev" ]]; then
        while [ -z "$DEV_PROJECT_ID" ]; do
            gum input --cursor.foreground "#FF0" --prompt.foreground "#0FF" --prompt "* " \
            --placeholder "Enter CTA's dev Google Project ID: " --width 160)
            if [[ $? != 0 ]]; then
                echo "Ctrl-C caught, exiting..."
                exit 1
            fi
        done 
        if [[ "$DEV_PROJECT_ID" != "" ]]; then
            gcloud config set project "$DEV_PROJECT_ID"
            RET=$?
            if [[ "$RET" -eq 0 ]]; then
                gcloud container clusters get-credentials airbyte-dev-cluster --region us-central1
            fi
        fi
    fi

    # Run script to copy Airbyte Workspace to local
    echo "Starting job to copy Airbyte workspace.."
    # ./copy_dbt_from_k8s_pod.sh <POD_NAME_REGEX_PATTERN> <NAMESPACE> <CONTAINER_NAME>"
    ./copy_dbt_from_k8s_pod.sh "normalization" "airbyte" "main"
    rm -r config/
    RET=$?
    if [[ "$RET" -ne 0 ]]; then
        echo "Failed to grab normalization dbt from $ENVIRONMENT Airbyte"
    else
        echo "Airbyte normalization exported to local directory -> airbyte_dbt_export/"
    fi
    # Clear current context, just in case you don't really want to be there
    kubectl config unset current-context
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
    TARGET_PATH="$ROOT_PATH/dbt-cta/$DIR_NAME"
    gum confirm "Confirm the Target Path is correct: $TARGET_PATH" || exit 1
    # Check to see if Directory exists, if not create it
    if [[ ! -d $TARGET_PATH ]]; then
        mkdir -p $TARGET_PATH
    fi

    # Get path to exported Airbyte Workspace
    while [ -z "$DIR" ]; do
        DIR=$(gum input --prompt "Enter the path of the exported Airbyte files: " --placeholder "airbyte_dbt_export/")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
        WORKSPACE_PATH="$ROOT_PATH/$DIR"
    done
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
        OUTPUT_DIR_NAME=$(gum input --prompt "Enter the directory name where matviews should be placed: " --placeholder "(ex. dbt-cta/actblue/models/2_partner_matviews/)")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    gum confirm "Confirm the path where matviews will be written to is correct: $ROOT_PATH/$OUTPUT_DIR_NAME" || exit 1

    pipenv run python $ROOT_PATH/utils/dbt_format_utils.py createMatViews --basePath $ROOT_PATH/$INPUT_DIR_NAME --outputPath $ROOT_PATH/$OUTPUT_DIR_NAME
}

generate_dbt_tests() {
    # This prompts the user for the vendor name and options needed to run generate_schema_yml.py
    # Get target path for vendor directory
    while [ -z "$INPUT_DIR_NAME" ]; do
        INPUT_DIR_NAME=$(gum input --prompt "Enter the name of the vendor to generate tests for: " --placeholder "(ex. actblue)")
        OPTION_UNIVERSAL_TESTS=$(gum input --prompt "Would you like to initialize these files using the default tests (see universal_tests.yml)? " --placeholder " (Y is recommended! Or leave blank to skip)")
        if [ "$OPTION_UNIVERSAL_TESTS" == "Y" ]; then
            CLI_OPTIONS="--universal-tests-path $ROOT_PATH/utils/universal_tests.yml"
        fi

        OPTION_MERGE=$(gum input --prompt "Are you merging into an existing schema yaml? " --placeholder " (Y or leave blank to skip)")

        # Only ask about overwriting if user does not say they are merging. Just nicer that way
        if [ "$OPTION_MERGE" != "Y" ]; then
            OPTION_OVERWRITE=$(gum input --prompt "Are you overwriting an existing schema yaml? " --placeholder " (Y or leave blank to skip)")
        fi

        # Construct the python command based on options indicated by user
        if [ "$OPTION_MERGE" = "Y" ]; then
            CLI_OPTIONS="${CLI_OPTIONS} --merge"
        elif [ "$OPTION_OVERWRITE" = "Y" ]; then
            CLI_OPTIONS="${CLI_OPTIONS} --overwrite"
        fi
        COMMAND="python $ROOT_PATH/utils/generate_schema_yml.py --sync-name $INPUT_DIR_NAME $CLI_OPTIONS"
        echo $COMMAND
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    gum confirm "Confirm the vendor name is correct: $INPUT_DIR_NAME" || exit 1
    gum confirm "Confirm the selected runtime option is correct: $CLI_OPTIONS" || exit 1

    # Create venv from Pipfile and activate
    cd $ROOT_PATH
    pipenv install

    # Switch to dbt-cta dir and run script
    cd $ROOT_PATH/dbt-cta/
    pipenv run $COMMAND
}

lint_dbt() {
    # Switch to root level directory
    cd $ROOT_PATH
    # Get target path for directory holding Base models
    while [ -z "$VENDOR_NAME" ]; do
        VENDOR_NAME=$(gum input --prompt "Enter the vendor name of the models to lint: " --placeholder "(ex. actblue)")
        if [[ $? != 0 ]]; then
            echo "Ctrl-C caught, exiting..."
            exit 1
        fi
    done
    gum confirm "Confirm the vendor name is correct: $VENDOR_NAME" || exit 1
    export SYNC_NAME=$VENDOR_NAME

    RUN_FIX="Run linter and auto-fix findings (note: not all findings can be auto-fixed)"
    RUN_LINT="Just run linter without any auto-fix"
    LINT_FUNCTION=$(gum choose "$RUN_LINT" "$RUN_FIX")
    if [[ -n $LINT_FUNCTION ]]; then
        case "$LINT_FUNCTION" in
            "$RUN_FIX")
                pipenv run sqlfluff fix dbt-cta/$VENDOR_NAME/models/
            ;;
            "$RUN_LINT")
                pipenv run sqlfluff lint dbt-cta/$VENDOR_NAME/models/
            ;;
        esac
    fi
}

init() {
    cd $ROOT_PATH
    pip install pipenv
    pipenv install
    pipenv run pre-commit install
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
LINT_DBT="Run SQL Fluff to lint dbt files"


FUNCTION=$(gum choose "$INIT" "$GENERATE_DBT_TESTS" "$LINT_DBT" "$COPY_FROM_AIRBYTE" "$FORMAT_AIRBYTE_DBT"  "$APPEND_BASE_TO_FILES" "$GENERATE_MATVIEWS")

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
        "$LINT_DBT")
            command="lint_dbt"
            ;;
    esac
    # Confirm choice
    gum confirm "Confirm selection: ${FUNCTION}?" && $command "$@"
fi

