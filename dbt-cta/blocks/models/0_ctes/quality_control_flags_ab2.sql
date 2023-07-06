{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quality_control_flags_ab1') }}
select
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(canvasser_id as {{ dbt_utils.type_bigint() }}) as canvasser_id,
    cast(trigger_id as {{ dbt_utils.type_bigint() }}) as trigger_id,
    cast({{ empty_string_to_null('reviewed_at') }} as {{ type_timestamp_without_timezone() }}) as reviewed_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('completed_at') }} as {{ type_timestamp_without_timezone() }}) as completed_at,
    cast({{ empty_string_to_null('ready_at') }} as {{ type_timestamp_without_timezone() }}) as ready_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(packet_id as {{ dbt_utils.type_bigint() }}) as packet_id,
    cast(action_plan as {{ dbt_utils.type_string() }}) as action_plan,
    cast(triggered_by_shift_id as {{ dbt_utils.type_bigint() }}) as triggered_by_shift_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quality_control_flags_ab1') }}
-- quality_control_flags
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

