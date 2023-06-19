{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('quality_control_phone_verification_calls_ab4') }}
select
    number,
    external,
    updated_at,
    voter_registration_scan_id,
    user_id,
    twilio_call_id,
    created_at,
    id,
    disconnected_at,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_quality_control_phone_verification_calls_hashid
from {{ ref('quality_control_phone_verification_calls_ab4') }}
