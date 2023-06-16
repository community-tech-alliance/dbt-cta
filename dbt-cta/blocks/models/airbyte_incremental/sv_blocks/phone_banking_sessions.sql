{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('phone_banking_sessions_scd') }}
select
    _airbyte_unique_key,
    completed_at,
    phone_bank_id,
    updated_at,
    user_id,
    created_at,
    id,
    caller_survey_response,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_banking_sessions_hashid
from {{ ref('phone_banking_sessions_scd') }}
-- phone_banking_sessions from {{ source('sv_blocks', '_airbyte_raw_phone_banking_sessions') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

