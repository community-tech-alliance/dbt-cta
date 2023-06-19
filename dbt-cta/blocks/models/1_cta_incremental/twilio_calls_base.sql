{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('twilio_calls_ab4') }}
select
    updated_at,
    user_id,
    remote_id,
    created_at,
    phone_number,
    id,
    scan_id,
    disconnected_at,
    duration_in_seconds,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_twilio_calls_hashid
from {{ ref('twilio_calls_ab4') }}

