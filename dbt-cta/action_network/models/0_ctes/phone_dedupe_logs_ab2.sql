{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('phone_dedupe_logs_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(owner_id as {{ dbt_utils.type_bigint() }}) as owner_id,
    cast(source_id as {{ dbt_utils.type_bigint() }}) as source_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(owner_type as {{ dbt_utils.type_string() }}) as owner_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(source_type as {{ dbt_utils.type_string() }}) as source_type,
    cast(kept_core_field_id as {{ dbt_utils.type_bigint() }}) as kept_core_field_id,
    cast(removed_core_field_id as {{ dbt_utils.type_bigint() }}) as removed_core_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('phone_dedupe_logs_ab1') }}
-- phone_dedupe_logs
where 1 = 1

