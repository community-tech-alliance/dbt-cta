{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_ab3') }}
select
    updated_at,
    turf_id,
    organizer_id,
    name,
    creator_id,
    active,
    extras,
    created_at,
    leader_id,
    members_count,
    id,
    slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_teams_hashid
from {{ ref('teams_ab3') }}
-- teams from {{ source('sv_blocks', '_airbyte_raw_teams') }}

