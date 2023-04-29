"""
generate_dbt_from_raw_tables.py

Takes a BigQuery dataset containing raw tables and generates "cta base" models from them.
This script assumes the following:

- the raw tables are already normalized and exist in a BQ dataset
(TODO: write a script that parses an unflattened JSON, such as _airbyte_data)
(TODO: chain that together with this one using a shell script and gum (a la cta_dbt_helper.sh)
(TODO: maybe add these scripts as functionality in cta_dbt_helper?)
- all tables in the BQ dataset should have a model created
- base tables should be created in the same dataset as the raw tables
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

    pipenv run python generate_dbt_from_raw_tables.py -p PROJECT_ID -d flambe
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
                        help='Google project id.'
                        )
    parser.add_argument('--dataset_id',
                        '-d',
                        help='Dataset id.'
                        )
    # Optional arguments
    parser.add_argument('--unique_key',
                        '-uk',
                        help='Unique key for tables in this dataset'
                             ' (default: _cta_sync_rowid',
                        default='_cta_sync_rowid'
                        )
    parser.add_argument('--datetime_field',
                        '-dt',
                        help='Datetime field for partitioning'
                             ' (default: _cta_sync_datetime_utc',
                        default='_cta_sync_datetime_utc'
                        )
    parser.add_argument('--output_path',
                        '-o',
                        help='Path to the output ZIP (default: dbt_models.zip',
                        default='dbt_models.zip'
                        )
    args = parser.parse_args()

    # Parse the arguments
    project_id = args.project_id
    dataset_id = args.dataset_id
    output_path = args.output_path
    unique_key = args.unique_key
    datetime_field = args.datetime_field

    # Set up the BigQuery client and list all tables in the dataset
    client = bigquery.Client(project=project_id)
    tables = list(client.list_tables(dataset_id))

    # Include only tables with "raw" in the name
    tables = [table for table in tables if 'raw' in table.table_id]

    with tempfile.TemporaryDirectory() as temp_dir_TODO:

        #######################
        # MAKE SOME DIRECTORIES
        #######################

        # Define the file path directories
        temp_dir = "temp_dir"
        sync_dir = "flambe"  # dataset_id
        models_dir = "models"
        models_subdir = "1_cta_full_refresh"
        matviews_subdir = "2_partner_matviews"

        # Join the path segments
        models_path = os.path.join(temp_dir,
                                   sync_dir,
                                   models_dir
                                   )
        models_subdir_path = os.path.join(models_path,
                                          models_subdir
                                          )
        matviews_subdir_path = os.path.join(models_path,
                                            matviews_subdir
                                            )

        # Create the new directories
        os.makedirs(models_subdir_path, exist_ok=True)
        os.makedirs(matviews_subdir_path, exist_ok=True)

        ####################
        # CREATE SOURCES.YML
        ####################

        # Create the sources.yml file
        source_tables_list = [{"name": table.table_id} for table in tables]\
                             + [{"name": table.table_id.replace('raw','base')} for table in tables]

        sources_dict = {
            "version": 2,
            "sources": [
                {
                    "name": "cta",
                    "database": "{{ env_var('CTA_PROJECT_ID') }}",
                    "schema": "{{ env_var('CTA_DATASET_ID') }}",
                    "tables": source_tables_list
                }
            ]
        }

        # Write the sources.yml file
        sources_yml_file_name = os.path.join(models_path, "sources.yml")
        with open(sources_yml_file_name, "w") as sources_yml_file:
            yaml.dump(sources_dict,
                      sources_yml_file,
                      sort_keys=False,
                      default_flow_style=False,
                      default_style=''
                      )

        # Iterate over the tables and generate a SQL file for each
        for table in tables:
            # Get the schema for the table
            table_ref = f"{dataset_id}.{table.table_id}"
            table_schema = client.get_table(table_ref).schema

            # Replace FLOAT with FLOAT64 field type
            fields_revised = []
            for field in table_schema:
                if field.field_type == 'FLOAT':
                    new_field = bigquery.SchemaField(field.name, 'FLOAT64')
                else:
                    new_field = field
                fields_revised.append(new_field)


            ##############################
            # CREATE THE _BASE MODEL
            ##############################

            # Define the SQL query
            table_schema_fields = ",\n    ".join(
                f"CAST(`{field.name}` AS {field.field_type}) AS `{field.name}`"
                for field in fields_revised
            )

            concat_fields = ",\n                                        " \
                .join(f"`{field.name}`" for field in table_schema)

            sql = f"""SELECT
    {table_schema_fields},
    FORMAT("%x", FARM_FINGERPRINT(CONCAT({concat_fields}))) AS _unique_row_id
FROM {{{{ source('cta', '{table.table_id}') }}}}

{{% if is_incremental() %}}
where timestamp_trunc({datetime_field}, day) in ({{{{ partitions_to_replace | join(",") }}}})
{{% endif %}}
            """

            # Write the SQL query to the _base model file
            model_name = table.table_id.replace('raw', 'base') \
                if 'raw' in table.table_id else table.table_id + "_base"
            file_path = os.path.join(models_subdir_path, f"{model_name}.sql")
            with open(file_path, "w") as f:
                dbt_config = f"""{{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}}

{{{{config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={{"field": "{datetime_field}", "data_type": "timestamp", "granularity": "day"}},
    partitions=partitions_to_replace,
    unique_key="{unique_key}"
)}}}}

-- Final base SQL model
"""
                f.write(dbt_config)
                f.write(sql)

            ##############################
            # CREATE THE PARTNER MATVIEW
            ##############################

            matview_fields = ",\n    ".join(
                f"{field.name}"
                for field in fields_revised
            )

            source_table_name = table.table_id.replace('raw', 'base')

            matview_sql = f"""SELECT
    {matview_fields},
    _unique_row_id
FROM {{{{ source('cta', '{source_table_name}') }}}}
                        """

            # Name the matview model file
            matview_name = table.table_id.replace('_raw', '') \
                if 'raw' in table.table_id else table.table_id + "_final"
            matview_file_path = os.path.join(matviews_subdir_path, f"{matview_name}.sql")

            # Write the matview SQL to the file
            with open(matview_file_path, "w") as matview_file:
                matview_file.write(matview_sql)

    # Write the contents of temp_dir to a ZIP file
    with zipfile.ZipFile(output_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(temp_dir):
            for file in files:
                # Get the full path of the file
                file_path = os.path.join(root, file)
                # Add the file to the ZIP file using a relative path
                zipf.write(file_path, os.path.relpath(file_path, temp_dir))

    print(f"ZIP file '{output_path}' created.")


if __name__ == '__main__':
    main()
