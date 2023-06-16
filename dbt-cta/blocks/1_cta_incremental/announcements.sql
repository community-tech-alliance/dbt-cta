{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('announcements_ab3') }}
select
    starts_at,
    updated_at,
    user_id,
    created_at,
    id,
    ends_at,
    message,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_announcements_hashid
from {{ ref('announcements_ab3') }}
-- announcements from {{ source('sv_blocks', '_airbyte_raw_announcements') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

