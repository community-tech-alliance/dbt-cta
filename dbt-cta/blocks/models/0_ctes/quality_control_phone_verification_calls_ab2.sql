{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quality_control_phone_verification_calls_ab1') }}
select
    cast(number as {{ dbt_utils.type_string() }}) as number,
    {{ cast_to_boolean('external') }} as external,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(voter_registration_scan_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(twilio_call_id as {{ dbt_utils.type_bigint() }}) as twilio_call_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('disconnected_at') }} as {{ type_timestamp_without_timezone() }}) as disconnected_at,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quality_control_phone_verification_calls_ab1') }}
-- quality_control_phone_verification_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

