{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teams_export_ab1') }}
select
    cast(member_phone as {{ dbt_utils.type_string() }}) as member_phone,
    cast(member_email as {{ dbt_utils.type_string() }}) as member_email,
    cast(member_user_id as {{ dbt_utils.type_bigint() }}) as member_user_id,
    cast(member_performs as {{ dbt_utils.type_bigint() }}) as member_performs,
    cast(team_id as {{ dbt_utils.type_bigint() }}) as team_id,
    cast(team_rank as {{ dbt_utils.type_bigint() }}) as team_rank,
    cast(team_leaderboard_score as {{ dbt_utils.type_bigint() }}) as team_leaderboard_score,
    cast(team_name as {{ dbt_utils.type_string() }}) as team_name,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(team_leaderboard_performs as {{ dbt_utils.type_bigint() }}) as team_leaderboard_performs,
    cast(member_fullname as {{ dbt_utils.type_string() }}) as member_fullname,
    cast(team_leader_ids as {{ dbt_utils.type_string() }}) as team_leader_ids,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(member_score as {{ dbt_utils.type_bigint() }}) as member_score,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams_export_ab1') }}
-- teams_export
where 1 = 1

