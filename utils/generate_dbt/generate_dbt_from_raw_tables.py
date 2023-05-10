"""
generate_dbt_from_raw_tables.py

Takes a BigQuery dataset containing raw tables and generates "cta base" models from them.
This script assumes the following:

- the raw tables are already normalized and exist in a BQ dataset
- all tables in the BQ dataset should have a model created
- base tables should be created in the same dataset as the raw tables

Parameters:
    project_id (str): the name of the google project ID containing the dataset with "raw" tables
    dataset_id (str): the name of the dataset containing "raw" tables
    output_path (str): path to the output ZIP (default: dbt_models.zip)
    spec_json_path (str): path to a json file specifying configurations for each table (see `sample_table_spec.json`)

Returns:
    None.
    The script will produce a compressed ZIP file in the directory where it was run.

Example Usage:

    pipenv run python generate_dbt_from_raw_tables.py \
    -p PROJECT_ID \
    -d DATASET_ID \
    -s sample_table_spec.json \
    -o mycoolmodels.zip
"""

import argparse
import json
import os
import tempfile
import yaml
import zipfile
from google.cloud import bigquery

from dbt_file_contents import get_base_sql,\
    get_base_config,\
    get_matview_sql

def get_spec_dict_from_file(spec_json_path):
    # open the JSON file in read mode
    with open(spec_json_path, "r") as f:
        # load the contents of the file into a string
        spec_json_str = f.read()
        # parse the JSON string into a list of dictionaries
        spec_json_dict = json.loads(spec_json_str)

    return spec_json_dict


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
    parser.add_argument('--output_path',
                        '-o',
                        help='Path to the output ZIP (default: dbt_models.zip)',
                        default='dbt_models.zip'
                        )
    parser.add_argument('--spec_json_path',
                        '-s',
                        help='Path to the JSON containing sync modes,'
                             ' unique keys, and cursor fields for each table',
                        default='sample_table_spec.json'
                        )

    args = parser.parse_args()

    # Parse the arguments
    project_id = args.project_id
    dataset_id = args.dataset_id
    output_path = args.output_path
    spec_json_path = args.spec_json_path
    spec_json_dict = get_spec_dict_from_file(spec_json_path)

    # Set up the BigQuery client and list all tables in the dataset
    client = bigquery.Client(project=project_id)
    tables = list(client.list_tables(dataset_id))

    # Include only tables with "raw" in the name
    tables = [table for table in tables if 'raw' in table.table_id]

    # Include only tables that are present in the table spec
    tables = [table for table in tables if table.table_id.replace('_raw','') in spec_json_dict.keys()]

    with tempfile.TemporaryDirectory() as temp_dir_TODO:

        #######################
        # MAKE SOME DIRECTORIES
        #######################

        # Define the file path directories
        temp_dir = "temp_dir"
        sync_dir = dataset_id
        models_dir = "models"
        matviews_subdir = "2_partner_matviews"

        # Create the `models` subdirectory
        models_path = os.path.join(temp_dir,
                                   sync_dir,
                                   models_dir
                                   )
        os.makedirs(models_path, exist_ok=True)

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
        # 'tables' has all the table names ending in _raw
        for table in tables:

            table_id_raw = table.table_id
            table_id_base = table_id_raw.replace('raw', 'base')
            table_id = table_id_raw.replace('_raw', '')

            # Load configs from the spec dict
            unique_key = spec_json_dict[table_id].get('unique_key', '_cta_row_id')
            partition_datetime_field = spec_json_dict[table_id].get('partition_datetime_field', '_cta_sync_datetime_utc')
            sync_mode = spec_json_dict[table_id].get('sync_mode', 'full_refresh')

            # Get the schema for the _raw table
            raw_table_ref = f"{dataset_id}.{table_id_raw}"
            table_schema = client.get_table(raw_table_ref).schema

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

            # Create the subdirectory if it doesn't already exist
            models_subdir = f"1_cta_{sync_mode}"
            models_subdir_path = os.path.join(models_path,
                                              models_subdir
                                              )
            os.makedirs(models_subdir_path, exist_ok=True)

            # Define the SQL query
            table_schema_fields = ",\n    ".join(
                f"CAST(`{field.name}` AS {field.field_type}) AS `{field.name}`"
                for field in fields_revised
            )

            concat_fields = ",\n                                        " \
                .join(f"`{field.name}`" for field in table_schema)

            dbt_config = get_base_config(
                partition_datetime_field=partition_datetime_field,
                unique_key=unique_key,
                sync_mode=sync_mode
            )

            sql = get_base_sql(
                    table_schema_fields=table_schema_fields,
                    concat_fields=concat_fields,
                    table_id=table_id_raw,
                    partition_datetime_field=partition_datetime_field,
                    sync_mode=sync_mode
            )

            # Write the dbt config and SQL query to the _base model file
            file_path = os.path.join(models_subdir_path, f"{table_id_base}.sql")

            with open(file_path, "w") as f:
                f.write(dbt_config)
                f.write(sql)

            ##############################
            # CREATE THE PARTNER MATVIEW
            ##############################

            # Create the subdirectory if it doesn't already exist
            matviews_subdir = "2_partner_matviews"
            matviews_subdir_path = os.path.join(models_path,
                                              matviews_subdir
                                              )
            os.makedirs(matviews_subdir_path, exist_ok=True)

            matview_fields = ",\n    ".join(
                f"{field.name}"
                for field in fields_revised
            )

            matview_sql = get_matview_sql(
                matview_fields=matview_fields,
                unique_key=unique_key,
                table_id_base=table_id_base
                )

            # Name the matview model file
            # `table_id` = name of the table without _raw or _base
            matview_file_path = os.path.join(matviews_subdir_path, f"{table_id}.sql")

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
