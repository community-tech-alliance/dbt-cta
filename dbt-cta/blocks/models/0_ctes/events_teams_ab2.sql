{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_teams_ab1') }}
select
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast(team_id as {{ dbt_utils.type_bigint() }}) as team_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_teams_ab1') }}
-- events_teams
where 1 = 1
