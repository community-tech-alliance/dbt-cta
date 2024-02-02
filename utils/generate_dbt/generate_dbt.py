import os
from google.cloud import bigquery
from jinja2 import Environment, FileSystemLoader


def create_directory_structure(base_dir, sync_name, base_models_template_list):
    """
    Creates a directory structure for a specific sync process.

    Args:
    base_dir (str): The base directory where the sync directories will be created.
    sync_name (str): The name of the sync process (e.g. 'facebook_pages'). This will be a subdirectory under base_dir.
    base_models_template_list (list): A list of names of templates that will be used to generate SQL files for `_base` models (from user input).
    """

    os.makedirs(os.path.join(base_dir, sync_name), exist_ok=True)

    if "1_cta_full_refresh" in base_models_template_list:
        os.makedirs(
            os.path.join(base_dir, sync_name, "models/1_cta_full_refresh"),
            exist_ok=True,
        )
    if "1_cta_incremental" in base_models_template_list:
        os.makedirs(
            os.path.join(base_dir, sync_name, "models/1_cta_incremental"), exist_ok=True
        )

    os.makedirs(os.path.join(base_dir, sync_name, "models/0_ctes"), exist_ok=True)
    os.makedirs(
        os.path.join(base_dir, sync_name, "models/2_cta_delivery"), exist_ok=True
    )
    os.makedirs(
        os.path.join(base_dir, sync_name, "models/2_partner_matviews"), exist_ok=True
    )

    print(f"Created directory structure for sync: {sync_name}")


def extract_column_names(client, project_id, dataset_id, table_id):
    """
    Extracts column names and their data types from a specified BigQuery table.

    Args:
    client (bigquery.Client): The BigQuery client through which queries will be made.
    project_id (str): The project ID in Google Cloud.
    dataset_id (str): The dataset ID within the BigQuery project.
    table_id (str): The ID of the table from which to extract column names and types.

    Returns:
    List[Tuple[str, str]]: A list of tuples containing column names and their data types.
    """

    query = f"SELECT column_name, data_type FROM {project_id}.{dataset_id}.INFORMATION_SCHEMA.COLUMNS WHERE table_name = '{table_id}'"
    query_job = client.query(query)
    columns = [(row["column_name"], row["data_type"]) for row in query_job]
    return columns


def generate_sql_files(
    client,
    base_dir,
    sync_name,
    project_id,
    dataset_id,
    template_name,
    file_suffix,
    destination_folder,
):
    """
    Generates SQL files for each table in a dataset based on a Jinja2 template.

    Args:
    client (bigquery.Client): The BigQuery client used to list tables.
    base_dir (str): The base directory where SQL files will be created.
    sync_name (str): The name of the sync process.
    project_id (str): The project ID in Google Cloud.
    dataset_id (str): The dataset ID within the BigQuery project.
    template_name (str): The name of the Jinja2 template to be used.
    file_suffix (str): The suffix to be added to generated SQL files. This is '_ab1' for CTEs, '_base' for base models, and blank for partner materialized views.
    destination_folder (str): The folder where SQL files will be placed.
    """

    template_file = f"templates/{template_name}.sql"
    dataset_ref = client.dataset(dataset_id, project=project_id)
    tables = client.list_tables(dataset_ref)

    for table in tables:
        table_id = table.table_id

        # Skip tables that end with "_base" or start with "_"
        if table_id.endswith("_base") or table_id.startswith("_"):
            continue

        # Generate the appropriate table file name based on the file_suffix
        table_file_name = f"{table_id}{file_suffix}.sql"

        # Determine the appropriate subdirectory based on the destination_folder
        subdirectory = f"models/{destination_folder}"

        columns = extract_column_names(client, project_id, dataset_id, table_id)

        # Create a list of all columns (no quotes, single indent after the first)
        all_columns = [field[0] for field in columns]
        all_columns_str = ",\n  ".join(all_columns)

        # Create a list of columns with data types string, int, float, bool, date, or timestamp
        # TODO: figure out how to represent JSON/STRUCT/ARRAY types in here. We could get edge cases where multiple rows might appear duplicative but have different data in a nested field, which currently would be ignored by this script.
        columns_for_hashid = [
            f"'{field[0]}'"
            for field in columns
            if field[1] in ["STRING", "INT64", "FLOAT64", "BOOL", "DATE", "TIMESTAMP"]
            and not field[0].startswith("_airbyte")
        ]

        # Indent twice for every element after the first without leading line break
        columns_for_hashid_str = ",\n  ".join(columns_for_hashid)

        # Create a context dictionary with the variables you want to pass to the template
        context = {
            "all_columns": all_columns_str,
            "columns_for_hashid": columns_for_hashid_str,
            "project": project_id,
            "dataset": dataset_id,
            "table": table_id,
        }

        # Render the Jinja template with the context
        env = Environment(loader=FileSystemLoader(os.path.dirname(template_file)))
        template = env.get_template(os.path.basename(template_file))
        rendered_sql = template.render(**context)

        # Write the rendered SQL content to files in the specified subdirectory
        file_path = os.path.join(base_dir, sync_name, subdirectory, table_file_name)
        with open(file_path, "w") as sql_file:
            sql_file.write(rendered_sql)

        print(f"Generated {table_id}{file_suffix} model in {subdirectory}")


def generate_sources_yaml(client, base_dir, sync_name, project_id, dataset_id):
    """
    Generates a 'sources.yml' file for the dbt project containing both the tables created by Airbyte's BQ V2 destination and the _base tables created by other dbt models generated using this script.

    Args:
    client (bigquery.Client): The BigQuery client used to list tables.
    base_dir (str): The base directory where 'sources.yml' will be created.
    sync_name (str): The name of the sync process.
    project_id (str): The project ID in Google Cloud.
    dataset_id (str): The dataset ID within the BigQuery project.
    """

    # Fetch the list of tables from the BigQuery dataset
    dataset_ref = client.dataset(dataset_id, project=project_id)
    tables = client.list_tables(dataset_ref)
    table_list = [
        table.table_id
        for table in tables
        if not (table.table_id.endswith("_base") or table.table_id.startswith("_"))
    ]

    # Define the path to the Jinja template for sources.yml
    template_sources = "templates/sources.yml"

    # Load the Jinja template
    env = Environment(loader=FileSystemLoader(os.path.dirname(template_sources)))
    template = env.get_template(os.path.basename(template_sources))

    # Render the Jinja template with the table list
    rendered_sources_yaml = template.render(table_list=table_list)

    # Write the rendered sources.yml to a file in the models folder
    sources_yaml_path = os.path.join(base_dir, sync_name, "models", "sources.yml")
    with open(sources_yaml_path, "w") as sources_yaml_file:
        sources_yaml_file.write(rendered_sources_yaml)

    print("Generated sources.yml")


def main():
    """
    Main function to run the script.
    Collects user inputs and calls other functions to create directories and generate files to run dbt (SQL models and sources.yml).
    """

    sync_name = input("Enter sync name: ")
    project_id = input("Enter project ID: ")
    dataset_id = input("Enter dataset ID: ")
    base_models_option = (
        input(
            "Which base models do you need generated? (1=full_refresh, 2=incremental, 3 or skip to generate both): "
        )
        or "3"
    )

    base_dir = "../../dbt-cta"

    client = bigquery.Client()

    base_models_option_mapping = {
        "1": ["1_cta_full_refresh"],
        "2": ["1_cta_incremental"],
        "3": ["1_cta_full_refresh", "1_cta_incremental"],
    }

    base_models_template_list = base_models_option_mapping[base_models_option]

    # create the folders needed
    create_directory_structure(base_dir, sync_name, base_models_template_list)

    # generate base models (full refresh and/or incremental depending on user input)
    # Note that if your sync uses a combination of full refresh and incremental models, you will need to manually remove the models from each folder that are not needed
    for template_name in base_models_template_list:
        generate_sql_files(
            client,
            base_dir,
            sync_name,
            project_id,
            dataset_id,
            template_name=template_name,
            file_suffix="_base",
            destination_folder=template_name,
        )

    # Generate CTE models with "_ab1" suffix in the "0_ctes" folder
    generate_sql_files(
        client,
        base_dir,
        sync_name,
        project_id,
        dataset_id,
        template_name="0_ctes_ab1",
        file_suffix="_ab1",
        destination_folder="0_ctes",
    )

    # Generate additional CTE models with "_ab2" suffix in the same "0_ctes" folder
    # These models deduplicate on hashid
    generate_sql_files(
        client,
        base_dir,
        sync_name,
        project_id,
        dataset_id,
        template_name="0_ctes_ab2",
        file_suffix="_ab2",
        destination_folder="0_ctes",
    )

    # generate delivery models. These are the models that will be used to deliver data via Analytics Hub linked datasets.
    generate_sql_files(
        client,
        base_dir,
        sync_name,
        project_id,
        dataset_id,
        template_name="2_cta_delivery",
        file_suffix="",
        destination_folder="2_cta_delivery",
    )

    # generate partner matviews. In the future, we plan to deliver data using Analytics Hub linked datasets, but we should keep creating these models for now.
    generate_sql_files(
        client,
        base_dir,
        sync_name,
        project_id,
        dataset_id,
        template_name="2_cta_delivery",
        file_suffix="_mv",
        destination_folder="2_partner_matviews",
    )

    # generate sources.yml
    generate_sources_yaml(client, base_dir, sync_name, project_id, dataset_id)

    print("Congratulations! You have a bunch of new dbt files.")
    if base_models_option == "3":
        print(
            "Because you are using a combination of full_refresh and incremental models, you will need to manually remove the models from each folder that are not needed."
        )
    print(
        "Don't forget to add tests and run SQL fluff for maximum stylishness by running `sh ../cta_dbt_helper.sh` and following the instructions."
    )
    print("Have a blessed day!")


if __name__ == "__main__":
    main()
