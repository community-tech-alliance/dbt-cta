{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('call_targets_ab4') }}
select
    id,
    uuid,
    bioid,
    status,
    call_id,
    created_at,
    updated_at,
    target_name,
    target_type,
    target_party,
    target_phone,
    target_state,
    call_duration,
    target_country,
    target_district,
    target_position,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_call_targets_hashid
from {{ ref('call_targets_ab4') }}
