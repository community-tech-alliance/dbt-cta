{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('event_shifts_ab1') }}
select
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_without_timezone() }}) as start_time,
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('end_time') }} as {{ type_timestamp_without_timezone() }}) as end_time,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('event_shifts_ab1') }}
-- event_shifts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

