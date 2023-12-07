import os
from google.cloud import bigquery

# Define your template with a comment and a placeholder for column names
template = "-- This is a template file.\nSELECT\n{columns}\nFROM `{project}.{dataset}.{table}`"

def create_directory_structure(base_dir, sync_name):
    os.makedirs(os.path.join(base_dir, sync_name), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/0_ctes"), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/1_cta_full_refresh"), exist_ok=True)
    os.makedirs(os.path.join(base_dir, sync_name, "models/2_partner_matviews"), exist_ok=True)

def extract_column_names(client, project_id, dataset_id, table_id):
    query = f"SELECT column_name, data_type FROM {project_id}.{dataset_id}.INFORMATION_SCHEMA.COLUMNS WHERE table_name = '{table_id}'"
    query_job = client.query(query)
    columns = [(row["column_name"], row["data_type"]) for row in query_job]
    return columns

def generate_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_file):
    dataset_ref = client.dataset(dataset_id, project=project_id)
    tables = client.list_tables(dataset_ref)
    
    with open(template_file, "r") as template_file:
        template_content = template_file.read()
    
    for table in tables:
        table_id = table.table_id
        columns = extract_column_names(client, project_id, dataset_id, table_id)
        
        print("All columns:")
        print(columns)
        
        # Create a list of fields with data types string, int, float, or bool
        valid_fields = [f"{field[0]}" for field in columns if field[1] in ['STRING', 'INT64', 'FLOAT64', 'BOOL'] and not field[0].startswith('_airbyte_')]
        
        print("Valid columns: ")
        print(valid_fields)

        # Create SQL content by replacing the {columns} placeholder in the template
        sql_content = template_content.format(columns=',\n'.join(valid_fields), project=project_id, dataset=dataset_id, table=table_id)
        
        # Write the SQL content to a file in the appropriate directory
        file_path = os.path.join(base_dir, sync_name, f"models/0_ctes/{table_id}.sql")
        with open(file_path, "w") as sql_file:
            sql_file.write(sql_content)

def main():
    sync_name = input("Enter sync name (default: sync_default): ") or "test"
    project_id = input("Enter project ID (default: your_project_id): ") or "dev3869c056"
    dataset_id = input("Enter dataset ID (default: your_dataset_id): ") or "dbt_gen_science"
    
    base_dir = "../../dbt-cta"
    template_file = "template.sql"  # Specify the template file name

    client = bigquery.Client()
    
    print("Creating folders to contain new dbt models.")
    create_directory_structure(base_dir, sync_name)
    print(f"Generating dbt models for tables in {project_id}.{dataset_id}.")
    generate_sql_files(client, base_dir, sync_name, project_id, dataset_id, template_file)
    
    print("Script completed successfully.")

if __name__ == "__main__":
    main()