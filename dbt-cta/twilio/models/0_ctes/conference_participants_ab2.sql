{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('conference_participants_ab1') }}
select
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    {{ cast_to_boolean('hold') }} as hold,
    cast(label as {{ dbt_utils.type_string() }}) as label,
    {{ cast_to_boolean('muted') }} as muted,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(call_sid as {{ dbt_utils.type_string() }}) as call_sid,
    {{ cast_to_boolean('coaching') }} as coaching,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(conference_sid as {{ dbt_utils.type_string() }}) as conference_sid,
    cast(call_sid_to_coach as {{ dbt_utils.type_string() }}) as call_sid_to_coach,
    {{ cast_to_boolean('end_conference_on_exit') }} as end_conference_on_exit,
    {{ cast_to_boolean('start_conference_on_enter') }} as start_conference_on_enter,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('conference_participants_ab1') }}
-- conference_participants
where 1 = 1
