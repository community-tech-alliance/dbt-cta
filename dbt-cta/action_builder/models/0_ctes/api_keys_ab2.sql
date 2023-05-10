{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('api_keys_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(target as {{ dbt_utils.type_string() }}) as target,
    cast(api_key as {{ dbt_utils.type_string() }}) as api_key,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('revoked_at') }} as {{ type_timestamp_without_timezone() }}) as revoked_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(revoked_by_id as {{ dbt_utils.type_bigint() }}) as revoked_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('api_keys_ab1') }}
-- api_keys
where 1 = 1

