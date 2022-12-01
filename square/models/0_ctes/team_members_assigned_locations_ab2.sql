{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('team_members_assigned_locations_ab1') }}
select
    _airbyte_team_members_hashid,
    cast(assignment_type as {{ dbt_utils.type_string() }}) as assignment_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_members_assigned_locations_ab1') }}
-- assigned_locations at team_members/assigned_locations
where 1 = 1

