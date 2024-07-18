{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('activities_ab1') }}
select
    cast(date as {{ dbt_utils.type_string() }}) as date,
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    cast(action as {{ dbt_utils.type_string() }}) as action,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(time as {{ dbt_utils.type_string() }}) as time,
    cast(team_id as {{ dbt_utils.type_string() }}) as team_id,
    cast(category as {{ dbt_utils.type_string() }}) as category,
    cast(object_id as {{ dbt_utils.type_string() }}) as object_id,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('activities_ab1') }}
-- activities
where 1 = 1

