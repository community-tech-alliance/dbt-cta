{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('quality_control_flags_scd') }}
select
    notes,
    canvasser_id,
    trigger_id,
    reviewed_at,
    created_at,
    completed_at,
    ready_at,
    updated_at,
    packet_id,
    action_plan,
    triggered_by_shift_id,
    id,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_quality_control_flags_hashid
from {{ ref('quality_control_flags_scd') }}
-- quality_control_flags from {{ source('sv_blocks', '_airbyte_raw_quality_control_flags') }}

