{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('team_member_wages_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hourly_rate as {{ type_json() }}) as hourly_rate,
    cast(team_member_id as {{ dbt_utils.type_string() }}) as team_member_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_member_wages_ab1') }}
-- team_member_wages
where 1 = 1

