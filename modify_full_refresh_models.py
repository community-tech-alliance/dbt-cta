import os
import glob
import argparse

"""
Does some annoying string replacement things in the auto-generated dbt files
(specifically for full refresh models)

1) add the "set partitions_to_replace" macro at the top
2) remove the line with "schema =" in it
3) remove the "post_hook" config - what even is that?
4) replace the where clause at the end to implement the partition replacement logic

Usage:

Run the script and add the name of the model you want to run this for (eg empower):

```
python modify_full_refresh_models.py empower
```
"""


# Set up argument parsing
parser = argparse.ArgumentParser(description="Add a block of text to the beginning of multiple SQL files.")
parser.add_argument("model_name", help="Name of the dbt model (eg., empower)")
args = parser.parse_args()

# Get the directory where your SQL files are located from the command line argument
sql_files_directory = f"./dbt-cta/{args.model_name}/models/1_cta_full_refresh"

# Add partition replacement macro at the top of the file
set_partitions_to_replace = """{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
"""

# partition-based filter (replaces "where 1=1")
default_filter = "where 1 = 1"
partition_filter = """\
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
"""

# Find all the .sql files in the specified directory
os.chdir(sql_files_directory)
sql_files = glob.glob('*.sql')

for file_path in sql_files:

    file_stem = os.path.splitext(file_path)[0]
    renamed_file_path = file_path.replace(file_stem, f"{file_stem}_base")

    # Remove the "post_hook" config
    with open(file_path, 'r+') as input_file:
        output_lines = []
        in_block = False
        for line in input_file:
            if 'post_hook = [' in line:
                in_block = True
            elif in_block and line.endswith('],\n'):
                in_block = False
            elif not in_block:
                output_lines.append(line)

    # Create a new file filtering out the lines we don't want
    with open(renamed_file_path, 'w', encoding='utf-8') as revised_file:
        # Remove the "schema =" config
        filtered_lines = [line for line in output_lines if "schema =" not in line]
        revised_file.writelines(filtered_lines)

    with open(renamed_file_path, 'r+') as revised_file:
        content = revised_file.read()

        # Replace "where 1=1" with the partition filter
        content = content.replace(default_filter, partition_filter)

        # Add the "set partitions_to_replace" macro at the top
        revised_file.seek(0)
        revised_file.write(set_partitions_to_replace + content)

        # Remove the original file
        os.remove(file_path)
