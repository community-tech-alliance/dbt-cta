{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('ladders_ab4') }}
select
    id,
    notes,
    stats,
    title,
    hidden,
    status,
    group_id,
    structure,
    created_at,
    creator_id,
    updated_at,
    auto_end_date,
    schedule_action,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ladders_hashid
from {{ ref('ladders_ab4') }}