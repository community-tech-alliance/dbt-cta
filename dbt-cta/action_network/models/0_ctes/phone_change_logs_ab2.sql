{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('phone_change_logs_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(owner_id as {{ dbt_utils.type_bigint() }}) as owner_id,
    cast(new_phone as {{ dbt_utils.type_string() }}) as new_phone,
    cast(old_phone as {{ dbt_utils.type_string() }}) as old_phone,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(owner_type as {{ dbt_utils.type_string() }}) as owner_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(source_action_id as {{ dbt_utils.type_bigint() }}) as source_action_id,
    cast(source_action_type as {{ dbt_utils.type_string() }}) as source_action_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('phone_change_logs_ab1') }}
-- phone_change_logs
where 1 = 1
