"""
This script updates SQL files in a specified directory by adding a defined string
to the beginning of each file and replacing a specified string with a new string.
After processing the files, the script renames the folder containing the modified
SQL files to "1_cta_full_refresh".

The script performs the following operations on each SQL file in the specified folder:
1. Adds the following string to the beginning of the file:
    {% set partitions_to_replace = [
        'timestamp_trunc(current_timestamp, day)',
        'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
    ] %}
2. Replaces the following string:
    where 1 = 1
    {{ incremental_clause('_airbyte_emitted_at') }}
   with this new string:
    {% if is_incremental() %}
    where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
    {% endif %}

Example usage:

1. run this command from dbt-cta/utils: ```python convert_to_full_refresh.py```
2. When prompted, enter the path to the folder containing the SQL files you want to modify.
   Example input: ../dbt-cta/stripe/models/1_cta_tables
3. The script will update the SQL files in the specified folder and rename the folder to "1_cta_full_refresh".
4. Test that your new dbt is working as intended:

```
cd ../dbt-cta
pipenv run dbt run --target cta --select tag:cta
```

"""


import os

# Define the string to add to SQL files
string_to_add = """{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

"""

# Define the strings for replacement
old_string_1 = """
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}
"""
old_string_2 = """
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}
"""
new_string = """
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
"""

# Prompt the user for a path to the folder
folder_path = input("""
Enter the path to the folder containing the SQL files
(e.g., ../dbt-cta/stripe/models/1_cta_tables):
""")

# Iterate through the files in the specified folder
for filename in os.listdir(folder_path):
    # Check if the file is an SQL file
    if filename.endswith('.sql'):
        # Read the content of the file
        with open(os.path.join(folder_path, filename), 'r') as file:
            file_content = file.read()
        
        # Add the string to the beginning of the file content
        new_file_content = string_to_add + file_content
        
        # Replace the old string with the new string
        new_file_content = new_file_content.replace(old_string_1, new_string)
        new_file_content = new_file_content.replace(old_string_2, new_string)
        
        # Write the new content to the file
        with open(os.path.join(folder_path, filename), 'w') as file:
            file.write(new_file_content)

        print(f"Updated file: {filename}")

# Rename the folder
parent_folder = os.path.dirname(folder_path)
new_folder_name = "1_cta_full_refresh"
new_folder_path = os.path.join(parent_folder, new_folder_name)
os.rename(folder_path, new_folder_path)
print(f"Renamed folder: {folder_path} to {new_folder_path}")
