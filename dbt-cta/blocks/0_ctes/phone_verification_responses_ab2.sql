{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('phone_verification_responses_ab1') }}
select
    cast(round_number as {{ dbt_utils.type_bigint() }}) as round_number,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(voter_registration_scan_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_id,
    cast(response as {{ dbt_utils.type_string() }}) as response,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(call_id as {{ dbt_utils.type_bigint() }}) as call_id,
    cast(phone_verification_question_id as {{ dbt_utils.type_bigint() }}) as phone_verification_question_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('phone_verification_responses_ab1') }}
-- phone_verification_responses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

