{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('phone_banking_sessions_ab1') }}
select
    cast({{ empty_string_to_null('completed_at') }} as {{ type_timestamp_without_timezone() }}) as completed_at,
    cast(phone_bank_id as {{ dbt_utils.type_bigint() }}) as phone_bank_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(caller_survey_response as {{ dbt_utils.type_bigint() }}) as caller_survey_response,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('phone_banking_sessions_ab1') }}
-- phone_banking_sessions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

