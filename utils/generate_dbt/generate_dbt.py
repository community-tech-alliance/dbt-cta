"""
generate_dbt.py

Takes a BigQuery dataset containing raw tables and generates "cta base" models from them.
This script assumes the following:

- the raw tables are already normalized
(TODO: add a mode that parses an unflattened JSON, such as _airbyte_data)
- all tables in the BQ dataset should have a model created
- all tables update using full refresh overwrite
(that is, whatever process is delivering those tables is dropping and recreating them on each run)
(TODO: add a way to create incremental models - tbd how that would work...)

Parameters:
    project_id (str): the name of the google project ID containing the dataset for generating dbt models.
    dataset_id (str): the name of the dataset.
    TODO (not yet implemented):
    table_configs (dict): a dict containing dbt config info to pass into each model.
    If none is provided, assume full refresh for all models, using date partition replacement.
    (something like: {"table_id":"customers","refresh_mode":"incremental","unique_key":"customer_id"}

Returns:
    None.
    The script will produce a compressed ZIP file in the directory where it was run.

Example Usage:

    pipenv run python generate_dbt.py -p PROJECT_ID -d flambe
"""

import argparse
import os
import tempfile
import yaml
import zipfile
from google.cloud import bigquery


def main():
    # Parse them args
    parser = argparse.ArgumentParser(description='Generate dbt files.')
    parser.add_argument('--project_id',
                        '-p',
                        help='Google project id.')
    parser.add_argument('--dataset_id',
                        '-d',
                        help='Dataset id.')
    # Add an optional argument for the output file
    parser.add_argument('--output',
                        '-o',
                        help='Path to the output ZIP.',
                        default='dbt_models.zip')
    args = parser.parse_args()

    # Set up the BigQuery client and list all tables in the dataset
    client = bigquery.Client(project=args.project_id)
    dataset_id = args.dataset_id
    tables = list(client.list_tables(dataset_id))

    with tempfile.TemporaryDirectory() as temp_dir_TODO:
        # Create the sources.yml file
        sources_dict = {
            "version": 2,
            "sources": [
                {
                    "name": "cta",
                    "database": "{{ env_var('CTA_PROJECT_ID') }}",
                    "schema": "{{ env_var('CTA_DATASET_ID') }}",
                    "tables": [{"name": table.table_id} for table in tables]
                }
            ]
        }

        temp_dir = "temp_dir"
        models_dir = "models"
        models_subdir = "1_cta_full_refresh"

        # Join the path segments
        models_subdir_path = os.path.join(temp_dir, models_dir, models_subdir)

        # Create the new directories
        os.makedirs(models_subdir_path, exist_ok=True)

        # Write the sources.yml file
        sources_yml_path = os.path.join(temp_dir, models_dir, "sources.yml")
        with open(sources_yml_path, "w") as sources_yml_file:
            yaml.dump(sources_dict, sources_yml_file, sort_keys=False, default_flow_style=False, default_style='')

        # Iterate over the tables and generate a SQL file for each
        for table in tables:
            # Get the schema for the table
            table_ref = f"{dataset_id}.{table.table_id}"
            table_schema = client.get_table(table_ref).schema

            # Define the SQL query
            table_schema_fields = ",\n    ".join(
                f"CAST({field.name} AS {field.field_type}) AS {field.name}" for field in table_schema
            )

            concat_fields = ",\n                                        ".join(field.name for field in table_schema)

            sql = f"""SELECT
    {table_schema_fields},
    FORMAT("%x", FARM_FINGERPRINT(CONCAT({concat_fields}))) AS _unique_row_id
FROM {{{{ source('cta', '{table.table_id}') }}}}

{{% if is_incremental() %}}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{{{ partitions_to_replace | join(",") }}}})
{{% endif %}}
            """

            # Write the SQL query to a file
            model_name = table.table_id.replace('raw', 'base') if 'raw' in table.table_id else table.table_id+"_base"
            file_path = os.path.join(temp_dir, models_dir, models_subdir, f"{model_name}.sql")
            with open(file_path, "w") as f:
                dbt_config = """{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}

{{config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    unique_key="_unique_row_id"
)}}

-- Final base SQL model
"""
                f.write(dbt_config)
                f.write(sql)

    # Write the contents of temp_dir to a ZIP file

    with zipfile.ZipFile(args.output, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(temp_dir):
            for file in files:
                # Get the full path of the file
                file_path = os.path.join(root, file)
                # Add the file to the ZIP file using a relative path
                zipf.write(file_path, os.path.relpath(file_path, temp_dir))

    print(f"ZIP file '{args.output}' created.")


if __name__ == '__main__':
    main()
