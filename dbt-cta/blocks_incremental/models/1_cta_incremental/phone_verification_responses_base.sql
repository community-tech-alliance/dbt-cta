{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_verification_responses_ab4') }}
select
    round_number,
    notes,
    updated_at,
    voter_registration_scan_id,
    response,
    created_at,
    id,
    created_by_user_id,
    call_id,
    phone_verification_question_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_verification_responses_hashid
from {{ ref('phone_verification_responses_ab4') }}
