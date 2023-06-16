{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('quality_control_phone_verification_calls_scd') }}
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
from {{ ref('quality_control_phone_verification_calls_scd') }}
-- quality_control_phone_verification_calls from {{ source('sv_blocks', '_airbyte_raw_quality_control_phone_verification_calls') }}

