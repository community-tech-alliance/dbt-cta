import os
from google.cloud import bigquery
from jinja2 import Environment, FileSystemLoader

def create_directory_structure(base_dir, sync_name):
    os.makedirs(os.path.join(base_dir, sync_name), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/0_ctes"), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/1_cta_full_refresh"), exist_ok=True)
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
        
        print(f"Generated SQL file for table: {table_id}")

def main():
    sync_name = input("Enter sync name (default: test)") or "test"
    project_id = input("Enter project ID (default: dev3869c056): ") or "dev3869c056"
    dataset_id = input("Enter dataset ID (default: dbt_gen_science): ") or "dbt_gen_science"
    
    base_dir = "../../dbt-cta"
    template_file = "template.sql"  # Specify the template file name
    
    client = bigquery.Client()
    
    create_directory_structure(base_dir, sync_name)
    generate_cte_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_file)
    
    print("Script completed successfully.")

if __name__ == "__main__":
    main()
