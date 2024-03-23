{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ladders_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(structure as {{ dbt_utils.type_string() }}) as structure,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(auto_end_date as {{ dbt_utils.type_string() }}) as auto_end_date,
    cast(schedule_action as {{ dbt_utils.type_string() }}) as schedule_action,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ladders_ab1') }}
-- ladders
where 1 = 1
