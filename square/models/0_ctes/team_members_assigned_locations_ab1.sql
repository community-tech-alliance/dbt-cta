{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('team_members') }}
select
    _airbyte_team_members_hashid,
    {{ json_extract_scalar('assigned_locations', ['assignment_type'], ['assignment_type']) }} as assignment_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_members_base') }} as table_alias
-- assigned_locations at team_members/assigned_locations
where 1 = 1
and assigned_locations is not null

