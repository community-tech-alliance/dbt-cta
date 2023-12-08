import os
from google.cloud import bigquery
from jinja2 import Environment, FileSystemLoader

def create_directory_structure(base_dir, sync_name, base_models_template_list):
    os.makedirs(os.path.join(base_dir, sync_name), exist_ok=True)

    if "templates/1_cta_full_refresh.sql" in base_models_template_list:
        os.makedirs(os.path.join(base_dir, sync_name, "models/1_cta_full_refresh"), exist_ok=True)
    if "templates/1_cta_incremental.sql" in base_models_template_list:
            os.makedirs(os.path.join(base_dir, sync_name, "models/1_cta_incremental"), exist_ok=True)

    os.makedirs(os.path.join(base_dir, sync_name, "models/0_ctes"), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/2_partner_matviews"), exist_ok=True)
    
    print(f"Created directory structure for sync: {sync_name}")

def extract_column_names(client, project_id, dataset_id, table_id):
    query = f"SELECT column_name, data_type FROM {project_id}.{dataset_id}.INFORMATION_SCHEMA.COLUMNS WHERE table_name = '{table_id}'"
    query_job = client.query(query)
    columns = [(row["column_name"], row["data_type"]) for row in query_job]
    return columns

def generate_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_file, template_name, file_suffix):
    dataset_ref = client.dataset(dataset_id, project=project_id)
    tables = client.list_tables(dataset_ref)

    for table in tables:
        table_id = table.table_id

        # Skip tables that end with "_base" or start with "_"
        if table_id.endswith("_base") or table_id.startswith("_"):
            continue
        
        # Generate the appropriate table file name based on the file_suffix
        table_file_name = f"{table_id}{file_suffix}.sql"

        # Determine the appropriate subdirectory based on the template file name
        subdirectory = f"models/{template_name.replace('.sql', '')}"

        columns = extract_column_names(client, project_id, dataset_id, table_id)

        # Create a list of all columns (no quotes, single indent after the first)
        all_columns = [field[0] for field in columns]
        all_columns_str = ",\n  ".join(all_columns)

        # Create a list of columns with data types string, int, float, bool, date, or timestamp
        columns_for_hashid = [f"'{field[0]}'" for field in columns if field[1] in ['STRING', 'INT64', 'FLOAT64', 'BOOL', 'DATE', 'TIMESTAMP']]

        # Indent twice for every element after the first without leading line break
        columns_for_hashid_str = ",\n  ".join(columns_for_hashid)

        # Create a context dictionary with the variables you want to pass to the template
        context = {
            "all_columns": all_columns_str,
            "columns_for_hashid": columns_for_hashid_str,
            "project": project_id,
            "dataset": dataset_id,
            "table": table_id
        }

        # Render the Jinja template with the context
        env = Environment(loader=FileSystemLoader(os.path.dirname(template_file)))
        template = env.get_template(os.path.basename(template_file))
        rendered_sql = template.render(**context)

        # Write the rendered SQL content to files in the specified subdirectory
        file_path = os.path.join(base_dir, sync_name, subdirectory, table_file_name)
        with open(file_path, "w") as sql_file:
            sql_file.write(rendered_sql)

        print(f"Generated models for table: {table_id} in {subdirectory}")

def generate_sources_yaml(client, base_dir, sync_name, project_id, dataset_id):
    # Fetch the list of tables from the BigQuery dataset
    dataset_ref = client.dataset(dataset_id, project=project_id)
    tables = client.list_tables(dataset_ref)
    table_list = [table.table_id for table in tables if not (table.table_id.endswith("_base") or table.table_id.startswith("_"))]

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
    sync_name = input("Enter sync name (default: test)") or "test"
    project_id = input("Enter project ID: ")
    dataset_id = input("Enter dataset ID (default: dbt_gen_science): ") or "dbt_gen_science"
    base_models_option = input("Which base models do you need generated? (1=full_refresh, 2=incremental, 3 or skip to generate both): ") or '3'

    base_dir = "../../dbt-cta"
    template_ctes = "templates/0_ctes.sql"
    
    client = bigquery.Client()

    base_models_option_mapping = {
        '1': ["templates/1_cta_full_refresh.sql"],
        '2': ["templates/1_cta_incremental.sql"],
        '3': ["templates/1_cta_full_refresh.sql","templates/1_cta_incremental.sql"]
    }

    base_models_template_list = base_models_option_mapping[base_models_option]

    # create the folders needed
    create_directory_structure(base_dir, sync_name, base_models_template_list)

    # generate base models
    for template_file in base_models_template_list:
        template_name=os.path.splitext(os.path.basename(template_file))[0]
        print(template_name)
        #generate_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_file, template_name, file_suffix = '_base')
    
    # generate CTE models
    #generate_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_file=template_ctes, template_name='0_ctes',file_suffix='_ab1')

    # generate sources.yml
    generate_sources_yaml(client, base_dir, sync_name, project_id, dataset_id)

    print("Script completed")

if __name__ == "__main__":
    main()
