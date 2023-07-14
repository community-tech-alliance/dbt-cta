import os
import yaml

##################################
### GENERATE SELECT statement ###
##################################
        
def generate_cte1_select_statement(data_fields_and_types):
    """
    Writes the first CTE for a single table.
    This CTE flattens the _airbyte_data JSON field.
    
    Params:
    - data_fields_and_types -> dict: maps field names to their data types, eg {"id":"integer","created_at":"timestamp"}
    """

    select_lines = ["\n    "]

    for field_name in data_fields_and_types.keys():
        select_line = f"{{{{ json_extract_scalar('_airbyte_data', ['{field_name}'], ['{field_name}']) }}}} as {field_name}"
        select_lines.append(select_line)

    select_lines.append('_airbyte_ab_id')
    select_lines.append('_airbyte_emitted_at')
    select_lines.append('{{ current_timestamp() }} as _airbyte_normalized_at')
    cte1_select_statement = ",\n    ".join(select_lines[1:])

    return cte1_select_statement
    
        
def generate_cte2_select_statement(data_fields_and_types):
    """
    Writes the seconds CTE for a single table.
    This CTE casts fields to data types.
    
    Params:
    - data_fields_and_types -> dict: maps field names to their data types, eg {"id":"integer","created_at":"timestamp"}
    """

    select_lines = ["\n    "]

    for field_name,data_type in data_fields_and_types.items():
        if data_type=="timestamp":
            select_line = f"cast({{{{ empty_string_to_null('{field_name}') }}}} as {{{{ type_timestamp_without_timezone() }}}}) as {field_name}"
        else:
            select_line = f"cast({field_name} as {{{{ dbt_utils.type_{data_type}() }}}}) as {field_name}"
        select_lines.append(select_line)

    select_lines.append('_airbyte_ab_id')
    select_lines.append('_airbyte_emitted_at')
    select_lines.append('_airbyte_normalized_at')
    cte2_select_statement = ",\n    ".join(select_lines[1:])

    return cte2_select_statement


def generate_cte3_select_statement(data_fields_and_types,table_id):
    """
    Writes the third CTE for a single table.
    This CTE generates a unique row id consisting of a hash of all the fields in the table.
    
    Params:
    - data_fields_and_types -> dict: maps field names to their data types, eg {"id":"integer","created_at":"timestamp"}
    - table_id -> str: used for naming the hashid field
    """


    field_names_list = list(data_fields_and_types.keys())
    field_names_formatted = ("',\n        '").join(field_names_list)
    
    cte3_select_statement = f"""
    {{{{ dbt_utils.surrogate_key([
        '{field_names_formatted}'
    ]) }}}} as _airbyte_{table_id}_hashid,
    tmp.*
    """

    return cte3_select_statement


#########################
## WRITE FILE CONTENTS ##
#########################

def generate_file_contents_cte(
        select_statement,
        table_id,
        cte_number: int
):
    """
    Returns dbt model to create either CTE1 (unflattens the JSON in _airbyte_data)
    or CTE2 (casts to data types)

    Params:
    - select_statement: the stuff that actually goes into the SQL model
    - table_id: no prefixes or suffixes
    - cte_number -> integer: indicates which CTE is being written. {1, 2, 3}
    """

    if cte_number==1:
        data_source = f"{{{{ source('cta', '_airbyte_raw_{table_id}') }}}}"
    elif cte_number==2:
        data_source = f"{{{{ ref('{table_id}_ab1') }}}}"
    elif cte_number==3:
        data_source = f"{{{{ ref('{table_id}_ab2') }}}}"
    else:
        raise ValueError("cte_number must be an integer between 1 and 3")
    
    file_contents = f"""
{{{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {{"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}},
    unique_key = '_airbyte_ab_id',
) }}}}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {data_source}

select
    {select_statement}
from {data_source} as tmp
where 1 = 1
{{{{ incremental_clause('_airbyte_emitted_at') }}}}"""

    return file_contents


def generate_file_contents_base_full_refresh(
        data_fields_and_types,
        table_id
):
    """
    Returns dbt model to create _base model using full refresh sync mode

    Params:
    - select_statement: the stuff that actually goes into the SQL model
    - table_id: no prefixes or suffixes
    """


    field_names_list = list(data_fields_and_types.keys())
    field_names_formatted = (",\n    ").join(field_names_list)
    
    file_contents = f"""
{{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}}

{{{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {{"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}},
    unique_key = '_airbyte_{table_id}_hashid'
) }}}}

-- Final base SQL model
-- depends_on: {{{{ ref('{table_id}_ab3') }}}}
select
    {field_names_formatted},
    _airbyte_{table_id}_hashid,
    _airbyte_ab_id,
    _airbyte_normalized_at,
    _airbyte_emitted_at
from {{{{ ref('{table_id}_ab3') }}}}
{{% if is_incremental() %}}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{{{ partitions_to_replace | join(',') }}}})
{{% endif %}}"""

    return file_contents

def generate_file_contents_matview(
        data_fields_and_types,
        table_id
):
    
    field_names_list = list(data_fields_and_types.keys())
    field_names_formatted = (",\n    ").join(field_names_list)
    
    file_contents = f"""
{{{{ config(
	auto_refresh = false,
	full_refresh = false
)}}}}

SELECT
    {field_names_formatted},
    _airbyte_{table_id}_hashid,
    _airbyte_ab_id,
    _airbyte_emitted_at
FROM {{{{ source('cta', '{table_id}_base') }}}}"""

    return file_contents


############################
##### CREATE THE FILES #####
############################

def create_sources_yaml(tables_list,path_to_models_folder):
    """
    Create the sources.yml file

    Params:
    - tables_list: list of relevant tables in the dataset (['foo','bar'])
    
    """

    source_tables_list = [{"name": f"_airbyte_raw_{table}"} for table in tables_list]\
                         + [{"name": f"{table}_base"} for table in tables_list] 
    sources_dict = {
        "version": 2,
        "sources": [
            {
                "name": "cta",
                "database": '{{ env_var("CTA_PROJECT_ID") }}',
                "schema": '{{ env_var("CTA_DATASET_ID") }}',
                "tables": source_tables_list
            }
        ]
    }   
    # Write the sources.yml file
    sources_yml_file_name = os.path.join(path_to_models_folder, "sources.yml")
    with open(sources_yml_file_name, "w") as sources_yml_file:
        yaml.dump(sources_dict,
                  sources_yml_file,
                  sort_keys=False,
                  default_flow_style=False,
                  default_style=''
                  )

def write_dbt_file_cte1(table_id,
                        data_fields_and_types,
                        path_to_models_folder
                        ):
    
    cte1_select_statement = generate_cte1_select_statement(
        data_fields_and_types=data_fields_and_types
    )

    cte1_file_contents = generate_file_contents_cte(
        select_statement=cte1_select_statement,
        table_id=table_id,
        cte_number=1)

    file_path = os.path.join(path_to_models_folder,f"0_ctes/{table_id}_ab1.sql")

    print(f"Writing CTE1 model to {file_path}")
    with open(file_path, "w") as f:
        f.write(cte1_file_contents)

def write_dbt_file_cte2(table_id,
                        data_fields_and_types,
                        path_to_models_folder
                        ):
    
    cte2_select_statement = generate_cte2_select_statement(
        data_fields_and_types=data_fields_and_types
    )

    cte2_file_contents = generate_file_contents_cte(
        select_statement=cte2_select_statement,
        table_id=table_id,
        cte_number=2)

    file_path = os.path.join(path_to_models_folder,f"0_ctes/{table_id}_ab2.sql")

    print(f"Writing CTE2 model to {file_path}")
    with open(file_path, "w") as f:
        f.write(cte2_file_contents)

def write_dbt_file_cte3(table_id,
                        data_fields_and_types,
                        path_to_models_folder
                        ):
    
    cte3_select_statement = generate_cte3_select_statement(
        table_id=table_id,
        data_fields_and_types=data_fields_and_types
    )

    cte3_file_contents = generate_file_contents_cte(
        select_statement=cte3_select_statement,
        table_id=table_id,
        cte_number=3)

    file_path = os.path.join(path_to_models_folder,f"0_ctes/{table_id}_ab3.sql")

    print(f"Writing CTE3 model to {file_path}")
    with open(file_path, "w") as f:
        f.write(cte3_file_contents)
    
    return None

def write_dbt_file_base(table_id,
                        data_fields_and_types,
                        path_to_models_folder
                        # TODO add param to toggle incremental mode
                        ):

    base_file_contents = generate_file_contents_base_full_refresh(
        data_fields_and_types=data_fields_and_types,
        table_id=table_id)

    file_path = os.path.join(path_to_models_folder,f"1_cta_full_refresh/{table_id}_base.sql")

    print(f"Writing base model to {file_path}")
    with open(file_path, "w") as f:
        f.write(base_file_contents)
    
    return None

def write_dbt_file_matview(table_id,
                        data_fields_and_types,
                        path_to_models_folder
                        ):

    matview_file_contents = generate_file_contents_matview(
        data_fields_and_types=data_fields_and_types,
        table_id=table_id)

    file_path = os.path.join(path_to_models_folder,f"2_partner_matviews/{table_id}.sql")

    print(f"Writing partner matview model to {file_path}")
    with open(file_path, "w") as f:
        f.write(matview_file_contents)
    
    return None

def write_all_cte_models(table_id,
                        data_fields_and_types,
                        path_to_models_folder
                        ):

    write_dbt_file_cte1(table_id=table_id,
                        data_fields_and_types=data_fields_and_types,
                        path_to_models_folder=path_to_models_folder
                        )
    
    write_dbt_file_cte2(table_id=table_id,
                        data_fields_and_types=data_fields_and_types,
                        path_to_models_folder=path_to_models_folder
                        )

    write_dbt_file_cte3(table_id=table_id,
                        data_fields_and_types=data_fields_and_types,
                        path_to_models_folder=path_to_models_folder
                        )

    write_dbt_file_base(table_id=table_id,
                        data_fields_and_types=data_fields_and_types,
                        path_to_models_folder=path_to_models_folder
                        )
    
    write_dbt_file_matview(table_id=table_id,
                        data_fields_and_types=data_fields_and_types,
                        path_to_models_folder=path_to_models_folder
                        )

    return "Done writing dbt files, congratulations"