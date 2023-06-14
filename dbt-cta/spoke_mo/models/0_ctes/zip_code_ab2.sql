{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('zip_code_ab1') }}
select
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(timezone_offset as {{ dbt_utils.type_float() }}) as timezone_offset,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    {{ cast_to_boolean('has_dst') }} as has_dst,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('zip_code_ab1') }}
-- zip_code
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

