{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_scd') }}
select
    _airbyte_unique_key,
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
from {{ ref('teams_scd') }}
-- teams from {{ source('sv_blocks', '_airbyte_raw_teams') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

