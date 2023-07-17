import argparse
import os
import create_dbt_files as create_dbt
import helper_functions as helper

"""
Sample usage (with command line arguments)

    pipenv run python airbyte_raw_to_dbt.py \
    -p dev3869c056 \
    -d raza_actblue \
    -s actblue \
    -f configs/actblue.json
"""


def main():
    ###########
    ## Setup ##
    ###########

    # Parse them args
    parser = argparse.ArgumentParser(description="Generate dbt files.")
    parser.add_argument(
        "--project_id", "-p", help="Google project id.", default="dev3869c056"
    )
    parser.add_argument("--dataset_id", "-d", help="Dataset id.", default="flambe")
    parser.add_argument(
        "--sync_name", "-s", help="Name of the sync (e.g., blocks)", default="science"
    )
    parser.add_argument(
        "--spec_json_path",
        "-f",
        help="Path to the JSON containing sync modes,"
        " unique keys, and cursor fields for each table",
        default="configs/actblue.json",
    )
    args = parser.parse_args()
    project_id = args.project_id
    dataset_id = args.dataset_id
    sync_name = args.sync_name
    spec_json_path = args.spec_json_path
    spec_json_dict = helper.get_spec_dict_from_file(spec_json_path)

    # Other constants
    models_dir = f"../../../dbt-cta/{sync_name}/models"
    model_types = [
        "0_ctes",
        "1_cta_full_refresh",
        "1_cta_incremental",
        "2_partner_matviews",
    ]

    # Create some folders for the dbt files to be written to
    for model_type in model_types:
        new_path = os.path.join(sync_name, models_dir, model_type)
        os.makedirs(new_path, exist_ok=True)

    # Get list of table_ids from the spec json
    table_ids = [
        key
        for key, value in spec_json_dict.items()
        if value["sync_mode"] == "incremental"
    ]
    print(f"creating files for these tables:")
    print(table_ids)

    ########################
    ## Create sources.yml ##
    ########################

    print(f"writing sources.yaml to {models_dir}")
    create_dbt.create_sources_yaml(tables_list=table_ids, models_dir=models_dir)

    #######################
    ## Create dbt models ##
    #######################

    for table_id in table_ids:
        sync_mode = spec_json_dict[table_id]["sync_mode"]
        unique_key = spec_json_dict[table_id]["unique_key"]
        print("")
        print("----------------------------------------")
        print(f"table_id: {table_id}")
        print(f"sync_mode: {sync_mode}")
        print(f"unique key: {unique_key}")
        print("----------------------------------------")

        # Get field names and data types for the table
        data_fields_and_types = helper.get_field_names_and_datatypes(
            project_id=project_id, dataset_id=dataset_id, table_id=table_id
        )
        # Or use this to test:
        # data_fields_and_types = {'sluggable_type': 'string', 'sluggable_id': 'bigint', 'scope': 'string', 'created_at': 'timestamp', 'id': 'bigint', 'slug': 'string'}

        # Write all the dbt models
        create_dbt.write_dbt_models_for_table(
            table_id=table_id,
            data_fields_and_types=data_fields_and_types,
            models_dir=models_dir,
            sync_mode=sync_mode,
            unique_key=unique_key,
        )


if __name__ == "__main__":
    main()
