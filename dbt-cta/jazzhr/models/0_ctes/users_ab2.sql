{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(date_created as {{ dbt_utils.type_string() }}) as date_created,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    _airbyte_raw_id,
    _airbyte_extracted_at,

    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1
