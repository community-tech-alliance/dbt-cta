{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('usage_records_ab1') }}
select
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(as_of as {{ dbt_utils.type_string() }}) as as_of,
    cast(count as {{ dbt_utils.type_bigint() }}) as count,
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(usage as {{ dbt_utils.type_float() }}) as usage,
    cast(category as {{ dbt_utils.type_string() }}) as category,
    cast({{ empty_string_to_null('end_date') }} as {{ type_date() }}) as end_date,
    cast(count_unit as {{ dbt_utils.type_string() }}) as count_unit,
    cast(price_unit as {{ dbt_utils.type_string() }}) as price_unit,
    cast({{ empty_string_to_null('start_date') }} as {{ type_timestamp_with_timezone() }}) as start_date,
    cast(usage_unit as {{ dbt_utils.type_string() }}) as usage_unit,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(subresource_uris as {{ type_json() }}) as subresource_uris,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('usage_records_ab1') }}
-- usage_records
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

