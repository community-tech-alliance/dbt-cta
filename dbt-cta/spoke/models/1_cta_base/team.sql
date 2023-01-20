{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_ab3') }}
select
    id,
    title,
    author_id,
    created_at,
    text_color,
    updated_at,
    description,
    assignment_type,
    organization_id,
    background_color,
    max_request_count,
    assignment_priority,
    is_assignment_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_hashid
from {{ ref('team_ab3') }}
-- team from {{ source('public', '_airbyte_raw_team') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

