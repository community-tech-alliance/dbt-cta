{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('notes_ab3') }}
select
    updated_at,
    created_at,
    id,
    created_by_user_id,
    content,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_notes_hashid
from {{ ref('notes_ab3') }}
-- notes from {{ source('cta', '_airbyte_raw_notes') }}
