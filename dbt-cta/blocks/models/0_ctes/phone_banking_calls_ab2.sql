{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('phone_banking_calls_ab1') }}
select
    cast(phone_bank_id as {{ dbt_utils.type_bigint() }}) as phone_bank_id,
    cast(round_canvass_status as {{ dbt_utils.type_string() }}) as round_canvass_status,
    cast(called_by_user_id as {{ dbt_utils.type_bigint() }}) as called_by_user_id,
    {{ cast_to_boolean('participated') }} as participated,
    cast(twilio_call_id as {{ dbt_utils.type_bigint() }}) as twilio_call_id,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(non_participation_reason as {{ dbt_utils.type_string() }}) as non_participation_reason,
    {{ cast_to_boolean('external') }} as external,
    cast(round as {{ dbt_utils.type_bigint() }}) as round,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('locked_at') }} as {{ type_timestamp_without_timezone() }}) as locked_at,
    cast(locked_by_user_id as {{ dbt_utils.type_bigint() }}) as locked_by_user_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('phone_banking_calls_ab1') }}
-- phone_banking_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

