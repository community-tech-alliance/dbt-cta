{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('notes_scd') }}
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
from {{ ref('notes_scd') }}
-- notes from {{ source('sv_blocks', '_airbyte_raw_notes') }}

