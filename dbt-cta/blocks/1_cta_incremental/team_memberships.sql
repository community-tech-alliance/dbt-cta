{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_memberships_scd') }}
select
    _airbyte_unique_key,
    member_id,
    updated_at,
    responsibility,
    created_at,
    id,
    team_id,
    responsibility_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_memberships_hashid
from {{ ref('team_memberships_scd') }}
-- team_memberships from {{ source('sv_blocks', '_airbyte_raw_team_memberships') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

