{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('queries_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(params as {{ dbt_utils.type_string() }}) as params,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('queries_ab1') }}
-- queries
where 1 = 1
