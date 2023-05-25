{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('call_targets_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(bioid as {{ dbt_utils.type_string() }}) as bioid,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(call_id as {{ dbt_utils.type_bigint() }}) as call_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(target_name as {{ dbt_utils.type_string() }}) as target_name,
    cast(target_type as {{ dbt_utils.type_string() }}) as target_type,
    cast(target_party as {{ dbt_utils.type_string() }}) as target_party,
    cast(target_phone as {{ dbt_utils.type_string() }}) as target_phone,
    cast(target_state as {{ dbt_utils.type_string() }}) as target_state,
    cast(call_duration as {{ dbt_utils.type_bigint() }}) as call_duration,
    cast(target_country as {{ dbt_utils.type_string() }}) as target_country,
    cast(target_district as {{ dbt_utils.type_string() }}) as target_district,
    cast(target_position as {{ dbt_utils.type_string() }}) as target_position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('call_targets_ab1') }}
-- call_targets
where 1 = 1

