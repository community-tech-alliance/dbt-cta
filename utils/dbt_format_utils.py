import argparse
import os
import re
import tempfile
from glob import glob
from shutil import move

import requests


# Entrypoint, parses input args and call corresponding functions
def parse_args():
    parser = argparse.ArgumentParser()

    args = parser.parse_args()


def main():
    parser = argparse.ArgumentParser()
    sub_parsers = parser.add_subparsers(
        title="action", description="Choose which action to run", dest="action"
    )

    # Rename Base Tables input parser
    rename_parser = sub_parsers.add_parser("renameBaseTables")
    rename_parser.add_argument("--basePath", type=str, required=True)

    # Create Matview from Base Tables input parser
    create_matview_parser = sub_parsers.add_parser("createMatViews")
    create_matview_parser.add_argument("--basePath", type=str, required=True)
    create_matview_parser.add_argument("--outputPath", type=str, required=True)

    # Download Cacher Script input parser
    get_cacher_parser = sub_parsers.add_parser("getCacherScript")
    get_cacher_parser.add_argument("--cacherSnippetGUID", type=str, required=True)
    get_cacher_parser.add_argument("--cacherApiKey", type=str, required=True)
    get_cacher_parser.add_argument("--cacherApiToken", type=str, required=True)
    get_cacher_parser.add_argument("--outputPath", type=str, required=True)

    # Restructure Airbyte input parser
    restruct_parser = sub_parsers.add_parser("restructAirbyteDbt")
    restruct_parser.add_argument("--airbyteWorkspacePath", type=str, required=True)
    restruct_parser.add_argument("--dbtCtaPath", type=str, required=True)

    args = parser.parse_args()

    if args.action == "renameBaseTables":
        # Check Args for Action
        if not args.basePath:
            raise Exception("Make sure you specify the --basePath argument")
        # Run selected action
        add_base_to_filenames(args.basePath)

    elif args.action == "createMatViews":
        # Check Args for Action
        if not args.basePath:
            raise Exception("Make sure you specify the --basePath argument")
        if not args.outputPath:
            raise Exception("Make sure you specify the --outputPath argument")
        # Run selected action
        create_matview_dbt_files_from_base(args.basePath, args.outputPath)

    elif args.action == "getCacherScript":
        # Check Args for Action
        if not args.cacherSnippetGUID:
            raise Exception("Make sure you specify the --cacherSnippetGUID argument")
        if not args.cacherApiKey:
            raise Exception("Make sure you specify the --cacherApiKey argument")
        if not args.cacherApiToken:
            raise Exception("Make sure you specify the --cacherApiToken argument")
        if not args.outputPath:
            raise Exception("Make sure you specify the --outputPath argument")
        # Run selected action
        download_cacher_script(
            args.cacherSnippetGUID,
            args.cacherApiKey,
            args.cacherApiToken,
            args.outputPath,
        )

    elif args.action == "restructAirbyteDbt":
        # Check Args for Action
        if not args.airbyteWorkspacePath:
            raise Exception("Make sure you specify the --airbyteWorkspacePath argument")
        if not args.dbtCtaPath:
            raise Exception("Make sure you specify the --dbtCtaPath argument")
        # Run selected action
        restructure_airbyte_dbt(args.airbyteWorkspacePath, args.dbtCtaPath)
    else:
        raise Exception(
            "Please enter a supported action -> renameBaseTables, createMatViews, getCacherScript, restructAirbyteDbt"
        )


# Function to grab Airbyte Generated dbt and move into CTA structured folder (✨Progify it✨)
def restructure_airbyte_dbt(airbyte_workspace_path, dbt_cta_path):
    # Mapping of Airbyte folders -> CTA folders
    airbyte_cta_dir_mapping = {
        "airbyte_ctes": "0_ctes",
        "airbyte_tables": "1_cta_full_refresh",
        "airbyte_incremental": "1_cta_incremental",
    }

    # Go through and move all files from Airbyte export into 'dbt-cta' directories
    for airbyte_dir, cta_dir in airbyte_cta_dir_mapping.items():
        # Get all sql files that should be moved for current mapping
        files_to_move = glob(
            f"{airbyte_workspace_path}/**/{airbyte_dir}/**/*.sql", recursive=True
        )

        if files_to_move:  # Only run if there were any files found
            # Make sure target path is created
            dbt_cta_path = (
                dbt_cta_path if dbt_cta_path[-1] != "/" else dbt_cta_path[:-1]
            )
            target_path = f"{dbt_cta_path}/models/{cta_dir}"
            os.makedirs(target_path, exist_ok=True)

            # Move files to target path
            for file_path in files_to_move:
                file_name = os.path.basename(file_path)
                moved_file = move(src=file_path, dst=f"{target_path}/{file_name}")
                print(f"Moved {file_path} -> {moved_file}")

    # Now lets move over the sources.yml file
    sources_file = glob(
        f"{airbyte_workspace_path}/**/models/**/sources.yml", recursive=True
    )
    if sources_file:
        move_source_file = move(
            src=sources_file[0], dst=f"{dbt_cta_path}/models/sources.yml"
        )
        print(f"Moved {sources_file[0]} -> {dbt_cta_path}/models/sources.yml")
    else:
        print(f"Couldnt find the sources file in {airbyte_workspace_path}")

    # Cool, files are moved so now lets modify the file content
    modify_dbt_models(f"{dbt_cta_path}/models/0_ctes", "cte")
    modify_full_refresh_models(f"{dbt_cta_path}/models/1_cta_full_refresh")
    modify_dbt_models(f"{dbt_cta_path}/models/1_cta_incremental", "incremental")


# Function to modify ctes and incremental models. For these its just gonna be
# swapping out the config section, and changing source to cta.
def modify_dbt_models(path_to_models, model_type):
    # Default Config Section thats gonna be used to replace Airbyte generated config
    config = (
        "{{ config(\n"
        '    cluster_by = "_airbyte_emitted_at",\n'
        '    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},\n'
        '    unique_key = "_airbyte_ab_id"\n'
        ") }}\n"
    )
    stop_skip_pattern = "-- SQL model" if model_type == "cte" else "-- Final base SQL"

    # Get all dbt Models
    cte_model_files = glob(f"{path_to_models}/*.sql", recursive=True)

    # Iterate through models and read each one line by line
    # Then selectively write line to temp file.
    # Finally, replace file content with temp file content
    for model_file_path in cte_model_files:
        skip_line = True
        with tempfile.TemporaryFile(mode="r+") as temp_file:
            temp_file.write(config)
            with open(model_file_path, "r") as model_file:
                for line in model_file:
                    # Dont start writing to file if were still in config section
                    if stop_skip_pattern in line:
                        skip_line = False
                    if skip_line:
                        continue
                    # Substitute source with 'cta' if regex match
                    line = re.sub("(?<=source\(').*?(?=', '_airbyte_raw_)", "cta", line)
                    temp_file.write(line)
            temp_file.seek(0)
            with open(f"{model_file_path}", "w") as output_file:
                output_file.write(temp_file.read())


# Function to modify sql files for full-refresh models
# this will add the logic for partition replacement strat
def modify_full_refresh_models(path_to_models):
    # Default Config Section thats gonna be used to replace Airbyte generated config.
    # This also contains the partition replacement header.
    partition_replacement_header = (
        "{% set partitions_to_replace = [\n"
        '    "timestamp_trunc(current_timestamp, day)",\n'
        '    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"\n'
        "] %}\n"
        "{{ config(\n"
        '    cluster_by = "_airbyte_emitted_at",\n'
        '    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},\n'
        "    partitions = partitions_to_replace,\n"
        '    unique_key = "_airbyte_ab_id"\n'
        ") }}\n"
    )

    partition_replacement_footer = (
        "{% if is_incremental() %}\n"
        'where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})\n'
        "{% endif %}"
    )

    # Get all full-refresh Models
    cte_model_files = glob(f"{path_to_models}/*.sql", recursive=True)

    # Iterate through models and read each one line by line
    # Then selectively write line to temp file.
    # Finally, replace file content with temp file content
    for model_file_path in cte_model_files:
        skip_line = True
        with tempfile.TemporaryFile(mode="r+") as temp_file:
            temp_file.write(partition_replacement_header)
            with open(model_file_path, "r") as model_file:
                for line in model_file:
                    # Dont start writing to file if were still in config section
                    if "-- Final base SQL" in line:
                        skip_line = False
                    # For these models, get rid of default where statement
                    if "where 1 = 1" in line:
                        skip_line = True
                    if skip_line:
                        continue
                    # Substitute source with 'cta' if regex match
                    line = re.sub("(?<=source\(').*?(?=', '_airbyte_raw_)", "cta", line)
                    temp_file.write(line)
            temp_file.write(partition_replacement_footer)
            temp_file.seek(0)
            with open(f"{model_file_path}", "w") as output_file:
                output_file.write(temp_file.read())


# Function to grab the content of a specified cacher sript
def download_cacher_script(script_guid, api_key, api_token, output_path):
    # Make API request to get all cacher snippets for a user
    cacher_url = "https://api.cacher.io/integrations/show_all"
    headers = {
        "cache-control": "no-cache",
        "x-api-key": api_key,
        "x-api-token": api_token,
    }
    resp = requests.get(cacher_url, headers=headers)
    resp.raise_for_status()

    # Grab all CTA Snippets from user's teams
    user_teams = resp.json()["teams"]
    cta_team = next(team for team in user_teams if team.get("name") == "CTA")
    cta_snippets = cta_team["library"]["snippets"]

    # Find target snippet
    target_script = next(
        snippet for snippet in cta_snippets if snippet.get("guid") == script_guid
    )
    script_content = target_script.get("files")[0]["content"]

    with open(output_path, "w") as output_file:
        output_file.write(script_content)

    print(
        f"Cacher Snippet {target_script.get('title', script_guid)} downloaded to {output_path}"
    )


# Function to append "_base" to all files in a directory
def add_base_to_filenames(base_tables_path):
    base_tables = [
        f
        for f in os.listdir(base_tables_path)
        if os.path.isfile(os.path.join(base_tables_path, f))
    ]
    base_tables.sort()
    for table_file in base_tables:
        table_name = table_file.split(".")[0]
        # Skip if not sql file
        if ".sql" not in table_file:
            print(f"{table_file} not a SQL file. Skipping.")
            continue
        # Skip if _base already in filename
        if "_base.sql" in table_file:
            print(f"- name: {table_name}")
            continue

        os.rename(
            f"{base_tables_path}{table_file}",
            f"{base_tables_path}{table_name}_base.sql",
        )
        print(f"- name: {table_name}_base")


def create_matview_dbt_files_from_base(base_tables_path, output_path):
    # Make sure path structure is consistent
    base_tables_path = (
        base_tables_path if base_tables_path[-1] != "/" else base_tables_path[:-1]
    )
    output_path = output_path if output_path[-1] != "/" else output_path[:-1]
    # Check if output exists
    isExist = os.path.exists(output_path)
    if not isExist:
        # Create a new directory because it does not exist
        os.mkdir(output_path)
        print(f"{output_path} is created!")

    base_tables = [
        f
        for f in os.listdir(base_tables_path)
        if os.path.isfile(os.path.join(base_tables_path, f))
    ]
    for table in base_tables:
        with open(f"{base_tables_path}/{table}", "r") as infile:
            with open(f"{output_path}/{table.replace('_base','')}", "w") as outfile:
                write_to_file = False
                table_name = table.split(".")[0]

                # Only write lines from base tables that include SQL Statement ( SELECT -> FROM )
                # Excludes _airbyte columns
                for line in infile:
                    if "select" in line:
                        write_to_file = True
                    if "from {{" in line and "--" not in line:
                        write_to_file = False
                        outfile.write(f"from {{{{ source('cta','{table_name}') }}}}")
                    if write_to_file:
                        if not "_airbyte" in line:
                            outfile.write(line)


if __name__ == "__main__":
    main()
