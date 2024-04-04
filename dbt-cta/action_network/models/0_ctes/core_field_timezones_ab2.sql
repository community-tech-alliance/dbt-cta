{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('core_field_timezones_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(core_field_id as {{ dbt_utils.type_bigint() }}) as core_field_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('core_field_timezones_ab1') }}
-- core_field_timezones
where 1 = 1
