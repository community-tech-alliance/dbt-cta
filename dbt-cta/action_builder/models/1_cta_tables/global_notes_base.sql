{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('global_notes_ab3') }}
select
    id,
    text,
    owner_id,
    note_type,
    pinned_at,
    created_at,
    owner_type,
    updated_at,
    campaign_id,
    pinned_by_id,
    created_by_id,
    updated_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_global_notes_hashid
from {{ ref('global_notes_ab3') }}
-- global_notes from {{ source('cta', '_airbyte_raw_global_notes') }}
where 1 = 1

