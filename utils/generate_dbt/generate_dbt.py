import os
from google.cloud import bigquery
from jinja2 import Environment, FileSystemLoader

def create_directory_structure(base_dir, sync_name):
    os.makedirs(os.path.join(base_dir, sync_name), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/0_ctes"), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/1_cta_full_refresh"), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/1_cta_incremental"), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/2_partner_matviews"), exist_ok=True)
    
    print(f"Created directory structure for sync: {sync_name}")

def extract_column_names(client, project_id, dataset_id, table_id):
    query = f"SELECT column_name, data_type FROM {project_id}.{dataset_id}.INFORMATION_SCHEMA.COLUMNS WHERE table_name = '{table_id}'"
    query_job = client.query(query)
    columns = [(row["column_name"], row["data_type"]) for row in query_job]
    return columns

def generate_cte_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_file):
    dataset_ref = client.dataset(dataset_id, project=project_id)
    tables = client.list_tables(dataset_ref)
    
    env = Environment(loader=FileSystemLoader(os.path.dirname(template_file)))
    template = env.get_template(os.path.basename(template_file))
    
    for table in tables:
        table_id = table.table_id
        
        # Ignore tables ending in "_base"
        if table_id.endswith("_base"):
            continue
        
        # Add "_ab1" suffix to the table file name
        table_file_name = f"{table_id}_ab1.sql"
        
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
        rendered_sql = template.render(**context)
        
        # Write the rendered SQL content to a file in the appropriate directory
        file_path = os.path.join(base_dir, sync_name, f"models/0_ctes/{table_file_name}")
        with open(file_path, "w") as sql_file:
            sql_file.write(rendered_sql)
        
        print(f"Generated CTE model for table: {table_id}")

def generate_base_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_full_refresh, template_incremental):
    dataset_ref = client.dataset(dataset_id, project=project_id)
    tables = client.list_tables(dataset_ref)

    for table in tables:
        table_id = table.table_id

        # Ignore tables ending in "_base"
        if table_id.endswith("_base"):
            continue

        # Add "_base" suffix to the table file name
        table_file_name = f"{table_id}_base.sql"

        columns = extract_column_names(client, project_id, dataset_id, table_id)

        # Create a list of all columns (no quotes, single indent after the first)
        all_columns = [field[0] for field in columns]
        all_columns_str = ",\n  ".join(all_columns)

        # Create a list of columns with data types string, int, float, bool, date, or timestamp
        columns_for_hashid = [f"'{field[0]}'" for field in columns if field[1] in ['STRING', 'INT64', 'FLOAT64', 'BOOL', 'DATE', 'TIMESTAMP']]

        # Indent twice for every element after the first without leading line break
        columns_for_hashid_str = ",\n  ".join(columns_for_hashid)

        # Create a context dictionary with the variables you want to pass to the templates
        context = {
            "all_columns": all_columns_str,
            "columns_for_hashid": columns_for_hashid_str,
            "project": project_id,
            "dataset": dataset_id,
            "table": table_id
        }

        # Render the Jinja templates with the common context
        env = Environment(loader=FileSystemLoader(os.path.dirname(template_full_refresh)))
        template_full_refresh = env.get_template(os.path.basename(template_full_refresh))
        rendered_sql_full_refresh = template_full_refresh.render(**context)

        env = Environment(loader=FileSystemLoader(os.path.dirname(template_incremental)))
        template_incremental = env.get_template(os.path.basename(template_incremental))
        rendered_sql_incremental = template_incremental.render(**context)

        # Determine the appropriate subdirectory based on the table name
        if table_id.endswith("_incremental"):
            subdirectory = "models/1_cta_incremental"
        else:
            subdirectory = "models/1_cta_full_refresh"

        # Write the rendered SQL content to a file in the appropriate directory
        file_path_full_refresh = os.path.join(base_dir, sync_name, subdirectory, table_file_name)
        with open(file_path_full_refresh, "w") as sql_file_full_refresh:
            sql_file_full_refresh.write(rendered_sql_full_refresh)

        file_path_incremental = os.path.join(base_dir, sync_name, subdirectory, table_file_name)
        with open(file_path_incremental, "w") as sql_file_incremental:
            sql_file_incremental.write(rendered_sql_incremental)

        print(f"Generated base models for table: {table_id}")

def main():
    sync_name = input("Enter sync name (default: test)") or "test"
    project_id = input("Enter project ID: ")
    dataset_id = input("Enter dataset ID (default: dbt_gen_science): ") or "dbt_gen_science"
    
    base_dir = "../../dbt-cta"
    template_ctes = "templates/0_ctes.sql"
    
    client = bigquery.Client()
    
    template_full_refresh = "templates/1_cta_full_refresh.sql"
    template_incremental = "templates/1_cta_incremental.sql"
    create_directory_structure(base_dir, sync_name)
    generate_cte_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_ctes)
    generate_base_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_full_refresh, template_incremental)

    print("Script completed successfully.")

if __name__ == "__main__":
    main()
