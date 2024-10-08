{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_banking_calls_ab3') }}
select
    phone_bank_id,
    round_canvass_status,
    called_by_user_id,
    participated,
    twilio_call_id,
    extras,
    created_at,
    non_participation_reason,
    external,
    round,
    updated_at,
    locked_at,
    locked_by_user_id,
    id,
    status,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_banking_calls_hashid
from {{ ref('phone_banking_calls_ab3') }}
-- phone_banking_calls from {{ source('cta', '_airbyte_raw_phone_banking_calls') }}
