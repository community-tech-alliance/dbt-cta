import os
from jinja2 import Template

"""
This script generates deduping CTEs for all tables in the 0_ctes folder.
This is specifically for use with dbt projects that have 3 CTEs in 0_ctes.
(For example, ones originally created using the BQ V1 destination in Airbyte.)

Example usage:

cd utils/generate_dbt
pipenv run python generate_deduping_ctes.py

"""

def main():
    # Ask the user for the sync name
    sync_name = input("Enter the sync name: ")

    # Construct the folder path based on the sync name
    folder_path = f"../../dbt-cta/{sync_name}/models/0_ctes"

    # Read the template from the separate .sql file
    with open("templates/0_ctes_ab4.sql", "r") as template_file:
        template_content = template_file.read()

    # Create a Jinja2 template from the template content
    template = Template(template_content)

    # Iterate through all files in the folder
    for filename in os.listdir(folder_path):
        if filename.endswith("_ab3.sql"):
            # Extract the table name from the filename
            table = filename.replace("_ab3.sql", "")

            # Check if _ab4.sql already exists for this table
            new_filename = f"{table}_ab4.sql"
            if not os.path.exists(os.path.join(folder_path, new_filename)):
                # Render the SQL template with the table name
                sql_content = template.render(table=table)

                # Write the SQL content to the new file
                with open(os.path.join(folder_path, new_filename), "w") as new_file:
                    new_file.write(sql_content)

    # Update references in _base models (find and replace '_ab3' with '_ab4' in folders starting with '1_')
    models_path = f"../../dbt-cta/{sync_name}/models"
    for root, dirs, files in os.walk(models_path):
        for dir_name in dirs:
            if dir_name.startswith("1_"):
                dir_path = os.path.join(root, dir_name)
                for file_name in os.listdir(dir_path):
                    if file_name.endswith(".sql"):
                        file_path = os.path.join(dir_path, file_name)
                        with open(file_path, "r") as file:
                            content = file.read()
                        content = content.replace("_ab3", "_ab4")
                        with open(file_path, "w") as file:
                            file.write(content)
            
if __name__ == "__main__":
    main()
