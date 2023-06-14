{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invite_ab1') }}
select
    {{ cast_to_boolean('is_valid') }} as is_valid,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ adapter.quote('hash') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('hash') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invite_ab1') }}
-- invite
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

