import os

"""
Run this script in the 2_partner_matviews folder where you want to create your matview models.
Note that YOU must populate the list `table_names` with a list of strings containing the names of all your base tables.
"""

def create_sql_files(table_names):
    for table in table_names:
        # Remove "_base" from the end of the table name if it exists
        filename = table
        if table.endswith("_base"):
            filename = table[:-5]
        
        # Create a new .sql file
        with open(f"{filename}.sql", "w") as file:
            # Add SQL to the file
            file.write(f"""
SELECT
    *
FROM {{{{ source('cta', '{table}') }}}}
;
""")

# TODO: Fill this list with your base table names
table_names = [
'foo_base',
'bar_base'
]

create_sql_files(table_names)



